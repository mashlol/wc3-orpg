local consts = require('src/ui/consts.lua')
local tooltip = require('src/ui/tooltip.lua')
local backpack = require('src/items/backpack.lua')
local itemmanager = require('src/items/itemmanager.lua')
local spell = require('src/spell.lua')

local DEFAULT_HOTKEYS = {
    "1", "2", "3", "4", "5", "6"
}

-- playerHotbars = {
--     [playerId] = {
--         [1] = [itemId],
--         [2] = [itemId],
--     }
-- }
local playerHotbars = {}

local ItemBar = {
    getItemIdInSlot = function(playerId, slot)
        return playerHotbars[playerId][slot]
    end,
}

function ItemBar:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function ItemBar:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    for i=0,bj_MAX_PLAYERS,1 do
        playerHotbars[i] = {}
    end

    local actionBar = BlzCreateFrameByType(
        "FRAME",
        "actionBar",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        actionBar, (consts.ITEM_ITEM_SIZE * 0.9) * 6, consts.ITEM_ITEM_SIZE)
    BlzFrameSetAbsPoint(
        actionBar, FRAMEPOINT_BOTTOM, 0.4, consts.ACTION_ITEM_SIZE + 0.01)

    local actionItems = {}
    for i=0,5,1 do
        local actionItemOrigin = BlzCreateFrameByType(
            "BACKDROP",
            "actionItemOrigin",
            actionBar,
            "",
            0)
        BlzFrameSetSize(
            actionItemOrigin, consts.ITEM_ITEM_SIZE, consts.ITEM_ITEM_SIZE)
        BlzFrameSetPoint(
            actionItemOrigin,
            FRAMEPOINT_LEFT,
            actionBar,
            FRAMEPOINT_LEFT,
            i * (consts.ITEM_ITEM_SIZE * 0.9),
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
            consts.ITEM_ITEM_SIZE * 0.75,
            consts.ITEM_ITEM_SIZE * 0.75)
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
            consts.ITEM_ITEM_SIZE * 0.75,
            consts.ITEM_ITEM_SIZE * 0.75)
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

        local itemCountFrame = BlzCreateFrameByType(
            "TEXT",
            "actionItemHotkey",
            actionItemOrigin,
            "",
            0)
        BlzFrameSetAllPoints(itemCountFrame, actionItemIcon)
        BlzFrameSetTextAlignment(
            itemCountFrame,
            TEXT_JUSTIFY_TOP,
            TEXT_JUSTIFY_RIGHT)

        local actionItemShortcutBackdrop = BlzCreateFrameByType(
            "BACKDROP",
            "actionItemShortcutBackdrop",
            actionItemOrigin,
            "",
            0)
        BlzFrameSetSize(
            actionItemShortcutBackdrop,
            consts.ITEM_ITEM_SIZE * 0.4,
            consts.ITEM_ITEM_SIZE * 0.4)
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
            consts.ITEM_ITEM_SIZE,
            consts.ITEM_ITEM_SIZE)
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

        local hoverFrame = BlzCreateFrameByType(
            "GLUEBUTTON",
            "hoverFrame",
            actionItemOrigin,
            "IconButtonTemplate",
            0)

        local trig = CreateTrigger()
        BlzTriggerRegisterFrameEvent(
            trig, hoverFrame, FRAMEEVENT_CONTROL_CLICK)
        TriggerAddAction(trig, function()
            local playerId = GetPlayerId(GetTriggerPlayer())

            local slot = i + 1

            local activeBagItem = backpack.getActiveItem(playerId)
            if activeBagItem ~= nil then
                playerHotbars[playerId][slot] = backpack.getItemIdAtPosition(
                    playerId, activeBagItem)
                backpack.activateItem(playerId, nil)
            end

            BlzFrameSetEnable(BlzGetTriggerFrame(), false)
            BlzFrameSetEnable(BlzGetTriggerFrame(), true)
        end)

        local tooltipFrame = tooltip.makeTooltipFrame(
            actionItemOrigin, 0.16, 0.24, hoverFrame)

        table.insert(actionItems, {
            actionItemBackground = actionItemIcon,
            actionCooldownBackdrop = actionCooldownBackdrop,
            actionCooldownText = actionCooldownText,
            tooltipFrame = tooltipFrame,
            itemCountFrame = itemCountFrame,
        })
    end

    self.frames = {
        origin = actionBar,
        actionItems = actionItems,
    }

    return self
end

function ItemBar:update(playerId)
    local frame = self.frames

    local isVisible = self.hero ~= nil
    BlzFrameSetVisible(frame.origin, isVisible)

    if not isVisible then
        return
    end

    for idx,actionItem in pairs(frame.actionItems) do
        local itemId = playerHotbars[playerId][idx]

        local itemInfo = itemmanager.getItemInfo(itemId)
        local cdPct = 0.000001
        local itemCount = ""
        if itemInfo ~= nil then
            BlzFrameSetTexture(
                actionItem.actionItemBackground,
                itemInfo.icon,
                0,
                true)
            if itemInfo.spell ~= nil then
                cdPct = spell.getCooldownPctBySpellKey(
                    playerId, itemInfo.spell)
            end
            itemCount = backpack.getItemCount(playerId, itemId)
        end

        BlzFrameSetVisible(actionItem.actionItemBackground, itemInfo)

        BlzFrameSetSize(
            actionItem.actionCooldownBackdrop,
            consts.ITEM_ITEM_SIZE * 0.75,
            consts.ITEM_ITEM_SIZE * 0.75 * cdPct)

        local numTooltipLines = itemmanager.getItemTooltipNumLines(itemId)
        BlzFrameSetSize(
            actionItem.tooltipFrame.origin,
            0.16,
            0.012 * numTooltipLines)
        BlzFrameSetSize(
            actionItem.tooltipFrame.text,
            0.15,
            0.012 * numTooltipLines - 0.01)

        BlzFrameSetText(
            actionItem.tooltipFrame.text,
            itemmanager.getItemTooltip(itemId) or "")

        BlzFrameSetText(actionItem.itemCountFrame, itemCount)

        BlzFrameSetVisible(
            actionItem.tooltipFrame.backdrop, numTooltipLines ~= 0)
    end
end

return ItemBar
