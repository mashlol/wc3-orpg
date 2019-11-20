local hero = require('src/hero.lua')
local equipment = require('src/items/equipment.lua')
local items = require('src/items/items.lua')

-- Precompute tooltips at initialization time or you get desyncs
local TOOLTIPS = {}

function getItemInfo(itemId)
    return items.ITEMS[itemId]
end

function getItemNameWithColor(itemId)
    local itemInfo = items.ITEMS[itemId]
    return itemInfo.rarity.color .. itemInfo.name .. "|r"
end

function getItemTooltip(itemId)
    return TOOLTIPS[itemId] and TOOLTIPS[itemId].text or ""
end

function getItemTooltipNumLines(itemId)
    return TOOLTIPS[itemId] and TOOLTIPS[itemId].numLines or 0
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
  end

function init()
    for itemId, itemInfo in pairs(items.ITEMS) do
        local itemStats = ""

        local numLines = 0
        if itemInfo.stats ~= nil then
            itemStats = itemStats .. "|n|n|cff00ff00"
            for _, statInfo in pairs(itemInfo.stats) do
                itemStats = itemStats .. statInfo.type.getTooltip(statInfo) .. "|n"
                numLines = numLines + 1
            end
            itemStats = itemStats .. "|r"
        end

        local type = equipment.getSlotName(itemInfo.slot)

        if itemInfo.type == items.TYPE.CONSUMABLE then
            type = "Consumable"
        end

        local itemText = ""
        if itemInfo.text ~= nil then
            itemText = "|n|n|cff00ff00" .. itemInfo.text .. "|r"

            _, lines = string.gsub(itemInfo.text, "|n", "")
            numLines = numLines + lines + 1
        end

        if itemInfo.usableClasses ~= nil then
            itemText = itemText .. '|n|cff12deb2Usable by: '
            local numUsable = #(itemInfo.usableClasses)
            for idx, classId in pairs(itemInfo.usableClasses) do
                itemText = itemText .. hero.ALL_HERO_INFO[classId].name
                if idx ~= numUsable then
                    itemText = itemText .. ', '
                end
            end
            itemText = itemText .. '|r'
            numLines = numLines + 1
        end

        TOOLTIPS[itemId] = {
            text =
                itemInfo.rarity.color ..
                itemInfo.name ..
                "|r|n" ..
                type..
                "|n"..
                "|cffe3e312Item level " ..
                itemInfo.itemLevel ..
                "|r|n"..
                "Requires level " ..
                itemInfo.requiredLevel ..
                itemStats..
                itemText,
            numLines = numLines + 5,
        }
    end
end

return {
    init = init,
    getItemInfo = getItemInfo,
    getItemTooltip = getItemTooltip,
    getItemTooltipNumLines = getItemTooltipNumLines,
    getItemNameWithColor = getItemNameWithColor,
}
