local backpack = require('src/items/backpack.lua')
local itemmanager = require('src/items/itemmanager.lua')
local LootRoll = require('src/ui/lootroll.lua')
local log = require('src/log.lua')
local party = require('src/party.lua')

local DROP_TABLE = {
    -- -------------------------------------------------------------------------
    -- UNITS
    -- -------------------------------------------------------------------------
    [FourCC('hmbs')] = { -- Small turtles
        none = 50,
        [6] = 30,
        [5] = 10,
        [45] = 10,
        [29] = 20,
    },
    [FourCC('lold')] = { -- River turtles
        none = 50,
        [6] = 20,
        [5] = 10,
		[9] = 275,
        [18] = 5,
        [37] = 5,
    },
    [FourCC('hwol')] = { -- Wolves
        none = 50,
        [10] = 5,
        [22] = 5,
        [25] = 5,
        [32] = 5,
        [41] = 5,
        [6] = 30,
        [5] = 10,
    },
    [FourCC('hwol')] = { -- Elite Wolves
        none = 50,
        [38] = 5,
        [6] = 30,
        [5] = 10,
    },
    [FourCC('clea')] = { -- Cultist Commander
        none = 50,
        [12] = 1,
        [35] = 1,
        [16] = 5,
        [23] = 5,
        [27] = 5,
        [30] = 5,
        [33] = 5,
        [6] = 30,
        [5] = 10,
    },
    [FourCC('cspe')] = { -- Cultist Emissary
        none = 50,
        [16] = 5,
        [19] = 5,
        [23] = 5,
        [27] = 5,
        [30] = 5,
        [33] = 5,
        [39] = 5,
        [6] = 30,
        [5] = 10,
    },
    [FourCC('h000')] = { -- Cultist Raider
        none = 50,
        [16] = 5,
        [20] = 5,
        [23] = 5,
        [27] = 5,
        [30] = 5,
        [33] = 5,
        [43] = 5,
        [46] = 5,
        [6] = 30,
        [5] = 10,
    },

    -- -------------------------------------------------------------------------
    -- DUNGEON
    -- -------------------------------------------------------------------------
    [FourCC('culw')] = { -- Cultist Enforcer
        none = 90,
        [14] = 1,
        [13] = 1,
        [31] = 1,
        [6] = 30,
        [5] = 10,
    },
    [FourCC('cult')] = { -- Cultist Worker
        none = 90,
        [14] = 1,
        [13] = 1,
        [31] = 1,
        [6] = 30,
        [5] = 10,
    },
    [FourCC('ecul')] = { -- Cultist Bodyguard
        none = 90,
        [14] = 1,
        [13] = 1,
        [31] = 1,
        [6] = 30,
        [5] = 10,
    },

    -- -------------------------------------------------------------------------
    -- BOSSES
    -- -------------------------------------------------------------------------
    [FourCC('hbld')] = { -- Alpha Wolf
        [11] = 60,
        [26] = 40,
        [42] = 40,
    },
    [FourCC('hbos')] = { -- Giant Turtle
        none = 20,
        [15] = 80,
    },
    [FourCC('mine')] = { -- Miner Joe
        [17] = 25,
        [34] = 25,
        [44] = 25,
        [47] = 25,
    },
    [FourCC('over')] = { -- Overseer Tom
        [21] = 22,
        [24] = 22,
        [28] = 22,
        [40] = 22,
        [36] = 12,
    },

}

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
    local drops = DROP_TABLE[unitId]
    if drops == nil then
        return nil
    end

    local totalWeights = 0
    for _, weight in pairs(drops) do
        totalWeights = totalWeights + weight
    end

    local randNum = GetRandomReal(0, totalWeights-1)
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
                'You looted ' .. itemInfo.name,
                log.TYPE.INFO)
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
                itemmanager.getItemInfo(drop).name,
            log.TYPE.INFO)
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
                        itemmanager.getItemInfo(drop).name,
                    log.TYPE.INFO)
            end
        end
    end
    if type == 2 then -- pass
        log.log(
            playerId,
            'You passed on ' .. itemmanager.getItemInfo(drop).name,
            log.TYPE.INFO)
        for _, otherPlayerId in pairs(rolls[rollId].players) do
            if otherPlayerId ~= playerId then
                log.log(
                    otherPlayerId,
                    GetPlayerName(Player(playerId)) ..
                        ' passed on ' ..
                        itemmanager.getItemInfo(drop).name,
                    log.TYPE.INFO)
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
                    itemmanager.getItemInfo(drop).name ..
                    '.',
                log.TYPE.INFO)
        end

        DestroyTimer(rolls[rollId].timer)
        rolls[rollId] = nil
    elseif winnerPlayerId ~= nil then
        backpack.addItemIdToBackpack(winnerPlayerId, drop)
        log.log(
            winnerPlayerId,
            'You won ' .. itemmanager.getItemInfo(drop).name .. '!',
            log.TYPE.INFO)
        for _, playerId in pairs(rolls[rollId].players) do
            if playerId ~= winnerPlayerId then
                log.log(
                    playerId,
                    GetPlayerName(Player(winnerPlayerId)) ..
                        ' won ' ..
                        itemmanager.getItemInfo(drop).name ..
                        '.',
                    log.TYPE.INFO)
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
    DROP_TABLE = DROP_TABLE,
    init = init,
    getItemIdForRoll = getItemIdForRoll,
    getTimerForRoll = getTimerForRoll,
    onRollMade = onRollMade,
}