local log = require('src/log.lua')
local consts = require('src/ui/consts.lua')
local utils = require('src/ui/utils.lua')
local tooltip = require('src/ui/tooltip.lua')

-- dialogToggles = {
--     [playerId] = {
--         text = "text",
--         height = 0.4,
--         button = "Accept",
--         onButtonClicked = [function],
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
    BlzFrameSetText(text, "This is the dialog text|n|nI want you to get some shit for me|n|n|n|nObjectives:|n- Kill 10 spiders|n|nRewards:|n- 50 gold|n- 150 experience")

    local button = BlzCreateFrame("ScriptDialogButton", originFrame, 0, 0)
    local buttonText = BlzGetFrameByName("ScriptDialogButtonText", 0)
    BlzFrameSetParent(button, origin)
    BlzFrameSetSize(button, 0.12, 0.04)
    BlzFrameSetPoint(
        button,
        FRAMEPOINT_BOTTOM,
        origin,
        FRAMEPOINT_BOTTOM,
        0,
        0.01)
    BlzFrameSetText(buttonText, "Accept")

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        trig, button, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        local playerId = GetPlayerId(GetTriggerPlayer())
        if
            dialogToggles[playerId] ~= nil and
            dialogToggles[playerId].onButtonClicked
        then
            dialogToggles[playerId].onButtonClicked()
        end

        dialogToggles[playerId] = nil

        BlzFrameSetEnable(BlzGetTriggerFrame(), false)
        BlzFrameSetEnable(BlzGetTriggerFrame(), true)
    end)

    self.frames = {
        origin = origin,
        text = text,
        button = button,
        buttonText = buttonText,
    }

    return self
end

function Dialog:update(playerId)
    local frames = self.frames

    BlzFrameSetVisible(frames.origin, dialogToggles[playerId] ~= nil)

    BlzFrameSetText(
        frames.text,
        dialogToggles[playerId] ~= nil and dialogToggles[playerId].text or "")
    BlzFrameSetText(
        frames.buttonText,
        dialogToggles[playerId] ~= nil and dialogToggles[playerId].button or "")
    BlzFrameSetSize(
        frames.origin,
        consts.DIALOG_WIDTH,
        dialogToggles[playerId] ~= nil and
            dialogToggles[playerId].height or
            consts.DIALOG_HEIGHT)
end

return Dialog
