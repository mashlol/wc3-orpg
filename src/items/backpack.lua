local itemmanager = require('src/items/itemmanager.lua')

-- backpacks = {
--     [playerId] = {
--         [1] = {itemId = [itemId1], count = 1},
--         [2] = {itemId = [itemId2], count = 1},
--         [4] = {itemId = [itemId4], count = 10},
--     }
-- }
local backpacks = {}

-- activeItemPositions = {
--     [playerId] = nil or 1 (item index, not item id)
-- }
local activeItemPositions = {}

local listeners = {}

function addItemIdToBackpack(playerId, itemId, count)
    count = count or 1

    for idx,itemInfo in pairs(backpacks[playerId]) do
        if
            itemInfo.itemId == itemId and
            itemInfo.count <
                itemmanager.getItemInfo(itemInfo.itemId).stackSize - count + 1
        then
            backpacks[playerId][idx].count =
                backpacks[playerId][idx].count + count
            notifyListeners(playerId)
            return
        end
    end

    table.insert(backpacks[playerId], {
        itemId = itemId,
        count = count,
    })
    notifyListeners(playerId)
end

function addItemIdToBackpackPosition(playerId, position, itemId, count)
    backpacks[playerId][position] = {itemId = itemId, count = count or 1}
    notifyListeners(playerId, itemId, count)
end

function removeItemFromBackpack(playerId, position, count)
    count = count or 1

    if backpacks[playerId][position] ~= nil then
        backpacks[playerId][position].count =
            backpacks[playerId][position].count - 1
        if backpacks[playerId][position].count <= 0 then
            backpacks[playerId][position] = nil
        end
    end
    notifyListeners(playerId)
end

function removeItemIdFromBackpack(playerId, itemId)
    for idx, itemInfo in pairs(backpacks[playerId]) do
        if itemInfo.itemId == itemId then
            removeItemFromBackpack(playerId, idx, 1)
            notifyListeners(playerId)
            return true
        end
    end
    return false
end

function getItemCount(playerId, itemId)
    local count = 0
    for _, itemInfo in pairs(backpacks[playerId]) do
        if itemInfo.itemId == itemId then
            count = count + itemInfo.count
        end
    end
    return count
end

function getItemIdsInBackpack(playerId)
    return backpacks[playerId]
end

function getItemIdAtPosition(playerId, position)
    if backpacks[playerId][position] == nil then
        return nil
    end
    return backpacks[playerId][position].itemId
end

function getItemCountAtPosition(playerId, position)
    if backpacks[playerId][position] == nil then
        return nil
    end
    return backpacks[playerId][position].count
end

function swapPositions(playerId, position1, position2)
    local temp = backpacks[playerId][position1]
    backpacks[playerId][position1] = backpacks[playerId][position2]
    backpacks[playerId][position2] = temp
    notifyListeners(playerId)
end

function getFilledSlotCount(playerId)
    local count = 0
    for _, _ in pairs(backpacks[playerId]) do
        count = count + 1
    end
    return count
end

local activateItem = function(playerId, position)
    if getItemIdAtPosition(playerId, position) ~= nil then
        activeItemPositions[playerId] = position
    else
        activeItemPositions[playerId] = nil
    end
end

local getActiveItem = function(playerId)
    return activeItemPositions[playerId]
end

function clear(playerId)
    for i=1,36,1 do
        backpacks[playerId][i] = nil
    end
end

function addBackpackChangedListener(listener)
    table.insert(listeners, listener)
end

function notifyListeners(playerId)
    for _, listener in pairs(listeners) do
        listener(playerId)
    end
end

function init()
    for i=0,bj_MAX_PLAYERS,1 do
        backpacks[i] = {}
    end
end

return {
    init = init,
    clear = clear,
    addItemIdToBackpack = addItemIdToBackpack,
    addItemIdToBackpackPosition = addItemIdToBackpackPosition,
    removeItemFromBackpack = removeItemFromBackpack,
    removeItemIdFromBackpack = removeItemIdFromBackpack,
    getItemCount = getItemCount,
    getFilledSlotCount = getFilledSlotCount,
    getItemIdsInBackpack = getItemIdsInBackpack,
    getItemIdAtPosition = getItemIdAtPosition,
    getItemCountAtPosition = getItemCountAtPosition,
    swapPositions = swapPositions,
    activateItem = activateItem,
    getActiveItem = getActiveItem,
    addBackpackChangedListener = addBackpackChangedListener,
}
