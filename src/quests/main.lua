local hero = require('src/hero.lua')
local log = require('src/log.lua')
local party = require('src/party.lua')
local itemmanager = require('src/items/itemmanager.lua')
local backpack = require('src/items/backpack.lua')
local Dialog = require('src/ui/dialog.lua')
local quests = require('src/quests/quests.lua')

local LINE_HEIGHT = 0.014

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
                        objectiveInfo.type == quests.TYPE.KILL and
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
                if objectiveInfo.type == quests.TYPE.ITEM then
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
                    objectiveInfo.type == quests.TYPE.DISCOVER and
                    progress[playerId][questId].objectives[objectiveIdx] ~= 1
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
        local amt = objectiveInfo.amount
        if amt == nil then
            amt = 1
        end
        if
            amt ~= progress[playerId][questId].objectives[idx]
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

    if QUESTS[questId].prerequisites then
        for _, prereqQuestId in pairs(QUESTS[questId].prerequisites) do
            if not questCompleted(playerId, prereqQuestId) then
                return false
            end
        end
    end

    return true
end

function getSectionsForIncompletedDialog(questId)
    local sections = {}
    table.insert(sections, {
        text = string.upper(GetUnitName(QUESTS[questId].handQuestTo)),
        type = 'red',
        textalign = TEXT_JUSTIFY_CENTER,
        textalignvert = TEXT_JUSTIFY_MIDDLE,
        height = 0.05,
        width = 0.9,
    })

    table.insert(sections, {
        text = "|cff2cfc03" .. QUESTS[questId].name .. "|r|n|n" .. QUESTS[questId].incompleteText,
        type = 'normal',
        textalignvert = TEXT_JUSTIFY_MIDDLE,
        height = LINE_HEIGHT * 3 + getLineHeight(QUESTS[questId].incompleteText),
        width = 0.8,
    })

    return sections
end

