

-- backpacks = {
--     [playerId] = {
--         [1] = [itemId1],
--         [2] = [itemId2],
--         [4] = [itemId4],
--     }
-- }
local backpacks = {}

-- activeItemPositions = {
--     [playerId] = nil or 1 (item index, not item id)
-- }
local activeItemPositions = {}

function addItemIdToBackpack(playerId, itemId)
    -- TODO check if the backpack is full
    -- TODO possibly insert not at the end
    table.insert(backpacks[playerId], itemId)
end

function removeItemFromBackpack(playerId, position)
    backpacks[playerId][position] = nil
end

function getItemIdsInBackpack(playerId)
    return backpacks[playerId]
end

function getItemIdAtPosition(playerId, position)
    return backpacks[playerId][position]
end

function swapPositions(playerId, position1, position2)
    local temp = backpacks[playerId][position1]
    backpacks[playerId][position1] = backpacks[playerId][position2]
    backpacks[playerId][position2] = temp
end

function activateItem(playerId, position)
    if getItemIdAtPosition(playerId, position) ~= nil then
        activeItemPositions[playerId] = position
    else
        activeItemPositions[playerId] = nil
    end
end

function getActiveItem(playerId)
    return activeItemPositions[playerId]
end

function init()
    for i=0,bj_MAX_PLAYERS,1 do
        backpacks[i] = {}
    end
end

return {
    init = init,
    addItemIdToBackpack = addItemIdToBackpack,
    removeItemFromBackpack = removeItemFromBackpack,
    getItemIdsInBackpack = getItemIdsInBackpack,
    getItemIdAtPosition = getItemIdAtPosition,
    swapPositions = swapPositions,
    activateItem = activateItem,
    getActiveItem = getActiveItem,
}
