local log = require('src/log.lua')
local consts = require('src/ui/consts.lua')
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
        "GLUETEXTBUTTON",
        "itemOrigin",
        originFrame,
        "",
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
        itemOrigin, 0.16, 0.24, itemOrigin, yPos >= -0.12)

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        trig, itemOrigin, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        local playerId = GetPlayerId(GetTriggerPlayer())
        local activeItem = backpack.getActiveItem(playerId)
        if activeItem ~= nil then
            local activeItemId = backpack.getItemIdAtPosition(playerId, activeItem)
            if equipment.getItemInSlot(slot) ~= nil then
                log.log(playerId, "You already have an item in that slot.", log.TYPE.ERROR)
            elseif itemmanager.getItemInfo(activeItemId).slot ~= slot then
                log.log(playerId, "That doesn't go in that slot.", log.TYPE.ERROR)
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

    local equipmentBackground = BlzCreateFrameByType(
        "FRAME",
        "equipmentBackground",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        equipmentBackground, consts.EQUIPMENT_ITEM_SIZE * 5, consts.EQUIPMENT_ITEM_SIZE * 9)
    BlzFrameSetAbsPoint(
        equipmentBackground,
        FRAMEPOINT_CENTER,
        0.1,
        0.35)

    local equipmentBackdrop = BlzCreateFrameByType(
        "BACKDROP",
        "equipmentBackdrop",
        equipmentBackground,
        "",
        0)
    BlzFrameSetTexture(
        equipmentBackdrop,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)
    BlzFrameSetAlpha(equipmentBackdrop, 200)
    BlzFrameSetAllPoints(equipmentBackdrop, equipmentBackground)

    local itemFrames = {}

    for i=0,7,1 do
        local itemFrame = createItemFrame(
            equipmentBackground,
            math.floor(i / 4) * (consts.EQUIPMENT_ITEM_SIZE + consts.EQUIPMENT_ITEM_SIZE * 3),
            -(i % 4) * (consts.EQUIPMENT_ITEM_SIZE + consts.EQUIPMENT_ITEM_SIZE),
            i+1)

        table.insert(itemFrames, itemFrame)
    end

    local itemFrame = createItemFrame(
        equipmentBackground,
        0.06,
        consts.EQUIPMENT_ITEM_SIZE * -8,
        9)

    table.insert(itemFrames, itemFrame)

    self.frames = {
        itemFrames = itemFrames,
        origin = equipmentBackground,
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
                "IconBorder.tga",
                0,
                true)
        end

        BlzFrameSetText(
            itemFrame.tooltipFrame.text,
            itemmanager.getItemTooltip(itemId) or "")

        BlzFrameSetVisible(itemFrame.itemHighlight, activeItem == i)
    end
end

return Equipment
