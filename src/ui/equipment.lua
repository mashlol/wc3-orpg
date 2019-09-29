local log = require('src/log.lua')
local consts = require('src/ui/consts.lua')
local utils = require('src/ui/utils.lua')
local tooltip = require('src/ui/tooltip.lua')
local backpack = require('src/items/backpack.lua')
local equipment = require('src/items/equipment.lua')
local itemmanager = require('src/items/itemmanager.lua')

-- equipmentToggles = {
--     [playerId] = true or nil
-- }
local equipmentToggles = {}

local Equipment = {
    toggle = function(playerId)
        equipmentToggles[playerId] = not equipmentToggles[playerId]
    end
}

function Equipment:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

local createItemFrame = function(originFrame, xPos, yPos, slot)
    local itemOrigin = BlzCreateFrameByType(
        "GLUEBUTTON",
        "itemOrigin",
        originFrame,
        "IconButtonTemplate",
        0)
    BlzFrameSetSize(
        itemOrigin, consts.EQUIPMENT_ITEM_SIZE, consts.EQUIPMENT_ITEM_SIZE)
    BlzFrameSetPoint(
        itemOrigin,
        FRAMEPOINT_TOPLEFT,
        originFrame,
        FRAMEPOINT_TOPLEFT,
        xPos,
        yPos)

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
        itemOrigin, 0.16, 0.24, itemOrigin, yPos >= -0.12, xPos <= 0.015)

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        trig, itemOrigin, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        local playerId = GetPlayerId(GetTriggerPlayer())
        local activeItem = backpack.getActiveItem(playerId)
        if activeItem ~= nil then
            local activeItemId = backpack.getItemIdAtPosition(
                playerId, activeItem)
            if equipment.getItemInSlot(playerId, slot) ~= nil then
                log.log(
                    playerId,
                    "You already have an item in that slot.",
                    log.TYPE.ERROR)
            elseif itemmanager.getItemInfo(activeItemId).slot ~= slot then
                log.log(
                    playerId,
                    "That doesn't go in that slot.",
                    log.TYPE.ERROR)
            else
                backpack.removeItemFromBackpack(playerId, activeItem)
                equipment.equipItem(playerId, slot, activeItemId)
            end

            backpack.activateItem(playerId, nil)
        else
            -- TODO activate equipment item if one exists
            equipment.activateItem(playerId, slot)
            backpack.activateItem(playerId, nil)
        end

        BlzFrameSetEnable(BlzGetTriggerFrame(), false)
        BlzFrameSetEnable(BlzGetTriggerFrame(), true)
    end)

    return {
        itemFrame = itemFrame,
        itemHighlight = itemHighlight,
        tooltipFrame = tooltipFrame,
    }
end

