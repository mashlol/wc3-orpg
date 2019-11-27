local log = require('src/log.lua')
local hero = require('src/hero.lua')
local consts = require('src/ui/consts.lua')
local utils = require('src/ui/utils.lua')
local tooltip = require('src/ui/tooltip.lua')
local backpack = require('src/items/backpack.lua')
local equipment = require('src/items/equipment.lua')
local itemmanager = require('src/items/itemmanager.lua')
local Stats = require('src/ui/stats.lua')

-- equipmentToggles = {
--     [playerId] = [otherPlayerId] or nil
-- }
local equipmentToggles = {}

local Equipment = {
    toggle = function(playerId)
        equipment.activateItem(playerId, nil)
        if equipmentToggles[playerId] ~= nil then
            equipmentToggles[playerId] = nil
        else
            equipmentToggles[playerId] = playerId
        end
    end,
    show = function(playerId, forPlayerId)
        equipmentToggles[playerId] = forPlayerId
    end,
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
        itemOrigin, consts.EQUIPMENT_ITEM_SIZE * 0.75, consts.EQUIPMENT_ITEM_SIZE * 0.75)
    BlzFrameSetPoint(
        itemOrigin,
        FRAMEPOINT_TOPLEFT,
        originFrame,
        FRAMEPOINT_TOPLEFT,
        xPos,
        yPos)

    local background = BlzCreateFrameByType(
        "BACKDROP",
        "itemFrame",
        itemOrigin,
        "",
        0)
    BlzFrameSetSize(
        background, consts.EQUIPMENT_ITEM_SIZE, consts.EQUIPMENT_ITEM_SIZE)
    BlzFrameSetPoint(
        background,
        FRAMEPOINT_CENTER,
        itemOrigin,
        FRAMEPOINT_CENTER,
        0,
        0)
    BlzFrameSetTexture(
        background, "war3mapImported\\ui\\ab_spell_frame_clean.blp", 0, true)

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
        itemOrigin, 0.16, 0.24, itemOrigin, yPos >= -0.12, xPos <= 0.06)

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        trig, itemOrigin, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        local playerId = GetPlayerId(GetTriggerPlayer())

        if equipmentToggles[playerId] ~= playerId then
            -- Don't let them edit someone elses equipment, they're inspecting
            -- someone
            return
        end

        local activeItem = backpack.getActiveItem(playerId)
        if activeItem ~= nil then
            local activeItemId = backpack.getItemIdAtPosition(
                playerId, activeItem)
            if equipment.getItemInSlot(playerId, slot) ~= nil then
                log.log(
                    playerId,
                    "You already have an item in that slot.",
                    log.TYPE.EQUIPMENT_ERROR)
            elseif itemmanager.getItemInfo(activeItemId).slot ~= slot then
                log.log(
                    playerId,
                    "That doesn't go in that slot.",
                    log.TYPE.EQUIPMENT_ERROR)
            else
                local canEquip = equipment.equipItem(
                    playerId, slot, activeItemId)
                if canEquip then
                    backpack.removeItemFromBackpack(playerId, activeItem)
                end
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
        consts.EQUIPMENT_ITEM_SIZE * 9 + 0.015,
        consts.EQUIPMENT_ITEM_SIZE * 9 + 0.02)
    BlzFrameSetAbsPoint(
        equipmentOrigin,
        FRAMEPOINT_CENTER,
        0.1,
        0.35)

    local borderInfo = utils.createBorderFrame(
        equipmentOrigin, "CHARACTER (Lv. 2)")

    -- local BUTTON_WIDTH_PX = 300 => 0.105
    -- local BUTTON_HEIGHT_PX = 450 => 0.1575

    local portraitBackdropFrame = BlzCreateFrameByType(
        "BACKDROP",
        "portraitBackdropFrame",
        equipmentOrigin,
        "",
        0)
    BlzFrameSetSize(
        portraitBackdropFrame,
        consts.EQUIPMENT_ITEM_SIZE * 7 * 300 / 450,
        consts.EQUIPMENT_ITEM_SIZE * 7)
    BlzFrameSetPoint(
        portraitBackdropFrame,
        FRAMEPOINT_TOP,
        equipmentOrigin,
        FRAMEPOINT_TOP,
        -0.0025,
        -0.025)
    BlzFrameSetTexture(
        portraitBackdropFrame,
        "war3mapImported\\stormfist_crop.blp",
        0,
        true)

    local itemFrames = {}

    for i=0,9,1 do
        local itemFrame = createItemFrame(
            equipmentOrigin,
            math.floor(i / 5) *
                (consts.EQUIPMENT_ITEM_SIZE * 6.2) +
                0.015,
            -(i % 5) *
                (consts.EQUIPMENT_ITEM_SIZE + consts.EQUIPMENT_ITEM_SIZE / 2) -
                0.03,
            i+1)

        table.insert(itemFrames, itemFrame)
    end

    local weapon = createItemFrame(
        equipmentOrigin,
        0.06,
        consts.EQUIPMENT_ITEM_SIZE * -8 - 0.005,
        11)
    table.insert(itemFrames, weapon)
    local offHand = createItemFrame(
        equipmentOrigin,
        0.15,
        consts.EQUIPMENT_ITEM_SIZE * -8 - 0.005,
        12)
    table.insert(itemFrames, offHand)

    utils.createCloseButton(equipmentOrigin, function(playerId)
        equipmentToggles[playerId] = nil
        Stats.hide(playerId)
    end)

    self.frames = {
        itemFrames = itemFrames,
        origin = equipmentOrigin,
        equipmentText = borderInfo.text,
        portrait = portraitBackdropFrame,
    }

    return self
end

function Equipment:update(playerId)
    local frames = self.frames

    local isVisible = equipmentToggles[playerId] ~= nil and self.hero ~= nil
    BlzFrameSetVisible(frames.origin, isVisible)

    if not isVisible then
        return
    end

    playerId = equipmentToggles[playerId]

    local level = GetHeroLevel(self.hero)
    BlzFrameSetText(frames.equipmentText, "CHARACTER (LV. " .. level .. ")")

    local pickedHero = hero.getPickedHero(playerId)
    if pickedHero ~= nil then
        BlzFrameSetTexture(frames.portrait, pickedHero.portrait, 0, true)
    end

    local activeItem = equipment.getActiveItem(playerId)
    for i=1,12,1 do
        local itemFrame = frames.itemFrames[i]
        local itemId = equipment.getItemInSlot(playerId, i)
        if itemId ~= nil then
            BlzFrameSetTexture(
                itemFrame.itemFrame,
                itemmanager.getItemInfo(itemId).icon,
                0,
                true)
            BlzFrameSetVisible(itemFrame.itemFrame, true)
        else
            BlzFrameSetVisible(itemFrame.itemFrame, false)
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
