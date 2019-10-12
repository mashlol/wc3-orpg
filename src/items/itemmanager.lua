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
    EPIC = {
        color = "|cffc4ab1a", -- TODO WRONG COLOR
        text = "Epic",
        priority = 3,
    },
    LEGENDARY = {
        color = "|cffc4ab1a",
        text = "Legendary",
        priority = 4,
    },
    DIVINE = {
        color = "|cffc4ab1a", -- TODO WRONG COLOR
        text = "Divine",
        priority = 5,
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
        usableClasses = {FourCC('Hyuj')},
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
    [10] = {
        type = TYPE.EQUIPMENT,
        name = "Wolf Helmet",
        icon = "",
        slot = equipment.SLOT.HELMET,
        requiredLevel = 6,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_HIT_POINTS,
                amount = 25,
                tickrate = 5,
            },
        },
    },
    [11] = {
        type = TYPE.EQUIPMENT,
        name = "Giant Wolf Helmet",
        icon = "",
        slot = equipment.SLOT.HELMET,
        requiredLevel = 12,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_HIT_POINTS,
                amount = 50,
                tickrate = 5,
            },
        },
    },
    [12] = {
        type = TYPE.EQUIPMENT,
        name = "Leather Helmet",
        icon = "",
        slot = equipment.SLOT.HELMET,
        requiredLevel = 18,
        itemLevel = 0,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = stats.RAW_HIT_POINTS,
                amount = 80,
                tickrate = 5,
            },
            {
                type = stats.HEALTH_REGEN,
                amount = 2,
                tickrate = 5,
            },
        },
    },
    [13] = {
        type = TYPE.EQUIPMENT,
        name = "Green Iron Helm",
        icon = "",
        slot = equipment.SLOT.HELMET,
        requiredLevel = 20,
        itemLevel = 0,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = stats.RAW_HIT_POINTS,
                amount = 100,
                tickrate = 5,
            },
            {
                type = stats.HEALTH_REGEN,
                amount = 4,
                tickrate = 5,
            },
        },
    },
    [14] = {
        type = TYPE.EQUIPMENT,
        name = "Cultist Pendant",
        icon = "",
        slot = equipment.SLOT.NECK,
        requiredLevel = 20,
        itemLevel = 0,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = stats.HEALTH_REGEN,
                amount = 5,
                tickrate = 5,
            },
            {
                type = stats.RAW_INCOMING_HEALING,
                amount = 5,
                tickrate = 5,
            },
        },
    },
    [15] = {
        type = TYPE.EQUIPMENT,
        name = "Shell Pads",
        icon = "",
        slot = equipment.SLOT.SHOULDERS,
        requiredLevel = 10,
        itemLevel = 0,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = stats.RAW_HIT_POINTS,
                amount = 45,
                tickrate = 5,
            },
            {
                type = stats.HEALTH_REGEN,
                amount = 2,
                tickrate = 5,
            },
        },
    },
    [16] = {
        type = TYPE.EQUIPMENT,
        name = "Cultist Epaulets",
        icon = "war3mapImported\\BTNShoulderplate.blp",
        slot = equipment.SLOT.SHOULDERS,
        requiredLevel = 14,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_HIT_POINTS,
                amount = 30,
                tickrate = 5,
            },
        },
    },
    [17] = {
        type = TYPE.EQUIPMENT,
        name = "Miner Spaulders",
        icon = "",
        slot = equipment.SLOT.SHOULDERS,
        requiredLevel = 22,
        itemLevel = 0,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = stats.RAW_HIT_POINTS,
                amount = 75,
                tickrate = 5,
            },
            {
                type = stats.RAW_INCOMING_DAMAGE,
                amount = -5,
                tickrate = 5,
            },
            {
                type = stats.HEALTH_REGEN,
                amount = 3,
                tickrate = 5,
            },
        },
    },
    [18] = {
        type = TYPE.EQUIPMENT,
        name = "Turtle Carapace",
        icon = "",
        slot = equipment.SLOT.CHEST,
        requiredLevel = 3,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_HIT_POINTS,
                amount = 50,
                tickrate = 5,
            },
        },
    },
    [19] = {
        type = TYPE.EQUIPMENT,
        name = "Cultist Robes",
        icon = "",
        slot = equipment.SLOT.CHEST,
        requiredLevel = 13,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_SPELL_DAMAGE,
                amount = 5,
                tickrate = 5,
            },
            {
                type = stats.RAW_HIT_POINTS,
                amount = 55,
                tickrate = 5,
            },
        },
    },
    [20] = {
        type = TYPE.EQUIPMENT,
        name = "Cultist Cuirass",
        icon = "",
        slot = equipment.SLOT.CHEST,
        requiredLevel = 13,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_HIT_POINTS,
                amount = 80,
                tickrate = 5,
            },
        },
    },
    [21] = {
        type = TYPE.EQUIPMENT,
        name = "Overseer's Cloth Robes",
        icon = "",
        slot = equipment.SLOT.CHEST,
        requiredLevel = 24,
        itemLevel = 0,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = stats.PERCENT_CAST_SPEED,
                amount = 0.97,
                tickrate = 5,
            },
            {
                type = stats.RAW_HIT_POINTS,
                amount = 60,
                tickrate = 5,
            },
            {
                type = stats.RAW_HEALING,
                amount = 15,
                tickrate = 5,
            },
        },
    },
    [22] = {
        type = TYPE.EQUIPMENT,
        name = "Wolf Pelt",
        icon = "",
        slot = equipment.SLOT.BACK,
        requiredLevel = 6,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.PERCENT_CAST_SPEED,
                amount = 0.99,
                tickrate = 5,
            },
        },
    },
    [23] = {
        type = TYPE.EQUIPMENT,
        name = "Worn Cape",
        icon = "",
        slot = equipment.SLOT.BACK,
        requiredLevel = 13,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.PERCENT_CAST_SPEED,
                amount = 0.98,
                tickrate = 5,
            },
        },
    },
    [24] = {
        type = TYPE.EQUIPMENT,
        name = "Overseer's Drape",
        icon = "",
        slot = equipment.SLOT.BACK,
        requiredLevel = 24,
        itemLevel = 0,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = stats.PERCENT_CAST_SPEED,
                amount = 0.96,
                tickrate = 5,
            },
        },
    },
    [25] = {
        type = TYPE.EQUIPMENT,
        name = "Fur-Lined Leggings",
        icon = "",
        slot = equipment.SLOT.LEGS,
        requiredLevel = 6,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_HIT_POINTS,
                amount = 15,
                tickrate = 5,
            },
        },
    },
    [26] = {
        type = TYPE.EQUIPMENT,
        name = "Spiritual Wolf Kilt",
        icon = "",
        slot = equipment.SLOT.LEGS,
        requiredLevel = 11,
        itemLevel = 0,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = stats.RAW_SPELL_DAMAGE,
                amount = 10,
                tickrate = 5,
            },
            {
                type = stats.PERCENT_CAST_SPEED,
                amount = 0.99,
                tickrate = 5,
            },
            {
                type = stats.RAW_HIT_POINTS,
                amount = 30,
                tickrate = 5,
            },
        },
    },
    [27] = {
        type = TYPE.EQUIPMENT,
        name = "Cultist Leggings",
        icon = "",
        slot = equipment.SLOT.LEGS,
        requiredLevel = 12,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_HIT_POINTS,
                amount = 25,
                tickrate = 5,
            },
        },
    },
    [28] = {
        type = TYPE.EQUIPMENT,
        name = "Overseer's Leggings",
        icon = "",
        slot = equipment.SLOT.LEGS,
        requiredLevel = 24,
        itemLevel = 0,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = stats.PERCENT_ATTACK_SPEED,
                amount = 0.98,
                tickrate = 5,
            },
            {
                type = stats.RAW_HIT_POINTS,
                amount = 60,
                tickrate = 5,
            },
            {
                type = stats.HEALTH_REGEN,
                amount = 5,
                tickrate = 5,
            },
        },
    },
    [29] = {
        type = TYPE.EQUIPMENT,
        name = "Old Boots",
        icon = "",
        slot = equipment.SLOT.FEET,
        requiredLevel = 1,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.PERCENT_MOVE_SPEED,
                amount = 1.02,
                tickrate = 5,
            },
        },
    },
    [30] = {
        type = TYPE.EQUIPMENT,
        name = "Worn Running Boots",
        icon = "",
        slot = equipment.SLOT.FEET,
        requiredLevel = 13,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.PERCENT_MOVE_SPEED,
                amount = 1.03,
                tickrate = 5,
            },
        },
    },
    [31] = {
        type = TYPE.EQUIPMENT,
        name = "Cultist Sabatons",
        icon = "",
        slot = equipment.SLOT.FEET,
        requiredLevel = 20,
        itemLevel = 0,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = stats.PERCENT_MOVE_SPEED,
                amount = 1.04,
                tickrate = 5,
            },
        },
    },
    [32] = {
        type = TYPE.EQUIPMENT,
        name = "Fur-lined Gloves",
        icon = "",
        slot = equipment.SLOT.HANDS,
        requiredLevel = 6,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_DAMAGE,
                amount = 5,
                tickrate = 5,
            },
            {
                type = stats.PERCENT_ATTACK_SPEED,
                amount = 0.98,
                tickrate = 5,
            },
        },
    },
    [33] = {
        type = TYPE.EQUIPMENT,
        name = "Leather Gloves",
        icon = "war3mapImported\\BTNLeather Gauntlet.blp",
        slot = equipment.SLOT.HANDS,
        requiredLevel = 13,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_DAMAGE,
                amount = 7,
                tickrate = 5,
            },
            {
                type = stats.PERCENT_ATTACK_SPEED,
                amount = 0.97,
                tickrate = 5,
            },
        },
    },
    [34] = {
        type = TYPE.EQUIPMENT,
        name = "Conjurer's Gloves",
        icon = "",
        slot = equipment.SLOT.HANDS,
        requiredLevel = 22,
        itemLevel = 0,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = stats.RAW_SPELL_DAMAGE,
                amount = 5,
                tickrate = 5,
            },
            {
                type = stats.PERCENT_CAST_SPEED,
                amount = 0.95,
                tickrate = 5,
            },
            {
                type = stats.RAW_PERCENT_CRITICAL,
                amount = 1,
                tickrate = 5,
            },
        },
    },
    [35] = {
        type = TYPE.EQUIPMENT,
        name = "Brass Ring",
        icon = "",
        slot = equipment.SLOT.RING,
        requiredLevel = 20,
        itemLevel = 0,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = stats.RAW_PERCENT_CRITICAL,
                amount = 1,
                tickrate = 5,
            },
            {
                type = stats.RAW_CRITICAL_DAMAGE,
                amount = 5,
                tickrate = 5,
            },
        },
    },
    [36] = {
        type = TYPE.EQUIPMENT,
        name = "Overseer's Ring",
        icon = "",
        slot = equipment.SLOT.RING,
        requiredLevel = 24,
        itemLevel = 0,
        rarity = RARITY.RARE,
        stats = {
            {
                type = stats.RAW_PERCENT_CRITICAL,
                amount = 2,
                tickrate = 5,
            },
            {
                type = stats.RAW_CRITICAL_DAMAGE,
                amount = 20,
                tickrate = 5,
            },
        },
    },
    [37] = {
        type = TYPE.EQUIPMENT,
        name = "Turtle Claw",
        icon = "",
        slot = equipment.SLOT.WEAPON,
        requiredLevel = 3,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_DAMAGE,
                amount = 10,
                tickrate = 5,
            },
        },
    },
    [38] = {
        type = TYPE.EQUIPMENT,
        name = "Giant Wolf Fang",
        icon = "",
        slot = equipment.SLOT.WEAPON,
        requiredLevel = 10,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_DAMAGE,
                amount = 20,
                tickrate = 5,
            },
            {
                type = stats.PERCENT_ATTACK_SPEED,
                amount = 0.99,
                tickrate = 5,
            },
        },
    },
    [39] = {
        type = TYPE.EQUIPMENT,
        name = "Cultist Wand",
        icon = "war3mapImported\\BTNMurgulStaff.blp",
        slot = equipment.SLOT.WEAPON,
        requiredLevel = 13,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_SPELL_DAMAGE,
                amount = 7,
                tickrate = 5,
            },
            {
                type = stats.PERCENT_CAST_SPEED,
                amount = 0.95,
                tickrate = 5,
            },
        },
    },
    [40] = {
        type = TYPE.EQUIPMENT,
        name = "Overseer's Whip",
        icon = "war3mapImported\\BTNRidingCrop.blp",
        slot = equipment.SLOT.WEAPON,
        requiredLevel = 24,
        itemLevel = 0,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = stats.RAW_DAMAGE,
                amount = 35,
                tickrate = 5,
            },
            {
                type = stats.PERCENT_ATTACK_SPEED,
                amount = 0.98,
                tickrate = 5,
            },
            {
                type = stats.RAW_INCOMING_HEALING,
                amount = 10,
                tickrate = 5,
            },
        },
    },
    [41] = {
        type = TYPE.EQUIPMENT,
        name = "Bone Club",
        icon = "",
        slot = equipment.SLOT.WEAPON,
        requiredLevel = 6,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_DAMAGE,
                amount = 18,
                tickrate = 5,
            },
        },
    },
    [42] = {
        type = TYPE.EQUIPMENT,
        name = "Giant Bone Club",
        icon = "",
        slot = equipment.SLOT.WEAPON,
        requiredLevel = 12,
        itemLevel = 0,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = stats.RAW_DAMAGE,
                amount = 30,
                tickrate = 5,
            },
            {
                type = stats.RAW_PERCENT_CRITICAL,
                amount = 1,
                tickrate = 5,
            },
        },
    },
    [43] = {
        type = TYPE.EQUIPMENT,
        name = "Broadsword",
        icon = "war3mapImported\\BTNAncientRelic.blp",
        slot = equipment.SLOT.WEAPON,
        requiredLevel = 13,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_DAMAGE,
                amount = 25,
                tickrate = 5,
            },
        },
    },
    [44] = {
        type = TYPE.EQUIPMENT,
        name = "Joe's Mining Pick",
        icon = "war3mapImported\\BTNOrcPickAxe.blp",
        slot = equipment.SLOT.WEAPON,
        requiredLevel = 22,
        itemLevel = 0,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = stats.RAW_DAMAGE,
                amount = 45,
                tickrate = 5,
            },
            {
                type = stats.PERCENT_ATTACK_SPEED,
                amount = 0.97,
                tickrate = 5,
            },
            {
                type = stats.RAW_PERCENT_CRITICAL,
                amount = 1,
                tickrate = 5,
            },
            {
                type = stats.RAW_CRITICAL_DAMAGE,
                amount = 5,
                tickrate = 5,
            },
        },
    },
    [45] = {
        type = TYPE.EQUIPMENT,
        name = "Shell Shield",
        icon = "",
        slot = equipment.SLOT.OFFHAND,
        requiredLevel = 1,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_HIT_POINTS,
                amount = 10,
                tickrate = 5,
            },
            {
                type = stats.RAW_INCOMING_DAMAGE,
                amount = -2,
                tickrate = 5,
            },
        },
    },
    [46] = {
        type = TYPE.EQUIPMENT,
        name = "Cultist Blocker",
        icon = "",
        slot = equipment.SLOT.OFFHAND,
        requiredLevel = 12,
        itemLevel = 0,
        rarity = RARITY.COMMON,
        stats = {
            {
                type = stats.RAW_HIT_POINTS,
                amount = 20,
                tickrate = 5,
            },
            {
                type = stats.RAW_INCOMING_DAMAGE,
                amount = -3,
                tickrate = 5,
            },
        },
    },
    [47] = {
        type = TYPE.EQUIPMENT,
        name = "Miner's Lamp",
        icon = "",
        slot = equipment.SLOT.OFFHAND,
        requiredLevel = 22,
        itemLevel = 0,
        rarity = RARITY.UNCOMMON,
        stats = {
            {
                type = stats.RAW_HIT_POINTS,
                amount = 25,
                tickrate = 5,
            },
            {
                type = stats.RAW_PERCENT_CRITICAL,
                amount = 1,
                tickrate = 5,
            },
            {
                type = stats.RAW_HEALING,
                amount = 5,
                tickrate = 5,
            },
        },
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
