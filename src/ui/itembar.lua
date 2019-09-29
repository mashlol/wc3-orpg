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
        actionBar, consts.ITEM_ITEM_SIZE * 4, consts.ITEM_ITEM_SIZE)
    BlzFrameSetAbsPoint(
        actionBar, FRAMEPOINT_BOTTOMLEFT, 0.16, consts.ACTION_ITEM_SIZE + 0.02)

    local actionItems = {}
    for i=0,5,1 do
        local actionItem = BlzCreateFrameByType(
            "BACKDROP",
            "actionItem",
            BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),
            "",
            0)
        BlzFrameSetSize(
            actionItem, consts.ITEM_ITEM_SIZE, consts.ITEM_ITEM_SIZE)
        BlzFrameSetPoint(
            actionItem,
            FRAMEPOINT_LEFT,
            actionBar,
            FRAMEPOINT_LEFT,
            i * (consts.ITEM_ITEM_SIZE + 0.0015),
            0)
        BlzFrameSetTexture(
            actionItem,
            "UI/Widgets/Console/Human/human-inventory-slotfiller.blp",
            0,
            true)

        local actionCooldownBackdrop = BlzCreateFrameByType(
            "BACKDROP",
            "actionCooldownBackdrop",
            actionItem,
            "",
            0)
        BlzFrameSetSize(
            actionCooldownBackdrop,
            consts.ITEM_ITEM_SIZE,
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

        local itemCountFrame = BlzCreateFrameByType(
            "TEXT",
            "itemCountFrame",
            actionItem,
            "",
            0)
        BlzFrameSetSize(itemCountFrame, consts.ITEM_ITEM_SIZE, 0.012)
        BlzFrameSetPoint(
            itemCountFrame,
            FRAMEPOINT_BOTTOMRIGHT,
            actionItem,
            FRAMEPOINT_BOTTOMRIGHT,
            0,
            0)
        BlzFrameSetTextAlignment(
            itemCountFrame, TEXT_JUSTIFY_BOTTOM, TEXT_JUSTIFY_RIGHT)

        local actionCooldownText = BlzCreateFrameByType(
            "TEXT",
            "actionCooldownText",
            actionItem,
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
            actionItem,
            FRAMEPOINT_CENTER,
            0,
            0)
        BlzFrameSetTextAlignment(
            actionCooldownText, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)

        local hoverFrame = BlzCreateFrameByType(
            "GLUEBUTTON",
            "hoverFrame",
            actionItem,
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
            actionItem, 0.16, 0.24, hoverFrame)

        table.insert(actionItems, {
            actionItemBackground = actionItem,
            actionCooldownBackdrop = actionCooldownBackdrop,
            actionCooldownText = actionCooldownText,
            tooltipFrame = tooltipFrame,
            itemCountFrame = itemCountFrame,
        })
    end

    self.frames = {
        actionItems = actionItems,
    }

    return self
end

function ItemBar:update(playerId)
    local frame = self.frames

    for idx,actionItem in pairs(frame.actionItems) do
        local itemId = playerHotbars[playerId][idx]

        local itemInfo = itemmanager.getItemInfo(itemId)
        local itemIcon = "UI/Widgets/Console/Human/human-inventory-slotfiller.blp"
        local cdPct = 0.000001
        local itemCount = ""
        if itemInfo ~= nil then
            itemIcon = itemInfo.icon
            if itemInfo.spell ~= nil then
                cdPct = spell.getCooldownPctBySpellKey(
                    playerId, itemInfo.spell)
            end
            itemCount = backpack.getItemCount(playerId, itemId)
        end

        BlzFrameSetSize(
            actionItem.actionCooldownBackdrop,
            consts.ITEM_ITEM_SIZE,
            consts.ITEM_ITEM_SIZE * cdPct)

        BlzFrameSetTexture(
            actionItem.actionItemBackground,
            itemIcon,
            0,
            true)

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
