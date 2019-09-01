local log = require('src/log.lua')
local consts = require('src/ui/consts.lua')
local tooltip = require('src/ui/tooltip.lua')
local utils = require('src/ui/utils.lua')
local backpack = require('src/items/backpack.lua')
local equipment = require('src/items/equipment.lua')
local itemmanager = require('src/items/itemmanager.lua')

-- backpackToggles = {
--     [playerId] = true or nil
-- }
local backpackToggles = {}

local Backpack = {
    toggle = function(playerId)
        backpackToggles[playerId] = not backpackToggles[playerId]
    end
}

function Backpack:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Backpack:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local backpackOrigin = BlzCreateFrameByType(
        "FRAME",
        "backpackOrigin",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        backpackOrigin, consts.BACKPACK_SIZE, consts.BACKPACK_SIZE + 0.02)
    BlzFrameSetAbsPoint(
        backpackOrigin,
        FRAMEPOINT_CENTER,
        0.6,
        0.24)

    utils.createBorderFrame(backpackOrigin)

    local backpackText = BlzCreateFrameByType(
        "TEXT",
        "backpackText",
        backpackOrigin,
        "",
        0)
    BlzFrameSetSize(
        backpackText, consts.BACKPACK_SIZE, 0.012)
    BlzFrameSetPoint(
        backpackText,
        FRAMEPOINT_TOPLEFT,
        backpackOrigin,
        FRAMEPOINT_TOPLEFT,
        0.01,
        -0.01)
    BlzFrameSetText(backpackText, "Inventory: 0/36")

    local goldText = BlzCreateFrameByType(
        "TEXT",
        "goldText",
        backpackOrigin,
        "",
        0)
    BlzFrameSetSize(
        goldText, consts.BACKPACK_SIZE, 0.012)
    BlzFrameSetPoint(
        goldText,
        FRAMEPOINT_BOTTOMLEFT,
        backpackOrigin,
        FRAMEPOINT_BOTTOMLEFT,
        0.01,
        0.01)
    BlzFrameSetText(goldText, "Gold: 0")

    local itemFrames = {}

    for i=0,35,1 do
        local itemOrigin = BlzCreateFrameByType(
            "GLUETEXTBUTTON",
            "itemOrigin",
            backpackOrigin,
            "",
            0)
        BlzFrameSetSize(
            itemOrigin, consts.BACKPACK_ITEM_SIZE, consts.BACKPACK_ITEM_SIZE)
        BlzFrameSetPoint(
            itemOrigin,
            FRAMEPOINT_TOPLEFT,
            backpackOrigin,
            FRAMEPOINT_TOPLEFT,
            (i % 6) * (consts.BACKPACK_ITEM_SIZE + 0.004) + 0.02,
            -math.floor(i / 6) * (consts.BACKPACK_ITEM_SIZE + 0.004) - 0.03)

        local itemFrame = BlzCreateFrameByType(
            "BACKDROP",
            "itemFrame",
            itemOrigin,
            "",
            0)
        BlzFrameSetAllPoints(itemFrame, itemOrigin)

        local itemHighlight = BlzCreateFrameByType(
            "BACKDROP",
            "itemHighlight",
            itemOrigin,
            "",
            0)
        BlzFrameSetAllPoints(itemHighlight, itemOrigin)
        BlzFrameSetTexture(
            itemHighlight,
            "Replaceabletextures\\Teamcolor\\Teamcolor21.blp",
            0,
            true)
        BlzFrameSetAlpha(itemHighlight, 100)

        local tooltipFrame = tooltip.makeTooltipFrame(
            itemOrigin, 0.16, 0.24, itemOrigin, false)

        local trig = CreateTrigger()
        BlzTriggerRegisterFrameEvent(
            trig, itemOrigin, FRAMEEVENT_CONTROL_CLICK)
        TriggerAddAction(trig, function()
            local playerId = GetPlayerId(GetTriggerPlayer())
            local activeBagItem = backpack.getActiveItem(playerId)
            local activeEquipmentItem = equipment.getActiveItem(playerId)
            if activeEquipmentItem ~= nil then
                if backpack.getItemIdAtPosition(i+1) ~= nil then
                    log.log(
                        playerId,
                        "You already have an item in that bag position.",
                        log.TYPE.ERROR)
                else
                    local activeItemId = equipment.getItemInSlot(
                        playerId, activeEquipmentItem)
                    equipment.unequipItem(playerId, activeEquipmentItem)
                    backpack.addItemIdToBackpackPosition(playerId, i+1, activeItemId)
                end
                backpack.activateItem(playerId, nil)
                equipment.activateItem(playerId, nil)
            elseif activeBagItem ~= nil then
                backpack.swapPositions(playerId, activeBagItem, i+1)
                backpack.activateItem(playerId, nil)
                equipment.activateItem(playerId, nil)
            else
                backpack.activateItem(playerId, i+1)
            end

            BlzFrameSetEnable(BlzGetTriggerFrame(), false)
            BlzFrameSetEnable(BlzGetTriggerFrame(), true)
        end)

        table.insert(itemFrames, {
            itemFrame = itemFrame,
            itemHighlight = itemHighlight,
            tooltipFrame = tooltipFrame,
        })
    end

    self.frames = {
        itemFrames = itemFrames,
        origin = backpackOrigin,
    }

    return self
end

function Backpack:update(playerId)
    local frames = self.frames

    BlzFrameSetVisible(frames.origin, backpackToggles[playerId] == true)

    local activeItem = backpack.getActiveItem(playerId)
    for i=1,36,1 do
        local itemFrame = frames.itemFrames[i]
        local itemId = backpack.getItemIdAtPosition(playerId, i)
        if itemId ~= nil then
            BlzFrameSetTexture(
                itemFrame.itemFrame,
                itemmanager.getItemInfo(itemId).icon,
                0,
                true)
        else
            BlzFrameSetTexture(
                itemFrame.itemFrame,
                "InvTile.blp",
                0,
                true)
        end

        local numTooltipLines = itemmanager.getItemTooltipNumLines(itemId)
        BlzFrameSetSize(
            itemFrame.tooltipFrame.origin,
            0.16,
            0.012 * numTooltipLines)
        BlzFrameSetSize(
            itemFrame.tooltipFrame.text,
            0.15,
            0.012 * numTooltipLines - 0.01)

        BlzFrameSetText(
            itemFrame.tooltipFrame.text,
            itemmanager.getItemTooltip(itemId) or "")

        BlzFrameSetVisible(itemFrame.tooltipFrame.backdrop, numTooltipLines ~= 0)

        BlzFrameSetVisible(itemFrame.itemHighlight, activeItem == i)
    end
end

return Backpack
