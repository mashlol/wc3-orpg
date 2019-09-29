local consts = require('src/ui/consts.lua')
local utils = require('src/ui/utils.lua')
local tooltip = require('src/ui/tooltip.lua')
local itemmanager = require('src/items/itemmanager.lua')

-- vendorToggles = {
--     [playerId] = {
--         text = "text",
--         items = {
--             [1] = [itemId],
--         },
--     },
-- }
local vendorToggles = {}

local Vendor = {
    show = function(playerId, info)
        vendorToggles[playerId] = info
    end,
    hide = function(playerId)
        vendorToggles[playerId] = nil
    end
}

function Vendor:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Vendor:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local origin = BlzCreateFrameByType(
        "FRAME",
        "origin",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        origin, consts.VENDOR_WIDTH, consts.VENDOR_HEIGHT)
    BlzFrameSetAbsPoint(
        origin,
        FRAMEPOINT_LEFT,
        0,
        0.35)

    utils.createBorderFrame(origin)

    local ITEM_HEIGHT = 0.03

    local items = {}
    for i=0,9,1 do
        local itemContainerFrame = BlzCreateFrameByType(
            "FRAME", "itemContainerFrame", origin, "", 0)
        BlzFrameSetSize(
            itemContainerFrame, (consts.VENDOR_WIDTH - 0.03) / 2, ITEM_HEIGHT)
        BlzFrameSetPoint(
            itemContainerFrame,
            FRAMEPOINT_TOPLEFT,
            origin,
            FRAMEPOINT_TOPLEFT,
            (i % 2)* ((consts.VENDOR_WIDTH - 0.03) / 2 + 0.01) + 0.01,
            -R2I(i / 2) * (ITEM_HEIGHT + 0.01) - 0.05)

        local itemBackdropFrame = BlzCreateFrameByType(
            "BACKDROP", "itemBackdropFrame", itemContainerFrame, "", 0)
        BlzFrameSetAllPoints(itemBackdropFrame, itemContainerFrame)
        BlzFrameSetTexture(
            itemBackdropFrame,
            "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
            0,
            true)
        BlzFrameSetAlpha(itemBackdropFrame, 100)

        local itemIcon = BlzCreateFrameByType(
            "BACKDROP",
            "itemIcon",
            itemContainerFrame,
            "",
            0)
        BlzFrameSetSize(
            itemIcon, ITEM_HEIGHT - 0.005, ITEM_HEIGHT - 0.005)
        BlzFrameSetPoint(
            itemIcon,
            FRAMEPOINT_LEFT,
            itemContainerFrame,
            FRAMEPOINT_LEFT,
            0.0025,
            0)
        BlzFrameSetTexture(
            itemIcon,
            "ReplaceableTextures\\CommandButtons\\BTNBoots.blp",
            0,
            true)

        local itemText = BlzCreateFrameByType(
            "TEXT",
            "itemText",
            itemContainerFrame,
            "",
            0)
        BlzFrameSetSize(
            itemText, (ITEM_HEIGHT - 0.005) * 3, (ITEM_HEIGHT - 0.005) * 2)
        BlzFrameSetScale(itemText, 0.6)
        BlzFrameSetPoint(
            itemText,
            FRAMEPOINT_LEFT,
            itemIcon,
            FRAMEPOINT_LEFT,
            ITEM_HEIGHT + 0.015,
            -0.005)
        BlzFrameSetTextAlignment(itemText, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
        BlzFrameSetText(
            itemText,
            "Some item with a long name")

        local coinBackdrop = BlzCreateFrameByType(
            "BACKDROP", "coinBackdrop", itemContainerFrame, "", 0)
        BlzFrameSetSize(coinBackdrop, 0.01, 0.01)
        BlzFrameSetPoint(
            coinBackdrop,
            FRAMEPOINT_BOTTOMLEFT,
            itemIcon,
            FRAMEPOINT_BOTTOMRIGHT,
            0.0025,
            0)
        BlzFrameSetTexture(
            coinBackdrop, "ui\\feedback\\resources\\resourcegold.blp", 0, false)

        local itemCostText = BlzCreateFrameByType(
            "TEXT",
            "itemCostText",
            itemContainerFrame,
            "",
            0)
        BlzFrameSetSize(
            itemCostText, (ITEM_HEIGHT - 0.005) * 3, (ITEM_HEIGHT - 0.005) * 2)
        BlzFrameSetScale(itemCostText, 0.6)
        BlzFrameSetPoint(
            itemCostText,
            FRAMEPOINT_LEFT,
            itemIcon,
            FRAMEPOINT_LEFT,
            ITEM_HEIGHT + 0.035,
            0.005)
        BlzFrameSetTextAlignment(
            itemCostText, TEXT_JUSTIFY_BOTTOM, TEXT_JUSTIFY_LEFT)
        BlzFrameSetText(
            itemCostText,
            "2734")

        local hoverFrame = BlzCreateFrameByType(
            "GLUEBUTTON",
            "hoverFrame",
            itemContainerFrame,
            "IconButtonTemplate",
            0)

        local tooltipFrame = tooltip.makeTooltipFrame(
            itemContainerFrame, 0.16, 0.24, hoverFrame, true, true)

        table.insert(items, {
            origin = itemContainerFrame,
            itemCostText = itemCostText,
            itemIcon = itemIcon,
            itemText = itemText,
            tooltipFrame = tooltipFrame,
        })
    end

    self.frames = {
        origin = origin,
        items = items,
    }

    return self
end

function Vendor:update(playerId)
    local frames = self.frames

    BlzFrameSetVisible(frames.origin, vendorToggles[playerId] ~= nil)

    if vendorToggles[playerId] == nil then
        return
    end

    for idx, itemFrame in pairs(frames.items) do
        local itemId = vendorToggles[playerId].items[idx]
        if itemId ~= nil then
            BlzFrameSetVisible(itemFrame.origin, true)
            local itemInfo = itemmanager.getItemInfo(itemId)

            if itemInfo ~= nil and itemId ~= nil then
                BlzFrameSetText(itemFrame.itemText, itemInfo.name)
                BlzFrameSetTexture(itemFrame.itemIcon, itemInfo.icon, 0, true)

                local numTooltipLines = itemmanager.getItemTooltipNumLines(
                    itemId)
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

                BlzFrameSetVisible(
                    itemFrame.tooltipFrame.backdrop, numTooltipLines ~= 0)
            end
        else
            BlzFrameSetVisible(itemFrame.origin, false)
        end
    end
end

return Vendor
