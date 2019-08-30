local consts = require('src/ui/consts.lua')
local spell = require('src/spell.lua')

local DEFAULT_HOTKEYS = {
    "Q", "W", "E", "R",
    "A", "S", "D", "F",
    "Z", "X", "C", "V"
}

local ActionBar = {}

function ActionBar:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

local makeTooltipFrame = function(actionItem)
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local tooltipOrigin = BlzCreateFrameByType(
        "FRAME",
        "tooltipOrigin",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        tooltipOrigin,
        0.24,
        0.095)
    BlzFrameSetPoint(
        tooltipOrigin,
        FRAMEPOINT_CENTER,
        actionItem,
        FRAMEPOINT_CENTER,
        0,
        0.08)

    local tooltipBackdrop = BlzCreateFrameByType(
        "BACKDROP",
        "tooltipBackdrop",
        tooltipOrigin,
        "",
        0)
    BlzFrameSetAllPoints(tooltipBackdrop, tooltipOrigin)
    BlzFrameSetTexture(
        tooltipBackdrop,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)
    BlzFrameSetAlpha(tooltipBackdrop, 200)

    local tooltipText = BlzCreateFrameByType(
        "TEXT",
        "tooltipText",
        tooltipOrigin,
        "",
        0)

    BlzFrameSetSize(
        tooltipText,
        0.23,
        0.085)
    BlzFrameSetPoint(
        tooltipText,
        FRAMEPOINT_CENTER,
        tooltipOrigin,
        FRAMEPOINT_CENTER,
        0,
        0)

    return {
        origin = tooltipOrigin,
        text = tooltipText,
    }
end

function ActionBar:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    local actionBar = BlzCreateFrameByType(
        "BACKDROP",
        "actionBar",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        actionBar, consts.ACTION_ITEM_SIZE * 12, consts.ACTION_ITEM_SIZE)
    BlzFrameSetAbsPoint(
        actionBar, FRAMEPOINT_CENTER, 0.4, consts.ACTION_ITEM_SIZE)
    BlzFrameSetTexture(
        actionBar,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)

    local actionItems = {}
    for i=0,11,1 do
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
            i * (consts.ACTION_ITEM_SIZE + 0.001),
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
        BlzFrameSetSize(
            actionTintBackdrop,
            consts.ACTION_ITEM_SIZE,
            consts.ACTION_ITEM_SIZE)
        BlzFrameSetPoint(
            actionTintBackdrop,
            FRAMEPOINT_BOTTOM,
            actionItem,
            FRAMEPOINT_BOTTOM,
            0,
            0)
        BlzFrameSetTexture(
            actionTintBackdrop,
            "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
            0,
            true)
        BlzFrameSetAlpha(actionTintBackdrop, 60)

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
            FRAMEPOINT_TOP_LEFT,
            actionItem,
            FRAMEPOINT_TOP_LEFT,
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

        local hoverFrame = BlzCreateFrameByType(
            "FRAME",
            "hoverFrame",
            actionItem,
            "",
            0)
        BlzFrameSetAllPoints(hoverFrame, actionItem)

        local tooltipFrame = makeTooltipFrame(actionItem)
        BlzFrameSetTooltip(hoverFrame, tooltipFrame.origin)

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

function ActionBar:update(playerId)
    local frame = self.frames

    for idx,actionItem in pairs(frame.actionItems) do
        local cdPct = spell.getCooldownPct(playerId, idx)
        local spellIcon = spell.getIcon(playerId, idx)
        -- local spellName = spell.getSpellName(playerId, idx)
        -- local spellTooltip = spell.getSpellTooltip(playerId, idx)
        -- local spellCooldown = spell.getSpellCooldown(playerId, idx)
        -- local spellCasttime = spell.getSpellCasttime(playerId, idx)

        BlzFrameSetVisible(actionItem.actionCooldownBackdrop, cdPct ~= 0)

        BlzFrameSetSize(
            actionItem.actionCooldownBackdrop,
            consts.ACTION_ITEM_SIZE,
            consts.ACTION_ITEM_SIZE * cdPct)

        BlzFrameSetTexture(
            actionItem.actionItemBackground,
            spellIcon,
            0,
            true)

        -- BlzFrameSetText(
        --     actionItem.tooltipFrame.text,
        --     "|cff155ed4"..spellName.."|r|n|n"..
        --     "Cooldown: "..spellCooldown.."s|n"..
        --     "Cast time: "..spellCasttime.."s|n"..
        --     "|n"..spellTooltip)
    end
end

return ActionBar