function getSectionsForCompletedDialog(questId)
    local rewards = {}
    if QUESTS[questId].rewards.gold then
        table.insert(rewards, {
            icon = "war3mapImported\\ui\\gold.blp",
            text = QUESTS[questId].rewards.gold .. " Gold"
        })
    end
    if QUESTS[questId].rewards.exp then
        table.insert(rewards, {
            icon = "ui\\feedback\\resources\\resourcemanastone.blp",
            text = QUESTS[questId].rewards.exp .. " Experience"
        })
    end
    if QUESTS[questId].rewards.items then
        for itemId,amount in pairs(QUESTS[questId].rewards.items) do
            table.insert(rewards, {
                icon = itemmanager.getItemInfo(itemId).icon,
                text = amount .. " " .. itemmanager.getItemInfo(itemId).name
            })
        end
    end

    local sections = {}
    table.insert(sections, {
        text = string.upper(GetUnitName(QUESTS[questId].handQuestTo)),
        type = 'red',
        textalign = TEXT_JUSTIFY_CENTER,
        textalignvert = TEXT_JUSTIFY_MIDDLE,
        height = 0.05,
        width = 0.9,
    })

    table.insert(sections, {
        text = "|cff2cfc03" .. QUESTS[questId].name .. " Completed!|r|n|n" .. QUESTS[questId].completedText,
        type = 'normal',
        textalignvert = TEXT_JUSTIFY_MIDDLE,
        height = LINE_HEIGHT * 3 + getLineHeight(QUESTS[questId].completedText),
        width = 0.8,
    })

    table.insert(sections,  {
        text = "|cffe0b412REWARDS|r",
        type = 'normal',
        height = LINE_HEIGHT * (3 + #rewards),
        width = 0.8,
        bullets = rewards,
    })

    return sections
end

function getLineHeight(text)
    local lines = string.split(text, "\n")
    if #lines == 0 then
        lines = {text}
    end

    local totalHeight = 0
    for _, line in pairs(lines) do
        local numChars = string.len(line)
        totalHeight = totalHeight + math.ceil(numChars / 60) * LINE_HEIGHT
    end

    return totalHeight
end

function getSectionsForAcceptDialog(questId, playerId)
    local objectives = {}
    for objectiveIdx, objectiveInfo in pairs(QUESTS[questId].objectives) do
        local objective
        local icon
        if objectiveInfo.type == quests.TYPE.KILL then
            local verb = objectiveInfo.verb or 'Kill'
            local amount = objectiveInfo.amount > 1 and (objectiveInfo.amount .. ' ')  or ''
            objective = verb.." "..amount..objectiveInfo.name
            icon = "war3mapImported\\ui\\swords_icon.blp"
        end
        if objectiveInfo.type == quests.TYPE.ITEM then
            local itemInfo = itemmanager.getItemInfo(objectiveInfo.itemId)
            objective = "Collect "..objectiveInfo.amount.." "..itemInfo.name
            icon = "war3mapImported\\ui\\chest_icon.blp"
        end
        if objectiveInfo.type == quests.TYPE.DISCOVER then
            objective = "Discover the "..objectiveInfo.name
            icon = "war3mapImported\\ui\\search_icon.blp"
        end
        if playerId ~= nil and progress[playerId][questId] ~= nil and progress[playerId][questId].objectives[objectiveIdx] ~= nil then
            local amt = objectiveInfo.amount
            if amt == nil then
                amt = 1
            end
            local amountDone = progress[playerId][questId].objectives[objectiveIdx]
            objective = objective .. " ( ".. amountDone .." / ".. amt .." )"
        end
        table.insert(objectives, {
            text = objective,
            icon = icon,
        })
    end

    local rewards = {}
    if QUESTS[questId].rewards.gold then
        table.insert(rewards, {
            icon = "war3mapImported\\ui\\gold.blp",
            text = QUESTS[questId].rewards.gold .. " Gold"
        })
    end
    if QUESTS[questId].rewards.exp then
        table.insert(rewards, {
            icon = "ui\\feedback\\resources\\resourcemanastone.blp",
            text = QUESTS[questId].rewards.exp .. " Experience"
        })
    end
    if QUESTS[questId].rewards.items then
        for itemId,amount in pairs(QUESTS[questId].rewards.items) do
            table.insert(rewards, {
                icon = itemmanager.getItemInfo(itemId).icon,
                text = amount .. " " .. itemmanager.getItemInfo(itemId).name
            })
        end
    end

    local sections = {}
    table.insert(sections, {
        text = string.upper(GetUnitName(QUESTS[questId].getQuestFrom)),
        type = 'red',
        textalign = TEXT_JUSTIFY_CENTER,
        textalignvert = TEXT_JUSTIFY_MIDDLE,
        height = 0.05,
        width = 0.9,
    })

    table.insert(sections, {
        text = "|cff2cfc03" .. QUESTS[questId].name .. "|r|n|n" .. QUESTS[questId].obtainText,
        type = 'normal',
        textalignvert = TEXT_JUSTIFY_MIDDLE,
        height = LINE_HEIGHT * 3 + getLineHeight(QUESTS[questId].obtainText),
        width = 0.8,
    })

    if #objectives > 0 then
        table.insert(sections, {
            text = "|cffe0b412OBJECTIVES|r",
            type = 'normal',
            height = LINE_HEIGHT * (3 + #objectives),
            width = 0.8,
            bullets = objectives,
        })
    end

    table.insert(sections,  {
        text = "|cffe0b412REWARDS|r",
        type = 'normal',
        height = LINE_HEIGHT * (3 + #rewards),
        width = 0.8,
        bullets = rewards,
    })

    return sections
end

function beginQuest(playerId, questId)
    Dialog.show(playerId, {
        sections = getSectionsForAcceptDialog(questId),
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
        sections = getSectionsForCompletedDialog(questId),
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
        if objectiveInfo.type == quests.TYPE.ITEM then
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
                    sections = getSectionsForIncompletedDialog(questId),
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
        sections = getSectionsForAcceptDialog(activeQuests[activeQuestId], playerId),
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
    QUESTS = quests.getQuests()
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
            if objectiveInfo.type == quests.TYPE.DISCOVER then
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
    isEligibleForQuest = isEligibleForQuest,
    questCompleted = questCompleted,
    hasQuest = hasQuest,
}
