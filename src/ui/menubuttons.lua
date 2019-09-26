local consts = require('src/ui/consts.lua')
local Backpack = require('src/ui/backpack.lua')
local Equipment = require('src/ui/equipment.lua')
local QuestLog = require('src/ui/questlog.lua')

local MenuButtons = {}

local MENU_BUTTONS = {
    {
        text = "Menu (F10)",
        callback = function()
            local playerId = GetPlayerId(GetTriggerPlayer())
            if playerId == GetPlayerId(GetLocalPlayer()) then
                local menuFrame = BlzGetOriginFrame(ORIGIN_FRAME_SYSTEM_BUTTON, 0)
                BlzFrameClick(menuFrame)
            end
        end
    },
    {
        text = "Inventory (B)",
        callback = function()
            local playerId = GetPlayerId(GetTriggerPlayer())
            Backpack.toggle(playerId)
            Equipment.toggle(playerId)
        end
    },
    {
        text = "Equipment (B)",
        callback = function()
            local playerId = GetPlayerId(GetTriggerPlayer())
            Backpack.toggle(playerId)
            Equipment.toggle(playerId)
        end
    },
    {
        text = "Quest Log (L)",
        callback = function()
            local playerId = GetPlayerId(GetTriggerPlayer())
            QuestLog.toggle(playerId)
        end
    },
}

function MenuButtons:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function MenuButtons:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local menuButtonsOrigin = BlzCreateFrameByType(
        "FRAME",
        "menuButtonsOrigin",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        menuButtonsOrigin,
        #MENU_BUTTONS * consts.MENU_BUTTON_WIDTH,
        consts.MENU_BUTTON_HEIGHT + 0.025)
    BlzFrameSetAbsPoint(
        menuButtonsOrigin,
        FRAMEPOINT_CENTER,
        0.5 - (#MENU_BUTTONS * consts.MENU_BUTTON_WIDTH) / 2,
        0.6)

    for i, buttonInfo in pairs(MENU_BUTTONS) do
        local button = BlzCreateFrame(
            "ScriptDialogButton", menuButtonsOrigin, 0, 0)
        local buttonText = BlzGetFrameByName("ScriptDialogButtonText", 0)
        BlzFrameSetSize(
            button, consts.MENU_BUTTON_WIDTH, consts.MENU_BUTTON_HEIGHT)
        BlzFrameSetPoint(
            button,
            FRAMEPOINT_LEFT,
            menuButtonsOrigin,
            FRAMEPOINT_LEFT, (i - 1) * consts.MENU_BUTTON_WIDTH,
            0)
        BlzFrameSetText(buttonText, buttonInfo.text)
        BlzFrameSetScale(buttonText, 0.5)

        local trig = CreateTrigger()
        BlzTriggerRegisterFrameEvent(trig, button, FRAMEEVENT_CONTROL_CLICK)
        TriggerAddAction(trig, function()
            buttonInfo.callback()
            BlzFrameSetEnable(BlzGetTriggerFrame(), false)
            BlzFrameSetEnable(BlzGetTriggerFrame(), true)
        end)
    end

    return self
end

function MenuButtons:update(playerId)
    -- Nothing to update
end

return MenuButtons
