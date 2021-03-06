local log = require('src/log.lua')
local hero = require('src/hero.lua')
local itemmanager = require('src/items/itemmanager.lua')


local NUM_SLOTS = 12
local SLOT = {
    HELMET = 1,
    NECK = 2,
    SHOULDERS = 3,
    CHEST = 4,
    BACK = 5,
    HANDS = 6,
    LEGS = 7,
    FEET = 8,
    RING = 9,
    TRINKET = 10,
    WEAPON = 11,
    OFFHAND = 12,
}

-- equipments = {
--     [playerId] = {
--         [slotId] = itemId,
--     }
-- }
local equipments = {}

-- activeItemPositions = {
--     [playerId] = nil or 1 (item index, not item id)
-- }
local activeItemPositions = {}

function isInList(list, val)
    for idx, valB in pairs(list) do
        if valB == val then
            return true
        end
    end
    return false
end

function equipItem(playerId, slot, itemId)
    local itemInfo = itemmanager.getItemInfo(itemId)
    local heroUnit = hero.getHero(playerId)
    local currentLevel = GetHeroLevel(heroUnit)
    if currentLevel < itemInfo.requiredLevel then
        log.log(
            playerId,
            'You must be level ' ..
                itemInfo.requiredLevel ..
                ' to equip that item.',
            log.TYPE.EQUIPMENT_ERROR)
        return false
    end
    local heroType = hero.getPickedHero(playerId).id
    if
        itemInfo.usableClasses ~= nil and
        not isInList(itemInfo.usableClasses, heroType)
    then
        log.log(
            playerId,
            'You are not able to equip that item.',
            log.TYPE.EQUIPMENT_ERROR)
        return false
    end

    equipments[playerId][slot] = itemId

    return true
end

function unequipItem(playerId, slot)
    equipments[playerId][slot] = nil
end

function getItemInSlot(playerId, slot)
    if equipments[playerId][slot] == 0 then
        return nil
    end
    return equipments[playerId][slot]
end

local activateItem = function(playerId, slot)
    if getItemInSlot(playerId, slot) ~= nil then
        activeItemPositions[playerId] = slot
    else
        activeItemPositions[playerId] = nil
    end
end

local getActiveItem = function(playerId)
    return activeItemPositions[playerId]
end

local getEquippedItems = function(playerId)
    return equipments[playerId]
end

function clear(playerId)
    for i=1,NUM_SLOTS,1 do
        equipments[playerId][i] = nil
    end
end

function getSlotName(slot)
    if slot == SLOT.HELMET then
        return "Head"
    elseif slot == SLOT.NECK then
        return "Necklace"
    elseif slot == SLOT.SHOULDERS then
        return "Shoulders"
    elseif slot == SLOT.CHEST then
        return "Chest"
    elseif slot == SLOT.BACK then
        return "Back"
    elseif slot == SLOT.HANDS then
        return "Hands"
    elseif slot == SLOT.LEGS then
        return "Legs"
    elseif slot == SLOT.FEET then
        return "Feet"
    elseif slot == SLOT.RING then
        return "Ring"
    elseif slot == SLOT.TRINKET then
        return "Trinket"
    elseif slot == SLOT.WEAPON then
        return "Weapon"
    elseif slot == SLOT.OFFHAND then
        return "Off-hand"
    end
    return nil
end

function init()
    for i=0,bj_MAX_PLAYERS,1 do
        equipments[i] = {}
    end
end

return {
    init = init,
    SLOT = SLOT,
    clear = clear,
    getSlotName = getSlotName,
    equipItem = equipItem,
    unequipItem = unequipItem,
    getItemInSlot = getItemInSlot,
    activateItem = activateItem,
    getActiveItem = getActiveItem,
    getEquippedItems = getEquippedItems,
}
