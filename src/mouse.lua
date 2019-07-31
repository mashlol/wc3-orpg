local trigger = CreateTrigger()

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

local init = function()
    -- TODO make for all players
    TriggerRegisterPlayerEvent(trigger, Player(0), EVENT_PLAYER_MOUSE_MOVE)
    TriggerRegisterPlayerEvent(trigger, Player(1), EVENT_PLAYER_MOUSE_MOVE)

    TriggerAddAction(trigger, mouseMoved)
end

return {
    getMouseX = getMouseX,
    getMouseY = getMouseY,
    init = init,
}
