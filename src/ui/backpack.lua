local log = require('src/log.lua')
local effect = require('src/effect.lua')
local hero = require('src/hero.lua')
local consts = require('src/ui/consts.lua')
local tooltip = require('src/ui/tooltip.lua')
local utils = require('src/ui/utils.lua')
local Vendor = require('src/ui/vendor.lua')
local spell = require('src/spell.lua')
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
        0.565,
        0.32)

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

        local itemCountFrame = BlzCreateFrameByType(
            "TEXT",
            "itemCountFrame",
            itemOrigin,
            "",
            0)
        BlzFrameSetSize(itemCountFrame, consts.BACKPACK_ITEM_SIZE, 0.012)
        BlzFrameSetPoint(
            itemCountFrame,
            FRAMEPOINT_BOTTOMRIGHT,
            itemFrame,
            FRAMEPOINT_BOTTOMRIGHT,
            0,
            0)
        BlzFrameSetTextAlignment(
            itemCountFrame, TEXT_JUSTIFY_BOTTOM, TEXT_JUSTIFY_RIGHT)

        local itemCooldownTint = BlzCreateFrameByType(
            "BACKDROP",
            "itemCooldownTint",
            itemOrigin,
            "",
            0)
        BlzFrameSetSize(
            itemCooldownTint,
            consts.BACKPACK_ITEM_SIZE,
            consts.BACKPACK_ITEM_SIZE)
        BlzFrameSetPoint(
            itemCooldownTint,
            FRAMEPOINT_BOTTOM,
            itemFrame,
            FRAMEPOINT_BOTTOM,
            0,
            0)
        BlzFrameSetTexture(
            itemCooldownTint,
            "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
            0,
            true)
        BlzFrameSetAlpha(itemCooldownTint, 200)

        local hoverFrame = BlzCreateFrameByType(
            "GLUEBUTTON",
            "hoverFrame",
            itemOrigin,
            "IconButtonTemplate",
            0)

        local tooltipFrame = tooltip.makeTooltipFrame(
            itemOrigin, 0.16, 0.24, hoverFrame, false)

        local trig = CreateTrigger()
        BlzTriggerRegisterFrameEvent(
            trig, hoverFrame, FRAMEEVENT_CONTROL_CLICK)
        TriggerAddAction(trig, function()
            local playerId = GetPlayerId(GetTriggerPlayer())

            local activeBagItem = backpack.getActiveItem(playerId)
            local activeEquipmentItem = equipment.getActiveItem(playerId)
            if activeEquipmentItem ~= nil then
                if backpack.getItemIdAtPosition(playerId, i+1) ~= nil then
                    log.log(
                        playerId,
                        "You already have an item in that bag position.",
                        log.TYPE.ERROR)
                else
                    local activeItemId = equipment.getItemInSlot(
                        playerId, activeEquipmentItem)
                    equipment.unequipItem(playerId, activeEquipmentItem)
                    backpack.addItemIdToBackpackPosition(
                        playerId, i + 1, activeItemId)
                end
                backpack.activateItem(playerId, nil)
                equipment.activateItem(playerId, nil)
            elseif activeBagItem ~= nil then
                if activeBagItem == i + 1 then

                    local clickedItemPos = i + 1
                    local itemId = backpack.getItemIdAtPosition(
                        playerId, clickedItemPos)
                    if itemId ~= nil then
                        local isInVendor = Vendor.isVendorActive(playerId)

                        local itemInfo = itemmanager.getItemInfo(itemId)
                        local spellKey = itemInfo.spell
                        local itemSlot = itemInfo.slot
                        if isInVendor then
                            -- Sell 1 of the item
                            backpack.removeItemFromBackpack(
                                playerId, clickedItemPos, 1)
                            local curGold = GetPlayerState(
                                Player(playerId),
                                PLAYER_STATE_RESOURCE_GOLD)
                            SetPlayerState(
                                Player(playerId),
                                PLAYER_STATE_RESOURCE_GOLD,
                                curGold + itemInfo.cost * 0.2)
                            effect.createEffect{
                                model = "Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl",
                                x = GetUnitX(hero.getHero(playerId)),
                                y = GetUnitY(hero.getHero(playerId)),
                                duration = 0.5,
                            }
                        elseif spellKey ~= nil then
                            -- Consume the item
                            local success = spell.castSpellByKey(
                                playerId, spellKey)
                            if success then
                                backpack.removeItemFromBackpack(
                                    playerId, clickedItemPos, 1)
                            end
                        elseif itemSlot ~= nil then
                            -- Equip the item to a slot
                            local existingEquip = equipment.getItemInSlot(
                                playerId, itemSlot)
                            local canEquip = equipment.equipItem(
                                playerId, itemSlot, itemId)
                            if canEquip then
                                backpack.removeItemFromBackpack(
                                    playerId, clickedItemPos, 1)
                                if existingEquip ~= nil then
                                    backpack.addItemIdToBackpackPosition(
                                        playerId, i + 1, existingEquip)
                                end
                            end
                        end
                    end
                else
                    backpack.swapPositions(playerId, activeBagItem, i+1)
                end
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
            itemCountFrame = itemCountFrame,
            itemHighlight = itemHighlight,
            tooltipFrame = tooltipFrame,
            itemCooldownTint = itemCooldownTint,
        })
    end

    self.frames = {
        itemFrames = itemFrames,
        origin = backpackOrigin,
        goldText = goldText,
        backpackText = backpackText,
    }

    return self
