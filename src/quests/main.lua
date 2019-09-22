local hero = require('src/hero.lua')
local log = require('src/log.lua')

local TYPE = {
    KILL = {},
}

local QUESTS

-- progress = {
--     [playerId] = {
--         [questId] = {
--             completed = bool,
--             objectives = {
--                 [objectiveId] = num/bool,
--             },
--         },
--     },
-- }
local progress = {}

-- questMarks = {
--     [questId] = texttag
-- }
local questMarks = {}

function onKill()
    -- Check unit id of killed unit, if it matches any active objectives
    -- for the player, then add to them
    -- TODO add to the entire players party
    local killingUnit = GetKillingUnit()
    local dyingUnit = GetDyingUnit()

    local playerId = GetPlayerId(GetOwningPlayer(killingUnit))

    for questId, progressInfo in pairs(progress[playerId]) do
        if not progressInfo.completed then
            for objectiveIdx, objectiveInfo in pairs(QUESTS[questId].objectives) do
                if
                    objectiveInfo.type == TYPE.KILL and
                    objectiveInfo.toKill == GetUnitTypeId(dyingUnit) and
                    objectiveInfo.amount ~= progress[playerId][questId].objectives[objectiveIdx]
                then
                    if progress[playerId][questId].objectives[objectiveIdx] == nil then
                        progress[playerId][questId].objectives[objectiveIdx] = 0
                    end
                    progress[playerId][questId].objectives[objectiveIdx] =
                        progress[playerId][questId].objectives[objectiveIdx] + 1
                    local numKilled =
                        progress[playerId][questId].objectives[objectiveIdx]
                    log.log(
                        playerId,
                        'You have killed '..
                            numKilled..
                            ' / '..
                            objectiveInfo.amount..
                            ' '..
                            objectiveInfo.name,
                        log.TYPE.INFO)
                    updateQuestMarks()
                end
            end
        end
    end
end

function updateQuestMarks()
    -- Loop through each quest, and update the questgiver
    -- mark to match the quest progress.
    local playerId = GetPlayerId(GetLocalPlayer())
    for questId, questInfo in pairs(QUESTS) do
        local tag = questMarks[questId]
        local text
        local color
        local showOnUnit
        if isEligibleForQuest(playerId, questId) then
            text = "!"
            color = {100, 100, 0}
            showOnUnit = questInfo.getQuestFrom
        elseif
            not questCompleted(playerId, questId) and
            not questObjectivesCompleted(playerId, questId)
        then
            text = "?"
            color = {50, 50, 50}
            showOnUnit = questInfo.handQuestTo
        elseif
            not questCompleted(playerId, questId) and
            questObjectivesCompleted(playerId, questId)
        then
            text = "?"
            color = {100, 100, 0}
            showOnUnit = questInfo.handQuestTo
        else
            text = ""
            color = {100, 100, 100}
            showOnUnit = questInfo.handQuestTo
        end
        SetTextTagText(tag, text, TextTagSize2Height(20))
        SetTextTagColor(tag, color[1], color[2], color[3], 0)
        SetTextTagPosUnit(tag, showOnUnit, 10)
    end
end

function initQuestMarks()
    for questId, questInfo in pairs(QUESTS) do
        local tag = CreateTextTag()
        SetTextTagText(tag, "!", TextTagSize2Height(20))
        SetTextTagPosUnit(tag, questInfo.getQuestFrom, 10)
        SetTextTagColor(tag, 100, 100, 0, 0)
        SetTextTagPermanent(tag, true)
        SetTextTagFadepoint(tag, 0.01)

        questMarks[questId] = tag
    end

    updateQuestMarks()
end

function questObjectivesCompleted(playerId, questId)
    if not hasQuest(playerId, questId) then
        return false
    end

    for idx, objectiveInfo in pairs(QUESTS[questId].objectives) do
        if
            objectiveInfo.amount ~= progress[playerId][questId].objectives[idx]
        then
            return false
        end
    end

    return true
end

function questCompleted(playerId, questId)
    return progress[playerId][questId] ~= nil and
        progress[playerId][questId].completed
end

function hasQuest(playerId, questId)
    return progress[playerId][questId] ~= nil
end

function isEligibleForQuest(playerId, questId)
    if hasQuest(playerId, questId) then
        return false
    end

    if questCompleted(playerId, questId) then
        return false
    end

    local level = GetHeroLevel(hero.getHero(playerId))
    if level < QUESTS[questId].levelRequirement then
        return false
    end

    for idx, prereqQuestId in pairs(QUESTS[questId].prerequisites) do
        if not questCompleted(playerId, prereqQuestId) then
            return false
        end
    end

    return true
end

