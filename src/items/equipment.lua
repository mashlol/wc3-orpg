local SLOT = {
    HELMET = 1,
    NECK = 2,
    CHEST = 3,
    BACK = 4,
    HANDS = 5,
    LEGS = 6,
    FEET = 7,
    RING = 8,
    WEAPON = 9,
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

function equipItem(playerId, slot, itemId)
    equipments[playerId][slot] = itemId
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
    for i=1,9,1 do
        equipments[playerId][i] = nil
    end
end

function getSlotName(slot)
    if slot == SLOT.HELMET then
        return "Head"
    elseif slot == SLOT.NECK then
        return "Neck"
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
    elseif slot == SLOT.WEAPON then
        return "Weapon"
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
