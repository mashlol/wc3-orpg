local hero = require('src/hero.lua')
local equipment = require('src/items/equipment.lua')

local RARITY = {
    COMMON = {
        color = "|cffffffff",
        text = "Common",
    },
    UNCOMMON = {
        color = "|cff2cfc03",
        text = "Uncommon",
    },
    RARE = {
        color = "|cff036ffc",
        text = "Rare",
    },
    LEGENDARY = {
        color = "|cffc4ab1a",
        text = "Legendary",
    },
}

local ITEMS = {
    [1] = {
        name = 'Old boot',
        icon = "ReplaceableTextures\\CommandButtons\\BTNBoots.blp",
        itemLevel = 1,
        requiredLevel = 1,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = 'rawHp',
                amount = 10,
            },
        },
        slot = equipment.SLOT.FEET,
    },
    [2] = {
        name = 'Rusty Ring',
        icon = "ReplaceableTextures\\CommandButtons\\BTNGoldRing.blp",
        itemLevel = 5,
        requiredLevel = 5,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = 'rawHp',
                amount = 10,
            },
            {
                type = 'multiplyDamage',
                amount = 1.01,
            },
        },
        slot = equipment.SLOT.RING,
    },
    [3] = {
        name = 'Iron Helmet',
        icon = "ReplaceableTextures\\CommandButtons\\BTNHelmutPurple.blp",
        itemLevel = 3,
        requiredLevel = 3,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = 'rawHp',
                amount = 40,
            },
        },
        slot = equipment.SLOT.HELMET,
    },
    [4] = {
        name = 'Copper Dagger',
        icon = "ReplaceableTextures\\CommandButtons\\BTNDaggerOfEscape.blp",
        itemLevel = 20,
        requiredLevel = 10,
        rarity = RARITY.RARE,
        stats = {
            {
                type = 'multiplyDamage',
                amount = 1.1,
            },
        },
        slot = equipment.SLOT.WEAPON,
    },
}

-- Precompute tooltips at initialization time or you get desyncs
local TOOLTIPS = {}

function getItemInfo(itemId)
    return ITEMS[itemId]
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
    for itemId, itemInfo in pairs(ITEMS) do
        local itemStats = ""

        local numLines = 0
        for _, statInfo in pairs(itemInfo.stats) do
            if statInfo.type == 'rawHp' then
                itemStats = itemStats .. '+' .. statInfo.amount .. ' HP|n'
                numLines = numLines + 1
            end
            if statInfo.type == 'multiplyDamage' then
                itemStats = itemStats .. '+' .. round((statInfo.amount - 1) * 100, 2) .. ' % damage|n'
                numLines = numLines + 1
            end
        end

        local type = ""
        if itemInfo.slot == equipment.SLOT.HELMET then
            type = "Head"
        elseif itemInfo.slot == equipment.SLOT.NECK then
            type = "Neck"
        elseif itemInfo.slot == equipment.SLOT.CHEST then
            type = "Chest"
        elseif itemInfo.slot == equipment.SLOT.BACK then
            type = "Back"
        elseif itemInfo.slot == equipment.SLOT.HANDS then
            type = "Hands"
        elseif itemInfo.slot == equipment.SLOT.LEGS then
            type = "Legs"
        elseif itemInfo.slot == equipment.SLOT.FEET then
            type = "Feet"
        elseif itemInfo.slot == equipment.SLOT.RING then
            type = "Ring"
        elseif itemInfo.slot == equipment.SLOT.WEAPON then
            type = "Weapon"
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
                "|n|n|cff00ff00" ..
                itemStats,
            numLines = numLines + 5,
        }
    end
end

return {
    ITEMS = ITEMS,
    init = init,
    getItemInfo = getItemInfo,
    getItemTooltip = getItemTooltip,
    getItemTooltipNumLines = getItemTooltipNumLines,
}