function beginQuest(playerId, questId)
    progress[playerId][questId] = {
        completed = false,
        objectives = {},
    }
    log.log(playerId, QUESTS[questId].obtainText, log.TYPE.INFO)

    updateQuestMarks()
end

function finishQuest(playerId, questId)
    progress[playerId][questId].completed = true
    log.log(playerId, QUESTS[questId].completedText, log.TYPE.INFO)

    local expGained = QUESTS[questId].rewards.exp
    local goldGained = QUESTS[questId].rewards.gold

    if expGained ~= nil then
        log.log(
            playerId, 'You gained '..expGained..' experience.', log.TYPE.QUEST)
        AddHeroXP(hero.getHero(playerId), expGained, true)
    end

    if goldGained ~= nil then
        log.log(
            playerId, 'You gained '..goldGained..' gold.', log.TYPE.QUEST)
        local curGold = GetPlayerState(
            Player(playerId), PLAYER_STATE_RESOURCE_GOLD)
        SetPlayerState(
            Player(playerId), PLAYER_STATE_RESOURCE_GOLD, curGold + goldGained)
    end

    updateQuestMarks()
end

function onNpcClicked()
    -- Check if its a questgiver, and if the player is close enough.
    -- If they are, give them the quest.
    -- TODO If they aren't order them to move to the questgiver and wait X time
    -- Then check again after X time and try to give quest again
    local playerId = GetPlayerId(GetTriggerPlayer())
    local hero = hero.getHero(playerId)

    local selectedUnit = GetTriggerUnit()
    for questId, questInfo in pairs(QUESTS) do
        if
            questInfo.getQuestFrom == selectedUnit and
            IsUnitInRange(hero, selectedUnit, 300) and
            isEligibleForQuest(playerId, questId)
        then
            -- Time to get a new quest
            beginQuest(playerId, questId)
        elseif
            questInfo.handQuestTo == selectedUnit and
            IsUnitInRange(hero, selectedUnit, 300) and
            hasQuest(playerId, questId) and
            not questCompleted(playerId, questId)
        then
            if questObjectivesCompleted(playerId, questId) then
                finishQuest(playerId, questId)
            else
                log.log(playerId, QUESTS[questId].incompleteText, log.TYPE.ERROR)
            end
        end
    end
end

function initObjectiveTriggers()
    local killTrig = CreateTrigger()
    TriggerRegisterPlayerUnitEvent(
        killTrig,
        Player(PLAYER_NEUTRAL_AGGRESSIVE),
        EVENT_PLAYER_UNIT_DEATH,
        nil)
    TriggerAddAction(killTrig, onKill)
end

function resetQuestProgress(playerId)
    progress[playerId] = {}
    updateQuestMarks()
end

function getProgress(playerId)
    return progress[playerId]
end

function restoreProgress(playerId, prog)
    progress[playerId] = prog
    updateQuestMarks()
end

function getNumQuests()
    return #QUESTS
end

function initQuests()
    QUESTS = {
        [1] = {
            getQuestFrom = gg_unit_nvl2_0000,
            handQuestTo = gg_unit_nvl2_0000,
            obtainText = "Please kill 10 turtles.",
            incompleteText = "You haven't killed 10 turtles yet.",
            completedText = "Thanks.",
            rewards = {
                exp = 150,
                gold = 50,
            },
            objectives = {
                [1] = {
                    type = TYPE.KILL,
                    amount = 10,
                    toKill = FourCC('hmbs'),
                    name = 'Turtles',
                }
            },
            prerequisites = {},
            levelRequirement = 0,
        },
        [2] = {
            getQuestFrom = gg_unit_nvl2_0000,
            handQuestTo = gg_unit_nvil_0030,
            obtainText = "Please talk to Fred",
            incompleteText = "I don't think its possible to see this text.",
            completedText = "Hi I'm Fred.",
            rewards = {
                exp = 50,
                gold = 50,
            },
            objectives = {},
            prerequisites = {1},
            levelRequirement = 0,
        }
    }
end

function init()
    local selectTrig = CreateTrigger()
    for i=0,bj_MAX_PLAYERS-1,1 do
        TriggerRegisterPlayerUnitEvent(
            selectTrig, Player(i), EVENT_PLAYER_UNIT_SELECTED, nil)
    end
    TriggerAddAction(selectTrig, onNpcClicked)

    for i=0,bj_MAX_PLAYERS-1,1 do
        progress[i] = {}
    end

    initQuests()
    initObjectiveTriggers()
    initQuestMarks()

    hero.addRepickedListener(resetQuestProgress)
    hero.addHeroPickedListener(updateQuestMarks)
end

return {
    init = init,
    getProgress = getProgress,
    getNumQuests = getNumQuests,
    restoreProgress = restoreProgress,
}
