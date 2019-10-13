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
                        local verb = objectiveInfo.verbPast or 'killed'
                        log.log(
                            playerId,
                            'You have ' .. verb .. ' '..
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

function maybeUpdateLootProgress(playerId)
    for questId, progressInfo in pairs(progress[playerId]) do
        if not progressInfo.completed then
            for objectiveIdx, objectiveInfo in pairs(QUESTS[questId].objectives) do
                if objectiveInfo.type == TYPE.ITEM then
                    local count = backpack.getItemCount(
                        playerId, objectiveInfo.itemId)

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
                            log.TYPE.INFO)
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
                if objectiveInfo.type == TYPE.DISCOVER then
                    if enteredRegion == objectiveInfo.region then
                        progress[playerId][questId].objectives[objectiveIdx] = 1
                        log.log(
                            playerId,
                            'You discovered the ' .. objectiveInfo.name,
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
            color = {255, 255, 0}
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
            color = {255, 255, 0}
            showOnUnit = questInfo.handQuestTo
        else
            text = ""
            color = {255, 255, 255}
            showOnUnit = questInfo.handQuestTo
        end
        SetTextTagText(tag, text, TextTagSize2Height(25))
        SetTextTagColor(tag, color[1], color[2], color[3], 0)
        SetTextTagPosUnit(tag, showOnUnit, 10)
    end
end

function initQuestMarks()
    for questId, questInfo in pairs(QUESTS) do
        local tag = CreateTextTag()
        SetTextTagText(tag, "!", TextTagSize2Height(25))
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
    if QUESTS[questId].rewards.items then
        for itemId,amount in pairs(QUESTS[questId].rewards.items) do
            res = res .. "- " .. amount .. ' ' .. itemmanager.getItemInfo(itemId).name .. "|n"
        end
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
            local verb = objectiveInfo.verb or 'Kill'
            objectives = objectives.."- "..verb.." "..objectiveInfo.amount.." "..objectiveInfo.name.."|n"
        end
        if objectiveInfo.type == TYPE.ITEM then
            local itemInfo = itemmanager.getItemInfo(objectiveInfo.itemId)
            objectives = objectives .. "- Collect "..objectiveInfo.amount.." "..itemInfo.name.."|n"
        end
        if objectiveInfo.type == TYPE.DISCOVER then
            objectives = objectives .. "- Discover the "..objectiveInfo.name.."|n"
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
                log.TYPE.INFO)
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
            getQuestFrom = gg_unit_nvl2_0005,
            handQuestTo = gg_unit_nvl2_0005,
            obtainText = "Hello traveller, my name is Fjorn. If you're looking to help out around here, we could really do with some help killing the snapping turtles in the area. They have been attacking the town lately.",
            incompleteText = "Have you completed the task?",
            completedText = "Thanks, this will be a great help to me and my work around here. Talk to me again if you're interested in more work.",
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
            getQuestFrom = gg_unit_nvl2_0005,
            handQuestTo = gg_unit_nvil_0085,
            obtainText = "A neighbor of mine, Fred, has recently gone missing. I want you to go find him. Last time I saw him he was headed west into the forest.",
            incompleteText = "I don't think its possible to see this text.",
            completedText = "Fjorn sent you? Thank goodness you've arrived! I was hunting turtles for soup, when all of a sudden I was knocked out and thrown in a cage!",
            rewards = {
                exp = 20,
                gold = 5,
            },
            objectives = {},
            prerequisites = {1},
            levelRequirement = 0,
        },
        [3] = {
            name = "Fred's Soup",
            getQuestFrom = gg_unit_nvil_0085,
            handQuestTo = gg_unit_nvil_0085,
            obtainText = "I'm starving! I was out here collecting turtle meat so I could make my famous turtle soup. However, I'm feeling a little woozy...could you please collect ten River Turtle Meat and bring it back to me?",
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
            getQuestFrom = gg_unit_nvil_0085,
            handQuestTo = gg_unit_nvl2_0005,
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
            name = "Wolves to the North",
            getQuestFrom = gg_unit_nvl2_0005,
            handQuestTo = gg_unit_nvl2_0005,
            obtainText = "So Fred thinks you can take them on? All right. You can find the wolves just north of Freydell, just follow the trail west. Come back when you've killed at least fifteen.",
            incompleteText = "Have you killed the wolves yet?",
            completedText = "Wow! You're skilled!",
            objectives = {
                [1] = {
                    type = TYPE.KILL,
                    amount = 15,
                    toKill = FourCC('hwol'),
                    name = 'Wolves',
                }
            },
            rewards = {
                exp = 150,
                gold = 10,
            },
            prerequisites = {4},
            levelRequirement = 0,
        },
		[6] = {
            name = "Talk to Elder John",
            getQuestFrom = gg_unit_nvl2_0005,
            handQuestTo = gg_unit_nvil_0087,
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
		[7] = {
            name = "Giant Turtle",
            getQuestFrom = gg_unit_nvl2_0005,
            handQuestTo = gg_unit_nvl2_0005,
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
                exp = 300,
                gold = 25,
            },
            prerequisites = {6},
            levelRequirement = 0,
        },
		[8] = {
            name = "Alpha Wolf",
            getQuestFrom = gg_unit_nvil_0087,
            handQuestTo = gg_unit_nvil_0087,
            obtainText = "There is a cave just north of the village where the Alpha Wolf resides, though it is probably being controlled I need you to slay it. If you follow the road west you should be able to find him.",
            incompleteText = "Have you slain the alpha wolf?",
            completedText = "You did it? I'm amazed!",
            objectives = {
                [1] = {
                    type = TYPE.KILL,
                    amount = 1,
                    toKill = FourCC('hbld'),
                    name = 'Alpha Wolf',
                }
            },
            rewards = {
                exp = 350,
                gold = 30,
            },
            prerequisites = {6},
            levelRequirement = 0,
        },
        [9] = {
            name = "Ironwell City",
            getQuestFrom = gg_unit_nvil_0087,
            handQuestTo = gg_unit_Hlgr_0335,
            obtainText = "Find General Smith outside of Ironwell, he might have some work for you to do before you can enter the city.",
            incompleteText = "Did you find General Smith?",
            completedText = "Fjord sent you? Good. I need some help around here.",
            objectives = {},
            rewards = {
                exp = 30,
                gold = 5,
            },
            prerequisites = {8},
            levelRequirement = 0,
        },
		[10] = {
            name = "Stamping out the Fires",
            getQuestFrom = gg_unit_Hlgr_0335,
            handQuestTo = gg_unit_Hlgr_0335,
            obtainText = "The Cultists are rallying outside of our camp to the east. They need to be slowed down. Find and destroy five Cultist Bonfires and return back to me.",
            incompleteText = "Have you extinguished the Cultist Bonfires?",
            completedText = "Nice work! I have another task for you. Talk to me again when you are ready.",
           objectives = {
                [1] = {
                    type = TYPE.KILL,
                    amount = 5,
                    toKill = FourCC('fire'),
                    name = 'Bonfires',
					verb = 'Extinguish',
					verbPast = 'extinguished',
                }
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
            getQuestFrom = gg_unit_Hlgr_0335,
            handQuestTo = gg_unit_Hlgr_0335,
            obtainText = "The Cultist Commanders are readying for their final assault. Take them out and let them know who they are messing with!",
            incompleteText = "Have you slain those Commanders yet?",
            completedText = "Nicely done.",
            objectives = {
                [1] = {
                    type = TYPE.KILL,
                    amount = 1,
                    toKill = FourCC('clea'),
                    name = 'Cultist Commander',
                }
            },
            rewards = {
                exp = 300,
                gold = 30,
            },
            prerequisites = {10},
            levelRequirement = 0,
        },
		[12] = {
            name = "Scouting the Mines",
            getQuestFrom = gg_unit_Hlgr_0335,
            handQuestTo = gg_unit_Hlgr_0335,
            obtainText = "With the Cultist camps in shambles to the east, it is time for us to focus to the north. There have been rumors of Cultist activity in the pass to the north of our camp. Go scout it out and come back to me if you find anything",
            incompleteText = "Did you find anything in the pass?",
            completedText = "I knew it. This is much worse than I thought.",
            objectives = {
                [1] = {
                    type = TYPE.DISCOVER,
                    rect = gg_rct_mineexit,
                    name = 'Mine Entrance',
                    amount = 1,
                },
            },
            rewards = {
                exp = 75,
                gold = 10,
            },
            prerequisites = {11},
            levelRequirement = 0,
        },
		[13] = {
            name = "Attack Plans",
            getQuestFrom = gg_unit_hcth_0104,
            handQuestTo = gg_unit_hcth_0104,
            obtainText = "Those Cultists are planning something. Try to find anything that looks like attack plans and destroy them!",
            incompleteText = "Have you destroyed those attack plans?",
            completedText = "Nice work! You've saved the day",
           objectives = {
                [1] = {
                    type = TYPE.KILL,
                    amount = 1,
                    toKill = FourCC('plan'),
                    name = 'Attack Plans',
					verb = 'Burn',
					verbPast = 'burned',
                },
            },
            rewards = {
                exp = 250,
                gold = 25,
            },
            prerequisites = {9},
            levelRequirement = 0,
        },
		[14] = {
            name = "Kill Them All!",
            getQuestFrom = gg_unit_nvil_0087,
            handQuestTo = gg_unit_nvil_0087,
            obtainText = "The Cultists are harvesting gold and gems in order to fuel their cause. Crush them. Find anyone who resembles a leader and take their head.",
            incompleteText = "Did you crush those Cultist bastards?",
            completedText = "You're a natural, good work. I might know someone else who has more work for you if you're interested.",
            objectives = {
                [1] = {
                    type = TYPE.KILL,
                    amount = 1,
                    toKill = FourCC('mine'),
                    name = 'Miner Joe',
                },
				[2] = {
                    type = TYPE.KILL,
                    amount = 1,
                    toKill = FourCC('over'),
                    name = 'The Overseer',
                }
            },
            rewards = {
                exp = 500,
                gold = 75,
            },
            prerequisites = {12},
            levelRequirement = 0,
        },
		[15] = {
            name = "A Friend In Need is a Friend Indeed",
            getQuestFrom = gg_unit_nvil_0083,
            handQuestTo = gg_unit_nvil_0084,
            obtainText = "Help! My friend is being ambushed by some Cultists! He's just down the road!",
            incompleteText = "Is my friend still alive?",
            completedText = "Thank you so much!",
            objectives = {
                [1] = {
                    type = TYPE.KILL,
                    amount = 4,
                    toKill = FourCC('h000'),
                    name = 'Cultist Raider',
                }
            },
            rewards = {
                exp = 150,
                gold = 50,
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
}
