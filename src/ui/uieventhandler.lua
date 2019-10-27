local playerMouseButtons = {}
local playerHoveringFrames = {}
local playerMouseDownFrame = {}

local frameCallbacks = {}

function registerClickEvent(frame, callback)
    local enterTrig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        enterTrig, frame, FRAMEEVENT_MOUSE_ENTER)
    TriggerAddAction(enterTrig, function()
        local playerId = GetPlayerId(GetTriggerPlayer())
        playerHoveringFrames[playerId] = frame
    end)

    local leaveTrig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        leaveTrig, frame, FRAMEEVENT_MOUSE_LEAVE)
    TriggerAddAction(leaveTrig, function()
        local playerId = GetPlayerId(GetTriggerPlayer())
        playerHoveringFrames[playerId] = nil
    end)

    frameCallbacks[GetHandleId(frame)] = callback
end

function onMouseDown()
    local playerId = GetPlayerId(GetTriggerPlayer())
    playerMouseButtons[playerId] = BlzGetTriggerPlayerMouseButton()

    playerMouseDownFrame[playerId] = playerHoveringFrames[playerId]
end

function onMouseUp()
    local playerId = GetPlayerId(GetTriggerPlayer())

    if
        playerMouseDownFrame[playerId] ~= nil and
        playerMouseDownFrame[playerId] == playerHoveringFrames[playerId]
    then
        -- Its a frame click!
        local frame = playerHoveringFrames[playerId]
        BlzFrameSetEnable(frame, false)
        BlzFrameSetEnable(frame, true)
        frameCallbacks[GetHandleId(frame)](
            playerId, playerMouseButtons[playerId])
    end

    playerMouseButtons[playerId] = nil
end

function init()
    local mouseDownTrigger = CreateTrigger()
    for i=0,bj_MAX_PLAYER_SLOTS-1,1 do
        TriggerRegisterPlayerEvent(
            mouseDownTrigger, Player(i), EVENT_PLAYER_MOUSE_DOWN)
    end
    TriggerAddAction(mouseDownTrigger, onMouseDown)

    local mouseUpTrigger = CreateTrigger()
    for i=0,bj_MAX_PLAYER_SLOTS-1,1 do
        TriggerRegisterPlayerEvent(
            mouseUpTrigger, Player(i), EVENT_PLAYER_MOUSE_UP)
    end
    TriggerAddAction(mouseUpTrigger, onMouseUp)
end

return {
    init = init,
    registerClickEvent = registerClickEvent,
}