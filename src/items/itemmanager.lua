local stats = require('src/stats.lua')
local equipment = require('src/items/equipment.lua')

local RARITY = {
    COMMON = {
        color = "|cffffffff",
        text = "Common",
        priority = 0,
    },
    UNCOMMON = {
        color = "|cff2cfc03",
        text = "Uncommon",
        priority = 1,
    },
    RARE = {
        color = "|cff036ffc",
        text = "Rare",
        priority = 2,
    },
    LEGENDARY = {
        color = "|cffc4ab1a",
        text = "Legendary",
        priority = 3,
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
                type = stats.RAW_HIT_POINTS,
                amount = 10,
            },
        },
        slot = equipment.SLOT.FEET,
        stackSize = 1,
        cost = 30,
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
                type = stats.RAW_HIT_POINTS,
                amount = 10,
            },
            {
                type = stats.PERCENT_DAMAGE,
                amount = 1.01,
            },
        },
        slot = equipment.SLOT.RING,
        stackSize = 1,
        cost = 150,
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
                type = stats.RAW_HIT_POINTS,
                amount = 40,
            },
        },
        slot = equipment.SLOT.HELMET,
        stackSize = 1,
        cost = 80,
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
                type = stats.PERCENT_DAMAGE,
                amount = 1.1,
            },
        },
        slot = equipment.SLOT.WEAPON,
        stackSize = 1,
        cost = 300,
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
        cost = 20,
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
        cost = 5,
    },
	[7] = {
        type = TYPE.EQUIPMENT,
        name = 'Chain Vest',
        icon = "ReplaceableTextures\\CommandButtons\\BTNMantleOfIntelligence.blp",
        itemLevel = 1,
        requiredLevel = 1,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.PERCENT_INCOMING_DAMAGE,
                amount = 0.98,
            },
        },
        slot = equipment.SLOT.CHEST,
        stackSize = 1,
        cost = 35,
    },
	[8] = {
        type = TYPE.EQUIPMENT,
        name = 'Cloak',
        icon = "ReplaceableTextures\\CommandButtons\\BTNCloak.blp",
        itemLevel = 1,
        requiredLevel = 1,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.PERCENT_MOVE_SPEED,
                amount = 1.03,
            },
        },
        slot = equipment.SLOT.BACK,
        stackSize = 1,
        cost = 35,
    },
	[9] = {
        type = TYPE.CONSUMABLE,
        name = 'Giant Turtle Meat',
        icon = "ReplaceableTextures\\CommandButtons\\BTNMonsterLure.blp",
        itemLevel = 1,
        requiredLevel = 1,
        rarity = RARITY.COMMON,
        stackSize = 10,
        text = "The meat of a turtle...I think Fred wants this.",
        cost = 20,
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
                itemStats = itemStats .. statInfo.type.getTooltip(statInfo) .. "|n"
                numLines = numLines + 1
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
    RARITY = RARITY,
    init = init,
    getItemInfo = getItemInfo,
    getItemTooltip = getItemTooltip,
    getItemTooltipNumLines = getItemTooltipNumLines,
}
