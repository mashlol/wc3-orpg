local consts = require('src/ui/consts.lua')
local tooltip = require('src/ui/tooltip.lua')
local spell = require('src/spell.lua')

local DEFAULT_HOTKEYS = {
    "Q", "W", "E", "R",
    "D", "F"
}

local ActionBar = {}

function ActionBar:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function ActionBar:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    -- local bottomBarBackground = BlzCreateFrame("Leaderboard", originFrame, 0, 0)
    -- BlzFrameSetSize(bottomBarBackground, 0.26, 0.06)
    -- BlzFrameSetAbsPoint(bottomBarBackground, FRAMEPOINT_BOTTOMLEFT, 0.3, 0)

    local actionBar = BlzCreateFrameByType(
        "FRAME",
        "actionBar",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        actionBar, consts.ACTION_ITEM_SIZE * 6, consts.ACTION_ITEM_SIZE)
    BlzFrameSetAbsPoint(
        actionBar, FRAMEPOINT_CENTER, 0.4, consts.ACTION_ITEM_SIZE - 0.01)

    local actionItems = {}
    for i=0,5,1 do
        local actionItem = BlzCreateFrameByType(
            "BACKDROP",
            "actionItem",
            BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),
            "",
            0)
        BlzFrameSetSize(
            actionItem, consts.ACTION_ITEM_SIZE, consts.ACTION_ITEM_SIZE)
        BlzFrameSetPoint(
            actionItem,
            FRAMEPOINT_LEFT,
            actionBar,
            FRAMEPOINT_LEFT,
            i * (consts.ACTION_ITEM_SIZE + 0.0015),
            0)

        local actionCooldownBackdrop = BlzCreateFrameByType(
            "BACKDROP",
            "actionCooldownBackdrop",
            actionItem,
            "",
            0)
        BlzFrameSetSize(
            actionCooldownBackdrop,
            consts.ACTION_ITEM_SIZE,
            0)
        BlzFrameSetPoint(
            actionCooldownBackdrop,
            FRAMEPOINT_BOTTOM,
            actionItem,
            FRAMEPOINT_BOTTOM,
            0,
            0)
        BlzFrameSetTexture(
            actionCooldownBackdrop,
            "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
            0,
            true)
        BlzFrameSetAlpha(actionCooldownBackdrop, 200)

        local actionTintBackdrop = BlzCreateFrameByType(
            "BACKDROP",
            "actionTintBackdrop",
            actionItem,
            "",
            0)
        BlzFrameSetAllPoints(actionTintBackdrop, actionItem)
        BlzFrameSetTexture(
            actionTintBackdrop,
            "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
            0,
            true)
        BlzFrameSetAlpha(actionTintBackdrop, 80)

        local actionHotkey = BlzCreateFrameByType(
            "TEXT",
            "actionItemHotkey",
            actionItem,
            "",
            0)
        BlzFrameSetSize(actionHotkey, 0.01, 0.01)
        BlzFrameSetText(actionHotkey, DEFAULT_HOTKEYS[i+1])
        BlzFrameSetPoint(
            actionHotkey,
            FRAMEPOINT_TOPLEFT,
            actionItem,
            FRAMEPOINT_TOPLEFT,
            0.002,
            -0.002)

        local actionCooldownText = BlzCreateFrameByType(
            "TEXT",
            "actionCooldownText",
            actionItem,
            "",
            0)
        BlzFrameSetSize(
            actionCooldownText,
            consts.ACTION_ITEM_SIZE,
            consts.ACTION_ITEM_SIZE)
        BlzFrameSetText(actionCooldownText, "")
        BlzFrameSetPoint(
            actionCooldownText,
            FRAMEPOINT_CENTER,
            actionItem,
            FRAMEPOINT_CENTER,
            0,
            0)
        BlzFrameSetTextAlignment(
            actionCooldownText, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)

        local tooltipFrame = tooltip.makeTooltipFrame(actionItem, 0.24, 0.095)

        table.insert(actionItems, {
            actionItemBackground = actionItem,
            actionCooldownBackdrop = actionCooldownBackdrop,
            actionCooldownText = actionCooldownText,
            tooltipFrame = tooltipFrame,
        })
    end

    self.frames = {
        actionItems = actionItems,
    }

    return self
end

local convertCdToString = function(cd)
    if cd <= 10 and cd >= 0 then
        local cdStr = SubString(cd, 0, 4)

        return cd > 0 and cdStr.."s" or ""
    end

    if cd >= 1 and cd < 60 then
        return R2I(cd).."s"
    end

    if cd >= 60 and cd < 3600 then
        local mins = R2I(cd / 60)
        local sec = R2I(cd % 60)

        return mins.."m"..(sec > 0 and sec.."s" or "")
    end

    local hours = R2I(cd / 3600)
    local min = R2I(cd % 3600 / 60)

    return hours.."h"..(min > 0 and min.."m" or "")
end

function ActionBar:update(playerId)
    local frame = self.frames

    for idx,actionItem in pairs(frame.actionItems) do
        local cdPct = spell.getCooldownPct(playerId, idx)
        local cdSec = spell.getCooldown(playerId, idx)
        local spellIcon = spell.getIcon(playerId, idx)
        local spellTooltip = spell.getSpellTooltip(playerId, idx)

        BlzFrameSetText(
            actionItem.actionCooldownText,
            convertCdToString(cdSec))

        BlzFrameSetVisible(
            actionItem.actionCooldownBackdrop,
            cdPct ~= 0 and spellIcon ~= nil)

        BlzFrameSetSize(
            actionItem.actionCooldownBackdrop,
            consts.ACTION_ITEM_SIZE,
            consts.ACTION_ITEM_SIZE * cdPct)

        BlzFrameSetTexture(
            actionItem.actionItemBackground,
            spellIcon or "UI/Widgets/Console/Human/human-inventory-slotfiller.blp",
            0,
            true)

        BlzFrameSetText(actionItem.tooltipFrame.text, spellTooltip)
    end
end

return ActionBar

