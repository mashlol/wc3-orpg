local hero = require('src/hero.lua')
local log = require('src/log.lua')
local party = require('src/party.lua')
local Dialog = require('src/ui/dialog.lua')

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
    local killingUnit = GetKillingUnit()
    local dyingUnit = GetDyingUnit()

    local playerId = GetPlayerId(GetOwningPlayer(killingUnit))

    local partyId = party.getPlayerParty(playerId)
    local players = {playerId}
    if partyId ~= nil then
        players = party.getPlayersInParty(partyId)
    end

    for _, playerId in pairs(players) do
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
            hasQuest(playerId, questId) and
            not questCompleted(playerId, questId) and
            not questObjectivesCompleted(playerId, questId)
        then
            text = "?"
            color = {50, 50, 50}
            showOnUnit = questInfo.handQuestTo
        elseif
            hasQuest(playerId, questId) and
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

    for _, prereqQuestId in pairs(QUESTS[questId].prerequisites) do
        if not questCompleted(playerId, prereqQuestId) then
            return false
        end
    end

    return true
end

function getQuestIncompletedText(questId)
    local res = "|cffe0b412" .. GetUnitName(QUESTS[questId].handQuestTo) .. "|r|n|n"
    res = res .. QUESTS[questId].incompleteText
    return res
end

function getQuestCompletedText(questId)
    local res = "|cffe0b412" .. GetUnitName(QUESTS[questId].handQuestTo) .. "|r|n|n"
    res = res .. "|cff2cfc03" .. QUESTS[questId].name .. "|r|n|n"
    res = res .. QUESTS[questId].completedText
    res = res .. "|n|n|cffe0b412Rewards:|r|n"
    if QUESTS[questId].rewards.gold then
        res = res .. "- " .. QUESTS[questId].rewards.gold .. " gold|n"
    end
    if QUESTS[questId].rewards.exp then
        res = res .. "- " .. QUESTS[questId].rewards.exp .. " experience|n"
    end
    return res
end

function getQuestAcceptText(questId)
    local res = "|cffe0b412" .. GetUnitName(QUESTS[questId].getQuestFrom) .. "|r|n|n"

    res = res .. "|cff2cfc03" .. QUESTS[questId].name .. "|r|n|n"

    res = res .. QUESTS[questId].obtainText
    local objectives = ""
    for _, objectiveInfo in pairs(QUESTS[questId].objectives) do
        if objectiveInfo.type == TYPE.KILL then
            objectives = objectives .. "- Kill "..objectiveInfo.amount.." "..objectiveInfo.name.."|n"
        end
    end
    if objectives ~= "" then
        res = res .. "|n|n|cffe0b412Objectives:|r|n"..objectives
    end
    res = res .. "|n|n|cffe0b412Rewards:|r|n"
    if QUESTS[questId].rewards.gold then
        res = res .. "- " .. QUESTS[questId].rewards.gold .. " gold|n"
    end
    if QUESTS[questId].rewards.exp then
        res = res .. "- " .. QUESTS[questId].rewards.exp .. " experience|n"
    end
    return res
end

function beginQuest(playerId, questId)
    Dialog.show(playerId, {
        text = getQuestAcceptText(questId),
        positiveButton = "Accept",
        negativeButton = "Decline",
        onPositiveButtonClicked = function()
            progress[playerId][questId] = {
                completed = false,
                objectives = {},
            }

            updateQuestMarks()
        end,
    })
end

function finishQuest(playerId, questId)
    progress[playerId][questId].completed = true

    Dialog.show(playerId, {
        text = getQuestCompletedText(questId),
        positiveButton = "Okay",
    })

    local expGained = QUESTS[questId].rewards.exp
    local goldGained = QUESTS[questId].rewards.gold

    if expGained ~= nil then
        AddHeroXP(hero.getHero(playerId), expGained, true)
    end

    if goldGained ~= nil then
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
            return
        elseif
            questInfo.handQuestTo == selectedUnit and
            IsUnitInRange(hero, selectedUnit, 300) and
            hasQuest(playerId, questId) and
            not questCompleted(playerId, questId)
        then
            if questObjectivesCompleted(playerId, questId) then
                finishQuest(playerId, questId)
                return
            else
                Dialog.show(playerId, {
                    text = getQuestIncompletedText(questId),
                    positiveButton = 'Okay',
                })
                return
            end
        end
    end