function Equipment:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local equipmentOrigin = BlzCreateFrameByType(
        "FRAME",
        "equipmentOrigin",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        equipmentOrigin,
        consts.EQUIPMENT_ITEM_SIZE * 7 + 0.015,
        consts.EQUIPMENT_ITEM_SIZE * 9 + 0.02)
    BlzFrameSetAbsPoint(
        equipmentOrigin,
        FRAMEPOINT_CENTER,
        0.1,
        0.35)

    utils.createBorderFrame(equipmentOrigin)

    local equipmentText = BlzCreateFrameByType(
        "TEXT",
        "equipmentText",
        equipmentOrigin,
        "",
        0)
    BlzFrameSetSize(equipmentText, consts.EQUIPMENT_ITEM_SIZE * 4 + 0.03, 0.012)
    BlzFrameSetPoint(
        equipmentText,
        FRAMEPOINT_TOPLEFT,
        equipmentOrigin,
        FRAMEPOINT_TOPLEFT,
        0.01,
        -0.01)
    BlzFrameSetText(equipmentText, "Character")

    local portraitBackdropFrame = BlzCreateFrameByType(
        "BACKDROP",
        "portraitBackdropFrame",
        equipmentOrigin,
        "",
        0)
    BlzFrameSetSize(
        portraitBackdropFrame, 0.105, consts.EQUIPMENT_ITEM_SIZE * 7)
    BlzFrameSetPoint(
        portraitBackdropFrame,
        FRAMEPOINT_TOP,
        equipmentOrigin,
        FRAMEPOINT_TOP,
        -0.0025,
        -0.025)
    BlzFrameSetTexture(
        portraitBackdropFrame,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)

    local portraitFrame = BlzGetOriginFrame(ORIGIN_FRAME_PORTRAIT, 0)
    local portraitParent = BlzFrameGetParent(portraitFrame)
    BlzFrameSetVisible(portraitFrame, true)

    if BlzGetLocalClientWidth() / BlzGetLocalClientHeight() > 1.7 then
        BlzFrameClearAllPoints(portraitFrame)
        BlzFrameSetSize(portraitFrame, 0.08, consts.EQUIPMENT_ITEM_SIZE * 7)
        BlzFrameSetPoint(
            portraitFrame,
            FRAMEPOINT_TOP,
            equipmentOrigin,
            FRAMEPOINT_TOP,
            0.072,
            -0.025)
    else
        BlzFrameSetAllPoints(portraitFrame, portraitBackdropFrame)
    end

    BlzFrameSetLevel(portraitParent, 10)
    BlzFrameSetParent(portraitParent, equipmentOrigin)

    local itemFrames = {}

    for i=0,7,1 do
        local itemFrame = createItemFrame(
            equipmentOrigin,
            math.floor(i / 4) *
                (consts.EQUIPMENT_ITEM_SIZE + consts.EQUIPMENT_ITEM_SIZE * 4) +
                0.015,
            -(i % 4) *
                (consts.EQUIPMENT_ITEM_SIZE + consts.EQUIPMENT_ITEM_SIZE) -
                0.025,
            i+1)

        table.insert(itemFrames, itemFrame)
    end

    local itemFrame = createItemFrame(
        equipmentOrigin,
        0.09,
        consts.EQUIPMENT_ITEM_SIZE * -8 - 0.005,
        9)

    table.insert(itemFrames, itemFrame)

    self.frames = {
        itemFrames = itemFrames,
        origin = equipmentOrigin,
    }

    return self
end

function Equipment:update(playerId)
    local frames = self.frames

    BlzFrameSetVisible(frames.origin, equipmentToggles[playerId] == true)

    local activeItem = equipment.getActiveItem(playerId)
    for i=1,9,1 do
        local itemFrame = frames.itemFrames[i]
        local itemId = equipment.getItemInSlot(playerId, i)
        if itemId ~= nil then
            BlzFrameSetTexture(
                itemFrame.itemFrame,
                itemmanager.getItemInfo(itemId).icon,
                0,
                true)
        else
            BlzFrameSetTexture(
                itemFrame.itemFrame,
                "UI/Widgets/Console/Human/human-inventory-slotfiller.blp",
                0,
                true)
        end

        local tooltip = itemId ~= nil and
            itemmanager.getItemTooltip(itemId) or
            equipment.getSlotName(i)
        local numTooltipLines = itemId ~= nil and
            itemmanager.getItemTooltipNumLines(itemId) or
            2
        local width = itemId ~= nil and 0.16 or 0.08
        local height = 0.012 * numTooltipLines
        local align = itemId ~= nil and TEXT_JUSTIFY_LEFT or TEXT_JUSTIFY_CENTER
        BlzFrameSetSize(
            itemFrame.tooltipFrame.origin,
            width,
            height)
        BlzFrameSetSize(
            itemFrame.tooltipFrame.text,
            width - 0.01,
            height - 0.01)
        BlzFrameSetTextAlignment(
            itemFrame.tooltipFrame.text,
            TEXT_JUSTIFY_CENTER,
            align)
        BlzFrameSetVisible(
            itemFrame.tooltipFrame.backdrop,
            numTooltipLines ~= 0)
        BlzFrameSetText(
            itemFrame.tooltipFrame.text,
            tooltip)

        BlzFrameSetVisible(itemFrame.itemHighlight, activeItem == i)
    end
end

return Equipment
