local log = require('src/log.lua')
local consts = require('src/ui/consts.lua')
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

    local backpackBackground = BlzCreateFrameByType(
        "BACKDROP",
        "backpackBackground",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        backpackBackground, consts.BACKPACK_SIZE, consts.BACKPACK_SIZE)
    BlzFrameSetAbsPoint(
        backpackBackground,
        FRAMEPOINT_CENTER,
        0.6,
        0.24)
    BlzFrameSetTexture(
        backpackBackground,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)

    local itemFrames = {}

    for i=0,35,1 do
        local itemOrigin = BlzCreateFrameByType(
            "GLUETEXTBUTTON",
            "itemOrigin",
            backpackBackground,
            "",
            0)
        BlzFrameSetSize(
            itemOrigin, consts.BACKPACK_ITEM_SIZE, consts.BACKPACK_ITEM_SIZE)
        BlzFrameSetPoint(
            itemOrigin,
            FRAMEPOINT_TOPLEFT,
            backpackBackground,
            FRAMEPOINT_TOPLEFT,
            (i % 6) * (consts.BACKPACK_ITEM_SIZE + 0.001),
            -math.floor(i / 6) * (consts.BACKPACK_ITEM_SIZE + 0.001))

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
        })
    end

    self.frames = {
        itemFrames = itemFrames,
        origin = backpackBackground,
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
                "IconBorder.tga",
                0,
                true)
        end

        BlzFrameSetVisible(itemFrame.itemHighlight, activeItem == i)
    end
end

return Backpack
