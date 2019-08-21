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

local mouseDown = function()
    local btn = BlzGetTriggerPlayerMouseButton()
    local playerId = GetPlayerId(GetTriggerPlayer())

    if BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_RIGHT then
        local hero = hero.getHero(playerId)
        IssuePointOrder(
            hero,
            "move",
            mousePositions[playerId].x,
            mousePositions[playerId].y)
        effect.createEffect{
            model = playerId == GetPlayerId(GetLocalPlayer()) and "econ" or "enon",
            x = mousePositions[playerId].x,
            y = mousePositions[playerId].y,
            duration = 0,
        }
    end
end

local init = function()
    local mouseMoveTrigger = CreateTrigger()
    local mouseDownTrigger = CreateTrigger()

    for i=0,bj_MAX_PLAYER_SLOTS-1,1 do
        TriggerRegisterPlayerEvent(
            mouseMoveTrigger, Player(i), EVENT_PLAYER_MOUSE_MOVE)
        TriggerRegisterPlayerEvent(
            mouseDownTrigger, Player(i), EVENT_PLAYER_MOUSE_DOWN)
    end

    TriggerAddAction(mouseMoveTrigger, mouseMoved)
    TriggerAddAction(mouseDownTrigger, mouseDown)
end

return {
    getMouseX = getMouseX,
    getMouseY = getMouseY,
    init = init,
}