end

function showDialogForActiveQuest(playerId, activeQuestId)
    local activeQuests = getActiveQuests(playerId)
    Dialog.show(playerId, {
        text = getQuestAcceptText(activeQuests[activeQuestId]),
        positiveButton = "Okay",
        negativeButton = "Disband",
        onNegativeButtonClicked = function()
            progress[playerId][activeQuests[activeQuestId]] = nil
            updateQuestMarks()
        end
    })
end

function getActiveQuests(playerId)
    -- Loop through all progress for the player
    -- and return only quests that are not completed
    local activeQuests = {}
    for questId, questInfo in pairs(progress[playerId]) do
        if not questInfo.completed then
            table.insert(activeQuests, questId)
        end
    end

    return activeQuests
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
            name = "Trouble in Turtle Town",
            getQuestFrom = gg_unit_nvl2_0000,
            handQuestTo = gg_unit_nvl2_0000,
            obtainText = "Hello traveller, my name is Fjorn. If you're looking to help out around here, we could really do with some help killing the snapping turtles in the area. They are interfering with my fishing lately.",
            incompleteText = "Have you completed the task?",
            completedText = "Thanks, this will be a great help to me and my work around here. Talk to me again if you're interested in more work.",
            rewards = {
                exp = 50,
                gold = 50,
            },
            objectives = {
                [1] = {
                    type = TYPE.KILL,
                    amount = 1,
                    toKill = FourCC('hmbs'),
                    name = 'Snapping Turtles',
                }
            },
            prerequisites = {},
            levelRequirement = 0,
        },
        [2] = {
            name = "Fred's Quest",
            getQuestFrom = gg_unit_nvl2_0000,
            handQuestTo = gg_unit_nvil_0030,
            obtainText = "A neighbor of mine, Fred, mentioned to me recently he's having some trouble at his farm. He'll likely want your help up there - his farm is north west of here, just follow the dirt trail. Go seek out Fred and I'm sure he will be grateful for your help.",
            incompleteText = "I don't think its possible to see this text.",
            completedText = "Fjorn sent you? Ah, that makes sense. Yes, I have been having some trouble recently, there's a bunch of spiders that seem to have infested my farm and are ruining my crops and infecting my animals with diseases. Do you think you could help with that?",
            rewards = {
                exp = 20,
                gold = 10,
            },
            objectives = {},
            prerequisites = {1},
            levelRequirement = 0,
        },
        [3] = {
            name = "Spider Infestation",
            getQuestFrom = gg_unit_nvil_0030,
            handQuestTo = gg_unit_nvil_0030,
            obtainText = "Yes, I'd be glad to have your help. As I said before, I've got an infestation of spiders at my farm here and I need some help erradicating them. Could you help?",
            incompleteText = "Have you completed the task?",
            completedText = "Thanks so much! This is huge for me. Let me know if you need more work.",
            rewards = {
                exp = 100,
                gold = 100,
            },
            objectives = {
                [1] = {
                    type = TYPE.KILL,
                    amount = 1,
                    toKill = FourCC('hspi'),
                    name = 'Spiders',
                }
            },
            prerequisites = {1, 2},
            levelRequirement = 0,
        },
    }
end

function getQuestInfo(questId)
    return QUESTS[questId]
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
    getQuestInfo = getQuestInfo,
    restoreProgress = restoreProgress,
    getActiveQuests = getActiveQuests,
    showDialogForActiveQuest = showDialogForActiveQuest,
}
