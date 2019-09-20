local hero = require('src/hero.lua')

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

    for questId, _ in pairs(progress[playerId]) do
        for objectiveIdx, objectiveInfo in pairs(QUESTS[questId].objectives) do
            if
                objectiveInfo.type == TYPE.KILL and
                objectiveInfo.toKill == GetUnitTypeId(dyingUnit)
            then
                if progress[playerId][questId].objectives[objectiveIdx] == nil then
                    progress[playerId][questId].objectives[objectiveIdx] = 0
                end
                progress[playerId][questId].objectives[objectiveIdx] = math.min(
                    progress[playerId][questId].objectives[objectiveIdx] + 1,
                    objectiveInfo.amount
                )
                print("Killed ", progress[playerId][questId].objectives[objectiveIdx], " / ", objectiveInfo.amount)
                updateQuestMarks()
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
        if isEligibleForQuest(playerId, questId) then
            text = "!"
            color = {100, 100, 0}
        elseif
            not questCompleted(playerId, questId) and
            not questObjectivesCompleted(playerId, questId)
        then
            text = "?"
            color = {50, 50, 50}
        elseif
            not questCompleted(playerId, questId) and
            questObjectivesCompleted(playerId, questId)
        then
            text = "?"
            color = {100, 100, 0}
        else
            text = ""
            color = {100, 100, 100}
        end
        SetTextTagText(tag, text, TextTagSize2Height(20))
        SetTextTagColor(tag, color[1], color[2], color[3], 0)
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
    return progress[playerId][questId] ~= nil and progress[playerId][questId].completed
end

function hasQuest(playerId, questId)
    return progress[playerId][questId] ~= nil
end

function isEligibleForQuest(playerId, questId)
    -- Check if they don't already have it, haven't completed it, pass the
    -- prerequisites and are the right level.
    if hasQuest(playerId, questId) then
        return false
    end

    if questCompleted(playerId, questId) then
        return false
    end

    -- TODO check prereqs and level

    return true
end

function beginQuest(playerId, questId)
    progress[playerId][questId] = {
        completed = false,
        objectives = {},
    }
    print("Starting quest ", questId)

    updateQuestMarks()
end

function finishQuest(playerId, questId)
    progress[playerId][questId].completed = true
    print("Completed quest ", questId)

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
                print("You havent finished the objectives yet")
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

function initQuests()
    QUESTS = {
        [1] = {
            getQuestFrom = gg_unit_nvl2_0000,
            handQuestTo = gg_unit_nvl2_0000,
            objectives = {
                [1] = {
                    type = TYPE.KILL,
                    amount = 10,
                    toKill = FourCC('hmbs'),
                }
            },
            prerequisites = {},
            levelRequirement = 0,
        }
    }
end

function init()
    local trigger = CreateTrigger()
    TriggerRegisterTimerEvent(trigger, 2, false)
    TriggerAddAction(trigger, initQuestMarks)

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
end

return {
    init = init,
}

