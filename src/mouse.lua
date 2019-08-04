local hero = require('src/hero.lua')
local effect = require('src/effect.lua')

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
    local pos = BlzGetTriggerPlayerMousePosition()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local btn = BlzGetTriggerPlayerMouseButton()
    if btn == MOUSE_BUTTON_TYPE_RIGHT then
        -- Move hero to pos
        local hero = hero.getHero(playerId)
        IssuePointOrderLoc(hero, "move", pos)
        effect.createEffect{
            model =
                playerId == GetPlayerId(GetLocalPlayer()) and
                "econ" or
                "enon",
            duration = 1,
            x = GetLocationX(pos),
            y = GetLocationY(pos),
        }
    end
end

local init = function()
    local mouseMoveTrigger = CreateTrigger()
    local mouseUpTrigger = CreateTrigger()

    -- TODO make for all players
    TriggerRegisterPlayerEvent(
        mouseMoveTrigger, Player(0), EVENT_PLAYER_MOUSE_MOVE)
    TriggerRegisterPlayerEvent(
        mouseMoveTrigger, Player(1), EVENT_PLAYER_MOUSE_MOVE)

    TriggerRegisterPlayerEvent(mouseUpTrigger, Player(0), EVENT_PLAYER_MOUSE_DOWN)
    TriggerRegisterPlayerEvent(mouseUpTrigger, Player(1), EVENT_PLAYER_MOUSE_DOWN)


    TriggerAddAction(mouseMoveTrigger, mouseMoved)
    TriggerAddAction(mouseUpTrigger, mouseUp)
end

return {
    getMouseX = getMouseX,
    getMouseY = getMouseY,
    init = init,
}
