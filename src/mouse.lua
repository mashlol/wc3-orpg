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
    local playerId = GetPlayerId(GetTriggerPlayer())
    mousePositions[playerId].x = BlzGetTriggerPlayerMouseX()
    mousePositions[playerId].y = BlzGetTriggerPlayerMouseY()
end

local init = function()
    local mouseMoveTrigger = CreateTrigger()

    for i=0,bj_MAX_PLAYER_SLOTS-1,1 do
        TriggerRegisterPlayerEvent(
            mouseMoveTrigger, Player(i), EVENT_PLAYER_MOUSE_MOVE)
    end

    TriggerAddAction(mouseMoveTrigger, mouseMoved)
end

return {
    getMouseX = getMouseX,
    getMouseY = getMouseY,
    init = init,
}
