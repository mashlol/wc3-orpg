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


function equipItem(playerId, slot, itemId)
    equipments[playerId][slot] = itemId
end

function unequipItem(playerId, slot)
    equipments[playerId][slot] = nil
end

function getItemInSlot(playerId, slot)
    return equipments[playerId][slot]
end

function init()
    for i=0,bj_MAX_PLAYERS,1 do
        equipments[i] = {}
    end
end

return {
    init = init,
    SLOT = SLOT,
    equipItem = equipItem,
    unequipItem = unequipItem,
    getItemInSlot = getItemInSlot,
}
