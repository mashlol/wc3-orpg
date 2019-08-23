local consts = require('src/ui/consts.lua')
local backpack = require('src/items/backpack.lua')
local itemmanager = require('src/items/itemmanager.lua')

local Backpack = {}

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
        0.2)
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
            (i % 6) * consts.BACKPACK_ITEM_SIZE,
            -math.floor(i / 6) * consts.BACKPACK_ITEM_SIZE)

        local itemFrame = BlzCreateFrameByType(
            "BACKDROP",
            "itemFrame",
            itemOrigin,
            "",
            0)
        BlzFrameSetAllPoints(itemFrame, itemOrigin)

        local trig = CreateTrigger()
        BlzTriggerRegisterFrameEvent(
            trig, itemOrigin, FRAMEEVENT_CONTROL_CLICK)
        TriggerAddAction(trig, function()
            local playerId = GetPlayerId(GetTriggerPlayer())
            local activeItem = backpack.getActiveItem(playerId)
            if activeItem ~= nil then
                backpack.swapPositions(playerId, activeItem, i+1)
                backpack.activateItem(playerId, nil)
            else
                backpack.activateItem(playerId, i+1)
            end

            BlzFrameSetEnable(BlzGetTriggerFrame(), false)
            BlzFrameSetEnable(BlzGetTriggerFrame(), true)
        end)

        table.insert(itemFrames, itemFrame)
    end

    self.frames = {
        itemFrames = itemFrames,
        origin = backpackBackground,
    }

    return self
end

function Backpack:update(playerId)
    local frames = self.frames

    for i=1,36,1 do
        local itemFrame = frames.itemFrames[i]
        local itemId = backpack.getItemIdAtPosition(playerId, i)
        if itemId ~= nil then
            BlzFrameSetTexture(
                itemFrame,
                itemmanager.getItemInfo(itemId).icon,
                0,
                true)
        else
            BlzFrameSetTexture(
                itemFrame,
                "IconBorder.tga",
                0,
                true)
        end
    end
end

return Backpack
