local consts = require('src/ui/consts.lua')
local Backpack = require('src/ui/backpack.lua')
local Equipment = require('src/ui/equipment.lua')
local Stats = require('src/ui/stats.lua')
local QuestLog = require('src/ui/questlog.lua')
local Map = require('src/ui/map.lua')
local DpsMeter = require('src/ui/dpsmeter.lua')
local Talents = require('src/ui/talents.lua')
local tooltip = require('src/ui/tooltip.lua')

local MenuButtons = {}

local MENU_BUTTONS = {
    {
        text = "Menu (F10)",
        icon = "settings_icon",
        callback = function()
            local playerId = GetPlayerId(GetTriggerPlayer())
            local menuFrame = BlzGetOriginFrame(ORIGIN_FRAME_SYSTEM_BUTTON, 0)
            if playerId == GetPlayerId(GetLocalPlayer()) then
                BlzFrameClick(menuFrame)
            end
        end
    },
    {
        text = "Inventory (B)",
        icon = "chest_icon",
        callback = function()
            local playerId = GetPlayerId(GetTriggerPlayer())
            Backpack.toggle(playerId)
        end
    },
    {
        text = "Character (C)",
        icon = "hammer_icon",
        callback = function()
            local playerId = GetPlayerId(GetTriggerPlayer())
            Equipment.toggle(playerId)
            Stats.toggle(playerId)
        end
    },
    {
        text = "Quest Log (L)",
        icon = "book_icon",
        callback = function()
            local playerId = GetPlayerId(GetTriggerPlayer())
            QuestLog.toggle(playerId)
        end
    },
    {
        text = "Map (M)",
        icon = "museum_icon",
        callback = function()
            local playerId = GetPlayerId(GetTriggerPlayer())
            Map.toggle(playerId)
        end
    },
    {
        text = "Talents (N)",
        icon = "star_icon",
        callback = function()
            local playerId = GetPlayerId(GetTriggerPlayer())
            Talents.toggle(playerId)
        end
    },
    {
        text = "DPS Meter (T)",
        icon = "swords_icon",
        callback = function()
            local playerId = GetPlayerId(GetTriggerPlayer())
            DpsMeter.toggle(playerId)
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
        #MENU_BUTTONS * consts.MENU_BUTTON_SIZE,
        consts.MENU_BUTTON_SIZE)
    BlzFrameSetAbsPoint(
        menuButtonsOrigin,
        FRAMEPOINT_TOP,
        0.4,
        0.6)

    for i, buttonInfo in pairs(MENU_BUTTONS) do
        local button = BlzCreateFrame(
            "RoundGrungeButtonTemplate", menuButtonsOrigin, 0, 0)
        BlzFrameSetSize(
            button, consts.MENU_BUTTON_SIZE, consts.MENU_BUTTON_SIZE)
        BlzFrameSetPoint(
            button,
            FRAMEPOINT_LEFT,
            menuButtonsOrigin,
            FRAMEPOINT_LEFT,
            (i - 1) * (consts.MENU_BUTTON_SIZE - consts.MENU_BUTTON_SIZE * 0.1),
            0)

        local buttonIcon = BlzCreateFrameByType(
            "BACKDROP",
            "buttonIcon",
            button,
            "",
            0)
        BlzFrameSetSize(
            buttonIcon,
            consts.MENU_BUTTON_SIZE * 0.65,
            consts.MENU_BUTTON_SIZE * 0.65)
        BlzFrameSetPoint(
            buttonIcon,
            FRAMEPOINT_CENTER,
            button,
            FRAMEPOINT_CENTER,
            0,
            0)
        BlzFrameSetTexture(
            buttonIcon,
            "war3mapImported\\ui\\" .. buttonInfo.icon ..".blp",
            0,
            true)

        -- local hoverFrame = BlzCreateFrameByType(
        --     "GLUEBUTTON",
        --     "hoverFrame",
        --     button,
        --     "",
        --     0)

        local tooltipFrame = tooltip.makeTooltipFrame(
            button, 0.08, 0.02, button, true, false, true)

        BlzFrameSetText(tooltipFrame.text, buttonInfo.text)
        BlzFrameSetTextAlignment(
            tooltipFrame.text, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

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