end

function Backpack:update(playerId)
    local frames = self.frames

    BlzFrameSetVisible(frames.origin, backpackToggles[playerId] == true)

    if backpackToggles[playerId] ~= true then
        return
    end

    BlzFrameSetText(
        frames.goldText,
        "Gold: ".. GetPlayerState(Player(playerId), PLAYER_STATE_RESOURCE_GOLD))

    BlzFrameSetText(
        frames.backpackText,
        'Inventory: ' .. backpack.getFilledSlotCount(playerId) .. ' / 36')

    local activeItem = backpack.getActiveItem(playerId)
    for i=1,36,1 do
        local itemFrame = frames.itemFrames[i]
        local itemId = backpack.getItemIdAtPosition(playerId, i)
        local itemCount = backpack.getItemCountAtPosition(playerId, i)
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

        if itemCount ~= 1 and itemCount ~= nil then
            BlzFrameSetText(itemFrame.itemCountFrame, itemCount)
        else
            BlzFrameSetText(itemFrame.itemCountFrame, "")
        end

        if itemId ~= nil then
            local itemInfo = itemmanager.getItemInfo(itemId)
            if itemInfo.spell ~= nil then
                local cdPct = spell.getCooldownPctBySpellKey(
                    playerId, itemInfo.spell)
                if cdPct == 0 then
                    cdPct = 0.00001
                end
                BlzFrameSetSize(
                    itemFrame.itemCooldownTint,
                    consts.BACKPACK_ITEM_SIZE,
                    consts.BACKPACK_ITEM_SIZE * cdPct)
            else
                BlzFrameSetSize(
                    itemFrame.itemCooldownTint,
                    consts.BACKPACK_ITEM_SIZE,
                    0.00001)
            end

            local numTooltipLines = itemmanager.getItemTooltipNumLines(itemId)
            local tooltip = itemmanager.getItemTooltip(itemId)

            if Vendor.isVendorActive(playerId) then
                numTooltipLines = numTooltipLines + 2
                tooltip = tooltip ..
                    "|n|n(Double click to sell for "..
                    R2I(itemInfo.cost * 0.2) ..
                    " g)"
            elseif itemInfo.spell then
                numTooltipLines = numTooltipLines + 2
                tooltip = tooltip .. "|n|n(Double click to use)"
            end

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
                tooltip)

            BlzFrameSetVisible(itemFrame.tooltipFrame.backdrop, true)
            BlzFrameSetVisible(itemFrame.tooltipFrame.text, true)
        else
            BlzFrameSetSize(
                itemFrame.itemCooldownTint,
                consts.BACKPACK_ITEM_SIZE,
                0.00001)
                BlzFrameSetVisible(itemFrame.tooltipFrame.backdrop, false)
                BlzFrameSetVisible(itemFrame.tooltipFrame.text, false)
        end

        BlzFrameSetVisible(itemFrame.itemHighlight, activeItem == i)
    end
end

return Backpack
