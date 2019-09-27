-- buttonToggles = {
--     [playerId] = {
--         text = "text",
--         onClick = [function],
--     },
-- }
local buttonToggles = {}

local SimpleButton = {
    show = function(playerId, info)
        buttonToggles[playerId] = info
    end,
    hide = function(playerId)
        buttonToggles[playerId] = nil
    end
}

function SimpleButton:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function SimpleButton:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local button = BlzCreateFrame("ScriptDialogButton", originFrame, 0, 0)
    local buttonText = BlzGetFrameByName("ScriptDialogButtonText", 0)
    BlzFrameSetSize(button, 0.12, 0.04)
    BlzFrameSetAbsPoint(
        button,
        FRAMEPOINT_CENTER,
        0.4,
        0.16)
    BlzFrameSetText(buttonText, "Load Existing Hero")
    BlzFrameSetScale(buttonText, 0.8)

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        trig, button, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        local playerId = GetPlayerId(GetTriggerPlayer())

        if
            buttonToggles[playerId] ~= nil and
            buttonToggles[playerId].onClick
        then
            buttonToggles[playerId].onClick()
        end

        buttonToggles[playerId] = nil

        BlzFrameSetEnable(BlzGetTriggerFrame(), false)
        BlzFrameSetEnable(BlzGetTriggerFrame(), true)
    end)

    self.frames = {
        button = button,
        text = buttonText,
    }

    return self
end

function SimpleButton:update(playerId)
    local frames = self.frames

    BlzFrameSetVisible(frames.button, buttonToggles[playerId] ~= nil)

    BlzFrameSetText(
        frames.text,
        buttonToggles[playerId] ~= nil and buttonToggles[playerId].text or "")
end

return SimpleButton
