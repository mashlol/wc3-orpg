local hero = require('src/hero.lua')
local effect = require('src/effect.lua')
local target = require('src/target.lua')

local mousePositions = {}

for i=0, bj_MAX_PLAYERS, 1 do
    mousePositions[i] = {x = 0, y = 0}
end

local getMouseX = function(playerId)
    return mousePositions[playerId].x
end

local getMouseY = function(playerId)
    return mousePositions[playerId].y
end

local mouseMoved = function()
    local pos = BlzGetTriggerPlayerMousePosition()
    local playerId = GetPlayerId(GetTriggerPlayer())
    mousePositions[playerId].x = GetLocationX(pos)
    mousePositions[playerId].y = GetLocationY(pos)
end

local mouseUp = function()
    local btn = BlzGetTriggerPlayerMouseButton()
    local mouseUnit = BlzGetMouseFocusUnit()
    local playerId = GetPlayerId(GetTriggerPlayer())
    if playerId == GetPlayerId(GetLocalPlayer()) and mouseUnit ~= nil then
        target.syncTarget(mouseUnit)
    end
end

local init = function()
    local mouseMoveTrigger = CreateTrigger()
    local mouseUpTrigger = CreateTrigger()

    for i=0,bj_MAX_PLAYER_SLOTS-1,1 do
        TriggerRegisterPlayerEvent(
            mouseMoveTrigger, Player(i), EVENT_PLAYER_MOUSE_MOVE)
        TriggerRegisterPlayerEvent(
            mouseUpTrigger, Player(i), EVENT_PLAYER_MOUSE_DOWN)
    end

    TriggerAddAction(mouseMoveTrigger, mouseMoved)
    TriggerAddAction(mouseUpTrigger, mouseUp)
end

return {
    getMouseX = getMouseX,
    getMouseY = getMouseY,
    init = init,
}
