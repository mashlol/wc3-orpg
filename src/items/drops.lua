local backpack = require('src/items/backpack.lua')
local itemmanager = require('src/items/itemmanager.lua')
local LootRoll = require('src/ui/lootroll.lua')
local log = require('src/log.lua')
local party = require('src/party.lua')
local droptable = require('src/items/droptable.lua')

-- rolls = {
--     [1] = {
--         itemId = 1,
--         timer = {timer},
--         players = {1, 2, 3},
--         [playerId] = {
--             roll = 12,
--             type = 0,
--         },
--     },
-- }
local rolls = {}
local rollId = 1

function maybeGetDrop(unit)
    local unitId = GetUnitTypeId(unit)
    local drops = droptable.DROPS[unitId]
    if drops == nil then
        return nil
    end

    local totalWeights = 0
    for _, weight in pairs(drops) do
        totalWeights = totalWeights + weight
    end

    print('total weight was: ', totalWeights)

    local randNum = GetRandomReal(0, totalWeights)
    print('roll was: ', randNum)
    local curWeight = 0
    for itemId, weight in pairs(drops) do
        curWeight = curWeight + weight
        if randNum < curWeight then
            return itemId ~= 'none' and itemId or nil
        end
    end

    return nil
end

function maybeDistributeDrop()
    local unit = GetDyingUnit()
    local playerId = GetPlayerId(GetOwningPlayer(GetKillingUnit()))

    local drop = maybeGetDrop(unit)
    if drop ~= nil then

        local itemInfo = itemmanager.getItemInfo(drop)
        local playerPartyId = party.getPlayerParty(playerId)

        if
            playerPartyId ~= nil and
            itemInfo.rarity.priority >= itemmanager.RARITY.UNCOMMON.priority
        then
            local playersInParty = party.getPlayersInParty(playerPartyId)
            local localRollId = rollId
            rolls[localRollId] = {
                itemId = drop,
                timer = CreateTimer(),
                players = playersInParty,
            }

            TimerStart(rolls[localRollId].timer, 30, false, function()
                LootRoll.pruneRoll(localRollId)
                maybeDistributeRoll(localRollId)
            end)
            for _, playerId in pairs(playersInParty) do
                LootRoll.startRoll(playerId, localRollId)
            end

            rollId = rollId + 1
        else
            backpack.addItemIdToBackpack(playerId, drop)
            log.log(
                playerId,
                'You looted ' .. itemmanager.getItemNameWithColor(drop),
                log.TYPE.DROP)
        end
    end
end

function getWinningPlayerId(rollId)
    local highest = 0
    local highestType = 1
    local highestPlayer = nil
    for _, playerId in pairs(rolls[rollId].players) do
        if rolls[rollId][playerId] == nil then
            return nil
        end
        if
            rolls[rollId][playerId].roll > highest and
            rolls[rollId][playerId].type <= highestType
        then
            highestPlayer = playerId
            highest = rolls[rollId][playerId].roll
            highestType = rolls[rollId][playerId].type
        end
    end
    if highestPlayer == nil then
        -- Everyone passed
        return false
    end
    return highestPlayer
end

function onRollMade(playerId, rollId, type)
    local drop = rolls[rollId].itemId
    local randomRoll = GetRandomInt(1, 100)

    rolls[rollId][playerId] = {
        type = type,
        roll = randomRoll,
    }

    local rollType = type == 0 and "Need" or "Greed"
    if type == 0 or type == 1 then
        log.log(
            playerId,
            'You rolled ' ..
                rollType ..
                '(' ..
                randomRoll ..
                ') on ' ..
                itemmanager.getItemNameWithColor(drop),
            log.TYPE.ROLL)
        for _, otherPlayerId in pairs(rolls[rollId].players) do
            if otherPlayerId ~= playerId then
                log.log(
                    otherPlayerId,
                    GetPlayerName(Player(playerId)) ..
                        ' rolled ' ..
                        rollType ..
                        '(' ..
                        randomRoll ..
                        ') on ' ..
                        itemmanager.getItemNameWithColor(drop),
                    log.TYPE.ROLL)
            end
        end
    end
    if type == 2 then -- pass
        log.log(
            playerId,
            'You passed on ' .. itemmanager.getItemNameWithColor(drop),
            log.TYPE.ROLL)
        for _, otherPlayerId in pairs(rolls[rollId].players) do
            if otherPlayerId ~= playerId then
                log.log(
                    otherPlayerId,
                    GetPlayerName(Player(playerId)) ..
                        ' passed on ' ..
                        itemmanager.getItemNameWithColor(drop),
                    log.TYPE.ROLL)
            end
        end
    end

    maybeDistributeRoll(rollId)
end

function maybeDistributeRoll(rollId)
    local drop = rolls[rollId].itemId
    local winnerPlayerId = getWinningPlayerId(rollId)
    if winnerPlayerId == false then
        -- Everyone passed
        for _, playerId in pairs(rolls[rollId].players) do
            log.log(
                playerId,
                'Everyone passed on ' ..
                    itemmanager.getItemNameWithColor(drop) ..
                    '.',
                log.TYPE.ROLL)
        end

        DestroyTimer(rolls[rollId].timer)
        rolls[rollId] = nil
    elseif winnerPlayerId ~= nil then
        backpack.addItemIdToBackpack(winnerPlayerId, drop)
        log.log(
            winnerPlayerId,
            'You won ' .. itemmanager.getItemNameWithColor(drop) .. '!',
            log.TYPE.ROLL)
        for _, playerId in pairs(rolls[rollId].players) do
            if playerId ~= winnerPlayerId then
                log.log(
                    playerId,
                    GetPlayerName(Player(winnerPlayerId)) ..
                        ' won ' ..
                        itemmanager.getItemNameWithColor(drop) ..
                        '.',
                    log.TYPE.ROLL)
            end
        end

        DestroyTimer(rolls[rollId].timer)
        rolls[rollId] = nil
    end
end

function getItemIdForRoll(rollId)
    return rolls[rollId].itemId
end

function getTimerForRoll(rollId)
    return rolls[rollId].timer
end

function init()
    local killTrigger = CreateTrigger()
    TriggerRegisterPlayerUnitEvent(
        killTrigger,
        Player(PLAYER_NEUTRAL_AGGRESSIVE),
        EVENT_PLAYER_UNIT_DEATH,
        nil)
    TriggerAddAction(killTrigger, maybeDistributeDrop)
end

return {
    init = init,
    getItemIdForRoll = getItemIdForRoll,
    getTimerForRoll = getTimerForRoll,
    onRollMade = onRollMade,
}