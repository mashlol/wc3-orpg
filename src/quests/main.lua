local hero = require('src/hero.lua')
local log = require('src/log.lua')
local party = require('src/party.lua')
local itemmanager = require('src/items/itemmanager.lua')
local backpack = require('src/items/backpack.lua')
local Dialog = require('src/ui/dialog.lua')

local TYPE = {
    KILL = {},
    ITEM = {},
    DISCOVER = {},
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
--     [unit handle of receiver/giver] = {unit = unit, tag = texttag}
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
                        local verb = objectiveInfo.verbPast or 'killed'
                        log.log(
                            playerId,
                            'You have ' .. verb .. ' '..
                                numKilled..
                                ' / '..
                                objectiveInfo.amount..
                                ' '..
                                objectiveInfo.name,
                            log.TYPE.QUEST)
                        updateQuestMarks()
                    end
                end
            end
        end
    end
end

function maybeUpdateLootProgress(playerId)
    for questId, progressInfo in pairs(progress[playerId]) do
        if not progressInfo.completed then
            for objectiveIdx, objectiveInfo in pairs(QUESTS[questId].objectives) do
                if objectiveInfo.type == TYPE.ITEM then
                    local count = math.min(
                        objectiveInfo.amount,
                        backpack.getItemCount(
                            playerId, objectiveInfo.itemId))

                    local existing =
                        progress[playerId][questId].objectives[objectiveIdx]
                    if existing ~= count and count ~= 0 then
                        log.log(
                            playerId,
                            'You have obtained '..
                                count..
                                ' / '..
                                objectiveInfo.amount..
                                ' '..
                                itemmanager.getItemInfo(objectiveInfo.itemId).name,
                            log.TYPE.QUEST)
                    end
                    progress[playerId][questId].objectives[objectiveIdx] = count
                    updateQuestMarks()
                end
            end
        end
    end
end

function maybeUpdateDiscoverProgress()
    local playerId = GetPlayerId(GetOwningPlayer(GetEnteringUnit()))
    local enteredRegion = GetTriggeringRegion()

    for questId, progressInfo in pairs(progress[playerId]) do
        if not progressInfo.completed then
            for objectiveIdx, objectiveInfo in pairs(QUESTS[questId].objectives) do
                if
                    objectiveInfo.type == TYPE.DISCOVER and
                    progress[playerId][questId].objectives[objectiveIdx] ~= objectiveInfo.amount
                then
                    if enteredRegion == objectiveInfo.region then
                        progress[playerId][questId].objectives[objectiveIdx] = 1
                        log.log(
                            playerId,
                            'You discovered the ' .. objectiveInfo.name,
                            log.TYPE.QUEST)
                        updateQuestMarks()
                    end
                end
            end
        end
    end
end

function getMarkForQuestGiver(playerId, unit)
    for questId, questInfo in pairs(QUESTS) do
        if
            questInfo.getQuestFrom == unit and
            isEligibleForQuest(playerId, questId)
        then
            return "!", {255, 255, 0}
        elseif
            questInfo.handQuestTo == unit and
            hasQuest(playerId, questId) and
            not questCompleted(playerId, questId)
        then
            if questObjectivesCompleted(playerId, questId) then
                return "?", {255, 255, 0}
            else
                return "?", {50, 50, 50}
            end
        end
    end

    return "", {255, 255, 255}
end

function updateQuestMarks()
    -- Loop through each quest mark and check which action would happen if you
    -- click on that unit. Based on that we set the text of the quest mark

    -- TODO optimize n^2?

    local playerId = GetPlayerId(GetLocalPlayer())
    for _, questMarkInfo in pairs(questMarks) do
        -- print('check quest mark info for ', questMarkInfo.unit)
        local tag = questMarkInfo.tag

        local text, color = getMarkForQuestGiver(playerId, questMarkInfo.unit)

        SetTextTagText(tag, text, TextTagSize2Height(25))
        SetTextTagColor(tag, color[1], color[2], color[3], 0)
    end
end

function maybeAddQuestMarkToUnit(unit)
    if questMarks[GetHandleId(unit)] ~= nil then
        return
    end

    local tag = CreateTextTag()
    SetTextTagText(tag, "!", TextTagSize2Height(25))
    SetTextTagPosUnit(tag, unit, 10)
    SetTextTagColor(tag, 100, 100, 0, 0)
    SetTextTagPermanent(tag, true)
    SetTextTagFadepoint(tag, 0.01)

    questMarks[GetHandleId(unit)] = {
        unit = unit,
        tag = tag,
    }
end

function initQuestMarks()
    for _, questInfo in pairs(QUESTS) do
        maybeAddQuestMarkToUnit(questInfo.getQuestFrom)
        maybeAddQuestMarkToUnit(questInfo.handQuestTo)
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
    if QUESTS[questId].rewards.items then
        for itemId,amount in pairs(QUESTS[questId].rewards.items) do
            res = res .. "- " .. amount .. ' ' .. itemmanager.getItemInfo(itemId).name .. "|n"
        end
    end
    return res
end

function getQuestAcceptText(questId, playerId)
    local res = "|cffe0b412" .. GetUnitName(QUESTS[questId].getQuestFrom) .. "|r|n|n"

    res = res .. "|cff2cfc03" .. QUESTS[questId].name .. "|r|n|n"

    res = res .. QUESTS[questId].obtainText
    local objectives = ""
    for objectiveIdx, objectiveInfo in pairs(QUESTS[questId].objectives) do
        if objectiveInfo.type == TYPE.KILL then
            local verb = objectiveInfo.verb or 'Kill'
            local amount = objectiveInfo.amount > 1 and (objectiveInfo.amount .. ' ')  or ''
            objectives = objectives.."- "..verb.." "..amount..objectiveInfo.name
        end
        if objectiveInfo.type == TYPE.ITEM then
            local itemInfo = itemmanager.getItemInfo(objectiveInfo.itemId)
            objectives = objectives .. "- Collect "..objectiveInfo.amount.." "..itemInfo.name
        end
        if objectiveInfo.type == TYPE.DISCOVER then
            objectives = objectives .. "- Discover the "..objectiveInfo.name
        end
        if playerId ~= nil and progress[playerId][questId].objectives[objectiveIdx] ~= nil then
            local amountDone = progress[playerId][questId].objectives[objectiveIdx]
            objectives = objectives .. " ( ".. amountDone .." / ".. objectiveInfo.amount .." )"
        end
        objectives = objectives .. "|n"
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
    if QUESTS[questId].rewards.items then
        for itemId,amount in pairs(QUESTS[questId].rewards.items) do
            res = res .. "- " .. amount .. ' ' .. itemmanager.getItemInfo(itemId).name .. "|n"
        end
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

            maybeUpdateLootProgress(playerId)
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
    local itemsGained = QUESTS[questId].rewards.items

    if expGained ~= nil then
        AddHeroXP(hero.getHero(playerId), expGained, true)
    end

    if goldGained ~= nil then
        local curGold = GetPlayerState(
            Player(playerId), PLAYER_STATE_RESOURCE_GOLD)
        SetPlayerState(
            Player(playerId), PLAYER_STATE_RESOURCE_GOLD, curGold + goldGained)
    end

    if itemsGained ~= nil then
        for itemId, amount in pairs(itemsGained) do
            backpack.addItemIdToBackpack(playerId, itemId, amount)
            log.log(
                playerId,
                'You received ' ..
                    amount ..
                    ' ' ..
                    itemmanager.getItemInfo(itemId).name,
                log.TYPE.QUEST)
        end
    end

    for _, objectiveInfo in pairs(QUESTS[questId].objectives) do
        if objectiveInfo.type == TYPE.ITEM then
            for i=1,objectiveInfo.amount,1 do
                backpack.removeItemIdFromBackpack(playerId, objectiveInfo.itemId)
            end
        end
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
        text = getQuestAcceptText(activeQuests[activeQuestId], playerId),
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
            getQuestFrom = gg_unit_nvil_0069,
            handQuestTo = gg_unit_nvil_0069,
            obtainText = "Hello traveller, my name is Fjorn. If you're looking to help out around here, we could really do with some help killing the snapping turtles invading the forest to the west. This is unlike them...",
            incompleteText = "Have you completed the task?",
            completedText = "Why were those turtles so aggressive? Usually they are very friendly.",
            rewards = {
                exp = 50,
                gold = 5,
                items = {[6] = 5},
            },
            objectives = {
                [1] = {
                    type = TYPE.KILL,
                    amount = 10,
                    toKill = FourCC('hmbs'),
                    name = 'Snapping Turtles',
                },
            },
            prerequisites = {},
            levelRequirement = 0,
        },
        [2] = {
            name = "Fred's Quest",
            getQuestFrom = gg_unit_nvl2_0070,
            handQuestTo = gg_unit_nvil_0071,
            obtainText = "A neighbor of mine, Fred, has recently gone missing. I want you to go find him. Last time I saw him he was headed west into the forest.",
            incompleteText = "I don't think its possible to see this text.",
            completedText = "Fjorn sent you? Thank goodness you've arrived! I was hunting turtles for soup, when all of a sudden I was knocked out and thrown in a cage!",
            rewards = {
                exp = 20,
                gold = 5,
            },
            objectives = {},
            prerequisites = {},
            levelRequirement = 0,
        },
        [3] = {
            name = "Fred's Soup",
            getQuestFrom = gg_unit_nvil_0071,
            handQuestTo = gg_unit_nvil_0071,
            obtainText = "I'm starving! I was out here collecting turtle meat so I could make my famous turtle soup. However, I'm feeling a little woozy...could you please collect five River Turtle Meat and bring it back to me?",
            incompleteText = "Have you completed the task?",
            completedText = "Thanks so much! I need to get back to the village so I can make my soup!",
            rewards = {
                exp = 100,
                gold = 5,
            },
            objectives = {
                [1] = {
                    type = TYPE.ITEM,
                    amount = 5,
                    itemId = 9,
                }
            },
            prerequisites = {2},
            levelRequirement = 0,
        },
        [4] = {
            name = "Return to Freydell Village",
            getQuestFrom = gg_unit_nvil_0071,
            handQuestTo = gg_unit_nvl2_0070,
            obtainText = "I appreciate all you've done for me, but I can take it from here. Return to Fjord and ask him about the wolves north of the village.",
            incompleteText = "Impossible!",
            completedText = "Fred sent you about the wolves? He thinks you can handle them? All right then. Talk to me when you're ready for the challenge.",
            objectives = {},
            rewards = {
                exp = 30,
                gold = 3,
            },
            prerequisites = {3},
            levelRequirement = 0,
        },
		[5] = {
            name = "Talk to Elder John",
            getQuestFrom = gg_unit_nvil_0069,
            handQuestTo = gg_unit_nemi_0014,
            obtainText = "Talk to Elder John, he should be in the southern part of Freydell Village",
            incompleteText = "Have you talked to Elder John?",
            completedText = "Ah, you're the heroes i've heard so much about. I have some important tasks for you. The animals in this area have been coordinating attacks on our village as of late. This is very unlike them, I think someone might be behind this.",
            objectives = {

            },
            rewards = {
                exp = 20,
                gold = 5,
            },
            prerequisites = {5},
            levelRequirement = 0,
        },
		[6] = {
            name = "Giant Turtle",
            getQuestFrom = gg_unit_nvil_0069,
            handQuestTo = gg_unit_nvil_0069,
            obtainText = "There's a giant turtle just west of Freydell Village, We believe it's the leader of the turtles invading the forest. Slay it and I will reward you fairly.",
            incompleteText = "Have you slain the giant turtle",
            completedText = "You did it? I'm amazed!",
            objectives = {
                [1] = {
                    type = TYPE.KILL,
                    amount = 1,
                    toKill = FourCC('hbos'),
                    name = 'Giant Turtle',
                }
            },
            rewards = {
                exp = 150,
                gold = 25,
            },
            prerequisites = {6},
            levelRequirement = 0,
        },
		[10] = {
            name = "Stamping out the Fires",
            getQuestFrom = gg_unit_hcth_0104,
            handQuestTo = gg_unit_hcth_0104,
            obtainText = "The Cultists are rallying outside of our camp to the east. They need to be slowed down. Find and destroy five Cultist Bonfires and return back to me.",
            incompleteText = "Have you extinguished the Cultist Bonfires?",
            completedText = "Nice work! I have another task for you. Talk to me again when you are ready.",
           objectives = {
                [1] = {
                    type = TYPE.KILL,
                    amount = 1,
                    toKill = FourCC('fire'),
                    name = 'Northwest Bonfire',
					verb = 'Extinguish',
					verbPast = 'extinguished',
                },
				[2] = {
                    type = TYPE.KILL,
                    amount = 1,
                    toKill = FourCC('sfir'),
                    name = 'Southwest Bonfire',
					verb = 'Extinguish',
					verbPast = 'extinguished',
                },
				[3] = {
                    type = TYPE.KILL,
                    amount = 1,
                    toKill = FourCC('cfir'),
                    name = 'Central Bonfire',
					verb = 'Extinguish',
					verbPast = 'extinguished',
                },
				[4] = {
                    type = TYPE.KILL,
                    amount = 1,
                    toKill = FourCC('nefi'),
                    name = 'Northeast Bonfire',
					verb = 'Extinguish',
					verbPast = 'extinguished',
                },
				[5] = {
                    type = TYPE.KILL,
                    amount = 1,
                    toKill = FourCC('sefi'),
                    name = 'Southeast Bonfire',
					verb = 'Extinguish',
					verbPast = 'extinguished',
                },
            },
            rewards = {
                exp = 200,
                gold = 25,
            },
            prerequisites = {9},
            levelRequirement = 0,
        },
		[11] = {
            name = "Full Momentum",
            getQuestFrom = gg_unit_gens_0335,
            handQuestTo = gg_unit_gens_0335,
            obtainText = "The Cultist Commanders are readying for their final assault. Take them out and let them know who they are messing with! You can find them in the encampments to the east.",
            incompleteText = "Have you slain those Commanders yet?",
            completedText = "Nicely done.",
            objectives = {
                [1] = {
                    type = TYPE.KILL,
                    amount = 1,
                    toKill = FourCC('clea'),
                    name = 'Cultist Commander Siddel',
                },
				[2] = {
                    type = TYPE.KILL,
                    amount = 1,
                    toKill = FourCC('cled'),
                    name = 'Cultist Commander Audric',
                },
            },
            rewards = {
                exp = 250,
                gold = 30,
            },
            prerequisites = {9},
            levelRequirement = 0,
        },
}
end

