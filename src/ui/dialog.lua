local consts = require('src/ui/consts.lua')
local utils = require('src/ui/utils.lua')

-- dialogToggles = {
--     [playerId] = {
--         text = "text",
--         height = 0.4,
--         xPos = 0.4,
--         positiveButton = "Accept",
--         onPositiveButtonClicked = [function],
--         negativeButton = "Decline",
--         onNegativeButtonClicked = [function],
--     },
-- }
local dialogToggles = {}

local Dialog = {
    show = function(playerId, info)
        dialogToggles[playerId] = info
    end,
    hide = function(playerId)
        dialogToggles[playerId] = nil
    end
}

function Dialog:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function createButton(origin, originFrame, xOffset, isNegative)
    local button = BlzCreateFrame("ScriptDialogButton", originFrame, 0, 0)
    local buttonText = BlzGetFrameByName("ScriptDialogButtonText", 0)
    BlzFrameSetParent(button, origin)
    BlzFrameSetSize(button, 0.12, 0.04)
    BlzFrameSetPoint(
        button,
        FRAMEPOINT_BOTTOM,
        origin,
        FRAMEPOINT_BOTTOM,
        xOffset,
        0.01)

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        trig, button, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        local playerId = GetPlayerId(GetTriggerPlayer())
        if
            dialogToggles[playerId] ~= nil and
            not isNegative and
            dialogToggles[playerId].onPositiveButtonClicked
        then
            dialogToggles[playerId].onPositiveButtonClicked()
        end

        if
            dialogToggles[playerId] ~= nil and
            isNegative and
            dialogToggles[playerId].onNegativeButtonClicked
        then
            dialogToggles[playerId].onNegativeButtonClicked()
        end

        dialogToggles[playerId] = nil

        BlzFrameSetEnable(BlzGetTriggerFrame(), false)
        BlzFrameSetEnable(BlzGetTriggerFrame(), true)
    end)

    return {
        button = button,
        text = buttonText,
    }
end

function Dialog:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local origin = BlzCreateFrameByType(
        "FRAME",
        "origin",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        origin, consts.DIALOG_WIDTH, consts.DIALOG_HEIGHT)
    BlzFrameSetAbsPoint(
        origin,
        FRAMEPOINT_CENTER,
        0.4,
        0.35)

    utils.createBorderFrame(origin)

    local text = BlzCreateFrameByType(
        "TEXT",
        "text",
        origin,
        "",
        0)
    BlzFrameSetSize(text, consts.DIALOG_WIDTH - 0.02, consts.DIALOG_HEIGHT)
    BlzFrameSetPoint(
        text,
        FRAMEPOINT_TOPLEFT,
        origin,
        FRAMEPOINT_TOPLEFT,
        0.01,
        -0.01)

    local positiveButton = createButton(origin, originFrame, 0.07, false)
    local negativeButton = createButton(origin, originFrame, -0.07, true)

    self.frames = {
        origin = origin,
        text = text,
        positiveButton = positiveButton,
        negativeButton = negativeButton,
    }

    return self
end

function Dialog:update(playerId)
    local frames = self.frames

    BlzFrameSetVisible(frames.origin, dialogToggles[playerId] ~= nil)

    BlzFrameSetAbsPoint(
        frames.origin,
        FRAMEPOINT_CENTER,
        dialogToggles[playerId] ~= nil and dialogToggles[playerId].xPos or 0.4,
        0.35)

    BlzFrameSetText(
        frames.text,
        dialogToggles[playerId] ~= nil and dialogToggles[playerId].text or "")

    if
        dialogToggles[playerId] ~= nil and
        dialogToggles[playerId].positiveButton and
        not dialogToggles[playerId].negativeButton
    then
        BlzFrameSetPoint(
            frames.positiveButton.button,
            FRAMEPOINT_BOTTOM,
            frames.origin,
            FRAMEPOINT_BOTTOM,
            0,
            0.01)
    else
        BlzFrameSetPoint(
            frames.positiveButton.button,
            FRAMEPOINT_BOTTOM,
            frames.origin,
            FRAMEPOINT_BOTTOM,
            0.07,
            0.01)
    end

    BlzFrameSetVisible(
        frames.positiveButton.button,
        dialogToggles[playerId] ~= nil and dialogToggles[playerId].positiveButton)
    BlzFrameSetVisible(
        frames.negativeButton.button,
        dialogToggles[playerId] ~= nil and dialogToggles[playerId].negativeButton)
    BlzFrameSetText(
        frames.positiveButton.text,
        dialogToggles[playerId] ~= nil and dialogToggles[playerId].positiveButton or "")
    BlzFrameSetText(
        frames.negativeButton.text,
        dialogToggles[playerId] ~= nil and dialogToggles[playerId].negativeButton or "")
    BlzFrameSetSize(
        frames.origin,
        consts.DIALOG_WIDTH,
        dialogToggles[playerId] ~= nil and
            dialogToggles[playerId].height or
            consts.DIALOG_HEIGHT)
end

return Dialog
