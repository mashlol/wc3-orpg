local backpack = require('src/items/backpack.lua')
local itemmanager = require('src/items/itemmanager.lua')
local log = require('src/log.lua')

local DROP_TABLE = {
    [FourCC('hmbs')] = {
        none = 90,
        [6] = 30,
        [5] = 10,
        [1] = 5,
        [4] = 1,
		[8] = 5,
    },
    [FourCC('hspi')] = {
        none = 90,
        [6] = 30,
        [5] = 10,
        [1] = 10,
        [2] = 5,
        [3] = 5,
        [4] = 1,
    },
    [FourCC('hwol')] = {
        none = 90,
        [6] = 30,
        [5] = 10,
        [1] = 10,
        [2] = 10,
        [3] = 5,
        [4] = 2,
    },
	[FourCC('lold')] = {
        none = 70,
        [6] = 20,
        [5] = 10,
        [1] = 10,
        [2] = 10,
        [3] = 5,
        [4] = 2,
		[9] = 275,
	},	
	
}

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
    -- TODO do party loot system for certain item rarities
    local unit = GetDyingUnit()
    local killingPlayerId = GetPlayerId(GetOwningPlayer(GetKillingUnit()))

    local drop = maybeGetDrop(unit)
    if drop ~= nil then
        backpack.addItemIdToBackpack(killingPlayerId, drop)
        log.log(
            killingPlayerId,
            'You looted ' .. itemmanager.getItemInfo(drop).name,
            log.TYPE.INFO)
    end
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
}