function onHeroLevel()
    updateQuestMarks()
end

function getQuestInfo(questId)
    return QUESTS[questId]
end

function initRegionTriggers()
    for _, questInfo in pairs(QUESTS) do
        for _, objectiveInfo in pairs(questInfo.objectives) do
            if objectiveInfo.type == TYPE.DISCOVER then
                local region = CreateRegion()
                RegionAddRect(region, objectiveInfo.rect)
                objectiveInfo.region = region
                local enterDungeonTrig = CreateTrigger()
                TriggerRegisterEnterRegionSimple(
                    enterDungeonTrig, region)
                TriggerAddAction(enterDungeonTrig, maybeUpdateDiscoverProgress)
            end
        end
    end
end

function init()
    local selectTrig = CreateTrigger()
    for i=0,bj_MAX_PLAYERS-1,1 do
        TriggerRegisterPlayerUnitEvent(
            selectTrig, Player(i), EVENT_PLAYER_UNIT_SELECTED, nil)
    end
    TriggerAddAction(selectTrig, onNpcClicked)

    local levelTrig = CreateTrigger()
    for i=0,bj_MAX_PLAYERS-1,1 do
        TriggerRegisterPlayerUnitEvent(
            levelTrig, Player(i), EVENT_PLAYER_HERO_LEVEL, nil)
    end
    TriggerAddAction(levelTrig, onHeroLevel)

    backpack.addBackpackChangedListener(maybeUpdateLootProgress)

    for i=0,bj_MAX_PLAYERS-1,1 do
        progress[i] = {}
    end

    initQuests()
    initObjectiveTriggers()
    initQuestMarks()
    initRegionTriggers()

    hero.addRepickedListener(resetQuestProgress)
    hero.addHeroPickedListener(updateQuestMarks)

    TimerStart(CreateTimer(), 3, true, updateQuestMarks)
end

return {
    init = init,
    updateQuestMarks = updateQuestMarks,
    getProgress = getProgress,
    getNumQuests = getNumQuests,
    getQuestInfo = getQuestInfo,
    restoreProgress = restoreProgress,
    getActiveQuests = getActiveQuests,
    showDialogForActiveQuest = showDialogForActiveQuest,
    questObjectivesCompleted = questObjectivesCompleted,
}
