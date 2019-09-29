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

local TYPE = {
    EQUIPMENT = 'equipment',
    CONSUMABLE = 'consumable',
}

local ITEMS = {
    [1] = {
        type = TYPE.EQUIPMENT,
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
        stackSize = 1,
    },
    [2] = {
        type = TYPE.EQUIPMENT,
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
        stackSize = 1,
    },
    [3] = {
        type = TYPE.EQUIPMENT,
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
        stackSize = 1,
    },
    [4] = {
        type = TYPE.EQUIPMENT,
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
        stackSize = 1,
    },
    [5] = {
        type = TYPE.CONSUMABLE,
        name = 'Health Potion',
        icon = "ReplaceableTextures\\CommandButtons\\BTNPotionGreen.blp",
        itemLevel = 1,
        requiredLevel = 1,
        rarity = RARITY.COMMON,
        stackSize = 5,
        text = "Heal yourself for 200 HP.",
        spell = 'healpot1',
    },
    [6] = {
        type = TYPE.CONSUMABLE,
        name = 'Cheese',
        icon = "ReplaceableTextures\\CommandButtons\\BTNCheese.blp",
        itemLevel = 1,
        requiredLevel = 1,
        rarity = RARITY.COMMON,
        stackSize = 20,
        text = "Eat to heal 60 HP per 3 seconds.|nMust be out of combat.",
        spell = 'food1',
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
        if itemInfo.stats ~= nil then
            itemStats = itemStats .. "|n|n|cff00ff00"
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
            itemStats = itemStats .. "|r"
        end

        local type = equipment.getSlotName(itemInfo.slot)

        if itemInfo.type == TYPE.CONSUMABLE then
            type = "Consumable"
        end

        local itemText = ""
        if itemInfo.text ~= nil then
            itemText = "|n|n|cff00ff00" .. itemInfo.text .. "|r"

            _, lines = string.gsub(itemInfo.text, "|n", "")
            numLines = numLines + lines + 1
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
    ITEMS = ITEMS,
    init = init,
    getItemInfo = getItemInfo,
    getItemTooltip = getItemTooltip,
    getItemTooltipNumLines = getItemTooltipNumLines,
}
