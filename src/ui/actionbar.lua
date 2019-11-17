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

    local actionBar = BlzCreateFrameByType(
        "FRAME",
        "actionBar",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        actionBar, (consts.ACTION_ITEM_SIZE * 0.9) * 6, consts.ACTION_ITEM_SIZE)
    BlzFrameSetAbsPoint(
        actionBar, FRAMEPOINT_BOTTOM, 0.4, 0.01)

    local actionItems = {}
    for i=0,5,1 do
        local actionItemOrigin = BlzCreateFrameByType(
            "BACKDROP",
            "actionItemOrigin",
            actionBar,
            "",
            0)
        BlzFrameSetSize(
            actionItemOrigin, consts.ACTION_ITEM_SIZE, consts.ACTION_ITEM_SIZE)
        BlzFrameSetPoint(
            actionItemOrigin,
            FRAMEPOINT_LEFT,
            actionBar,
            FRAMEPOINT_LEFT,
            i * (consts.ACTION_ITEM_SIZE * 0.9),
            0)
        BlzFrameSetTexture(
            actionItemOrigin,
            "war3mapImported\\ui\\ab_spell_frame.blp",
            0,
            true)

        local actionItemIcon = BlzCreateFrameByType(
            "BACKDROP",
            "actionItemIcon",
            actionItemOrigin,
            "",
            0)
        BlzFrameSetSize(
            actionItemIcon,
            consts.ACTION_ITEM_SIZE * 0.75,
            consts.ACTION_ITEM_SIZE * 0.75)
        BlzFrameSetPoint(
            actionItemIcon,
            FRAMEPOINT_CENTER,
            actionItemOrigin,
            FRAMEPOINT_CENTER,
            0,
            0)

        local actionCooldownBackdrop = BlzCreateFrameByType(
            "BACKDROP",
            "actionCooldownBackdrop",
            actionItemOrigin,
            "",
            0)
        BlzFrameSetSize(
            actionCooldownBackdrop,
            consts.ACTION_ITEM_SIZE * 0.75,
            consts.ACTION_ITEM_SIZE * 0.75)
        BlzFrameSetPoint(
            actionCooldownBackdrop,
            FRAMEPOINT_BOTTOM,
            actionItemIcon,
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
            actionItemOrigin,
            "",
            0)
        BlzFrameSetAllPoints(actionTintBackdrop, actionItemIcon)
        BlzFrameSetTexture(
            actionTintBackdrop,
            "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
            0,
            true)
        BlzFrameSetAlpha(actionTintBackdrop, 80)

        local actionItemShortcutBackdrop = BlzCreateFrameByType(
            "BACKDROP",
            "actionItemShortcutBackdrop",
            actionItemOrigin,
            "",
            0)
        BlzFrameSetSize(
            actionItemShortcutBackdrop,
            consts.ACTION_ITEM_SIZE * 0.4,
            consts.ACTION_ITEM_SIZE * 0.4)
        BlzFrameSetPoint(
            actionItemShortcutBackdrop,
            FRAMEPOINT_BOTTOM,
            actionItemOrigin,
            FRAMEPOINT_BOTTOM,
            0,
            -0.004)
        BlzFrameSetTexture(
            actionItemShortcutBackdrop,
            "war3mapImported\\ui\\shortcut_frame.blp",
            0,
            true)

        local actionHotkey = BlzCreateFrameByType(
            "TEXT",
            "actionItemHotkey",
            actionItemOrigin,
            "",
            0)
        BlzFrameSetAllPoints(actionHotkey, actionItemShortcutBackdrop)
        BlzFrameSetTextAlignment(
            actionHotkey,
            TEXT_JUSTIFY_MIDDLE,
            TEXT_JUSTIFY_CENTER)
        BlzFrameSetScale(actionHotkey, 0.7)
        BlzFrameSetText(actionHotkey, DEFAULT_HOTKEYS[i+1])

        local actionCooldownText = BlzCreateFrameByType(
            "TEXT",
            "actionCooldownText",
            actionItemOrigin,
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
            actionItemOrigin,
            FRAMEPOINT_CENTER,
            0,
            0)
        BlzFrameSetTextAlignment(
            actionCooldownText, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)

        local tooltipFrame = tooltip.makeTooltipFrame(
            actionItemOrigin, 0.24, 0.095)

        table.insert(actionItems, {
            icon = actionItemIcon,
            actionCooldownBackdrop = actionCooldownBackdrop,
            actionCooldownText = actionCooldownText,
            tooltipFrame = tooltipFrame,
            actionTintBackdrop = actionTintBackdrop
        })
    end

    self.frames = {
        origin = actionBar,
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

    local isVisible = self.hero ~= nil
    BlzFrameSetVisible(frame.origin, isVisible)

    if not isVisible then
        return
    end

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

        BlzFrameSetVisible(
            actionItem.actionTintBackdrop,
            cdPct ~= 0 and spellIcon ~= nil)

        BlzFrameSetSize(
            actionItem.actionCooldownBackdrop,
            consts.ACTION_ITEM_SIZE * 0.75,
            consts.ACTION_ITEM_SIZE * 0.75 * cdPct)

        BlzFrameSetVisible(actionItem.icon, spellIcon)

        if spellIcon ~= nil then
            BlzFrameSetTexture(actionItem.icon, spellIcon, 0, true)
        end

        BlzFrameSetText(actionItem.tooltipFrame.text, spellTooltip)
    end
end

return ActionBar

