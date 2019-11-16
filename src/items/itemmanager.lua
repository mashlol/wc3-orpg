local stats = require('src/stats.lua')
local hero = require('src/hero.lua')
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
        color = "|cff8403fc",
        text = "Epic",
        priority = 3,
    },
    LEGENDARY = {
        color = "|cffc4ab1a",
        text = "Legendary",
        priority = 4,
    },
    DIVINE = {
        color = "|cff16c48d",
        text = "Divine",
        priority = 5,
    },
}

local TYPE = {
    EQUIPMENT = 'equipment',
    CONSUMABLE = 'consumable',
}

local yujiId = FourCC('Hyuj')
local azoraId = FourCC('Hazr')
local tarczaId = FourCC('Htar')
local ivanovId = FourCC('Hivn')

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
        usableClasses = {yujiId, azoraId},
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
        name = 'River Turtle Meat',
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
        icon = "war3mapImported\\BTNWolf.blp",
        slot = equipment.SLOT.HELMET,
        requiredLevel = 6,
        itemLevel = 10,
        rarity = RARITY.COMMON,
        cost = 5,
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
        icon = "war3mapImported\\BTNCompanionWolfDire.blp",
        slot = equipment.SLOT.HELMET,
        requiredLevel = 12,
        itemLevel = 19,
        rarity = RARITY.COMMON,
        cost = 8,
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
        icon = "war3mapImported\\BTNHelmet.blp",
        slot = equipment.SLOT.HELMET,
        requiredLevel = 17,
        itemLevel = 32,
        rarity = RARITY.UNCOMMON,
        cost = 14,
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
        icon = "war3mapImported\\BTNAllianceHelmet.blp",
        slot = equipment.SLOT.HELMET,
        requiredLevel = 18,
        itemLevel = 35,
        rarity = RARITY.UNCOMMON,
        cost = 15,
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
        icon = "war3mapImported\\BTNEmpty Amulet.blp",
        slot = equipment.SLOT.NECK,
        requiredLevel = 18,
        itemLevel = 33,
        rarity = RARITY.UNCOMMON,
        cost = 12,
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
        icon = "war3mapImported\\BTNDemonShoulderUPG1.blp",
        slot = equipment.SLOT.SHOULDERS,
        requiredLevel = 10,
        itemLevel = 18,
        rarity = RARITY.UNCOMMON,
        cost = 8,
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
        itemLevel = 22,
        rarity = RARITY.COMMON,
        cost = 7,
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
        icon = "war3mapImported\\BTNShoulderBarrier2.blp",
        usableClasses = {tarczaId},
        slot = equipment.SLOT.SHOULDERS,
        requiredLevel = 20,
        itemLevel = 38,
        rarity = RARITY.UNCOMMON,
        cost = 15,
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
        name = "Turtle Leather Vest",
        icon = "war3mapImported\\BTNINV_Chest_Leather_02.blp",
        slot = equipment.SLOT.CHEST,
        requiredLevel = 3,
        itemLevel = 6,
        rarity = RARITY.COMMON,
        cost = 2,
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
        icon = "war3mapImported\\BTNINV_Robe_03.blp",
        usableClasses = {azoraId,ivanovId},
        slot = equipment.SLOT.CHEST,
        requiredLevel = 13,
        itemLevel = 21,
        rarity = RARITY.COMMON,
        cost = 5,
        stats = {
            {
                type = stats.RAW_SPELL_DAMAGE,
                amount = 8,
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
        icon = "war3mapImported\\BTNPlateArmor.blp",
        usableClasses = {tarczaId,yujiId},
        slot = equipment.SLOT.CHEST,
        requiredLevel = 12,
        itemLevel = 19,
        rarity = RARITY.COMMON,
        cost = 4,
        stats = {
            {
                type = stats.RAW_HIT_POINTS,
                amount = 100,
                tickrate = 5,
            },
        },
    },
    [21] = {
        type = TYPE.EQUIPMENT,
        name = "Overseer's Bath Robe",
        icon = "war3mapImported\\BTNmantle1.blp",
        usableClasses = {ivanovId},
        slot = equipment.SLOT.CHEST,
        requiredLevel = 22,
        itemLevel = 39,
        rarity = RARITY.UNCOMMON,
        cost = 13,
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
        icon = "war3mapImported\\BTNINV_Misc_Cape_04.blp",
        slot = equipment.SLOT.BACK,
        requiredLevel = 6,
        itemLevel = 10,
        rarity = RARITY.COMMON,
        cost = 3,
        stats = {
            {
                type = stats.PERCENT_CAST_SPEED,
                amount = 0.99,
                tickrate = 5,
            },
			{
                type = stats.RAW_SPELL_DAMAGE,
                amount = 10,
                tickrate = 5,
            },
        },
    },
    [23] = {
        type = TYPE.EQUIPMENT,
        name = "Worn Cape",
        icon = "war3mapImported\\BTNINV_Misc_Cape_14.blp",
        slot = equipment.SLOT.BACK,
        requiredLevel = 13,
        itemLevel = 21,
        rarity = RARITY.COMMON,
        cost = 9,
        stats = {
            {
                type = stats.PERCENT_CAST_SPEED,
                amount = 0.98,
                tickrate = 5,
            },
			{
                type = stats.PERCENT_SPELL_DAMAGE,
                amount = 1.10,
                tickrate = 5,
            },
        },
    },
    [24] = {
        type = TYPE.EQUIPMENT,
        name = "Overseer's Drape",
        icon = "war3mapImported\\BTNINV_Misc_Cape_02.blp",
        usableClasses = {azoraId},
        slot = equipment.SLOT.BACK,
        requiredLevel = 22,
        itemLevel = 39,
        rarity = RARITY.UNCOMMON,
        cost = 15,
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
        name = "Fur-Lined Pants",
        icon = "war3mapImported\\BTNINV_Pants_Wolf.blp",
        slot = equipment.SLOT.LEGS,
        requiredLevel = 5,
        itemLevel = 9,
        rarity = RARITY.COMMON,
        cost = 3,
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
        name = "Spiritual Wolf Leggings",
        icon = "war3mapImported\\BTNINV_Pants_02.blp",
        usableClasses = {azoraId,ivanovId},
        slot = equipment.SLOT.LEGS,
        requiredLevel = 11,
        itemLevel = 20,
        rarity = RARITY.UNCOMMON,
        cost = 6,
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
        name = "Cultist Trousers",
        icon = "war3mapImported\\BTNpants01.blp",
        slot = equipment.SLOT.LEGS,
        requiredLevel = 12,
        itemLevel = 19,
        rarity = RARITY.COMMON,
        cost = 8,
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
        icon = "war3mapImported\\BTNpants02.blp",
        usableClasses = {yujiId},
        slot = equipment.SLOT.LEGS,
        requiredLevel = 22,
        itemLevel = 39,
        rarity = RARITY.UNCOMMON,
        cost = 14,
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
        icon = "war3mapImported\\BTNINV_Boots_09.blp",
        slot = equipment.SLOT.FEET,
        requiredLevel = 1,
        itemLevel = 3,
        rarity = RARITY.COMMON,
        cost = 1,
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
        icon = "war3mapImported\\BTNINV_Boots_07.blp",
        slot = equipment.SLOT.FEET,
        requiredLevel = 13,
        itemLevel = 21,
        rarity = RARITY.COMMON,
        cost = 8,
        stats = {
            {
                type = stats.PERCENT_MOVE_SPEED,
                amount = 1.03,
                tickrate = 5,
            },
			{
                type = stats.RAW_SPELL_DAMAGE,
                amount = 8,
                tickrate = 5,
            },
        },
    },
    [31] = {
        type = TYPE.EQUIPMENT,
        name = "Cultist Sabatons",
        icon = "war3mapImported\\BTNINV_Boots_Plate_08.blp",
        slot = equipment.SLOT.FEET,
        requiredLevel = 18,
        itemLevel = 33,
        rarity = RARITY.UNCOMMON,
        cost = 10,
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
        icon = "war3mapImported\\BTNFur Gauntlet.blp",
        slot = equipment.SLOT.HANDS,
        requiredLevel = 7,
        itemLevel = 12,
        rarity = RARITY.COMMON,
        cost = 4,
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
        itemLevel = 21,
        rarity = RARITY.COMMON,
        cost = 7,
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
        icon = "war3mapImported\\BTNMana gloves.blp",
        usableClasses = {azoraId},
        slot = equipment.SLOT.HANDS,
        requiredLevel = 22,
        itemLevel = 36,
        rarity = RARITY.UNCOMMON,
        cost = 13,
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
        icon = "war3mapImported\\BTNINV_Jewelry_Ring_13.blp",
        slot = equipment.SLOT.RING,
        requiredLevel = 18,
        itemLevel = 33,
        rarity = RARITY.UNCOMMON,
        cost = 24,
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
        icon = "war3mapImported\\BTNring1.blp",
        slot = equipment.SLOT.RING,
        requiredLevel = 23,
        itemLevel = 48,
        rarity = RARITY.RARE,
        cost = 35,
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
        icon = "war3mapImported\\BTNDagger.blp",
        slot = equipment.SLOT.WEAPON,
        requiredLevel = 3,
        itemLevel = 6,
        rarity = RARITY.COMMON,
        cost = 2,
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
        icon = "war3mapImported\\BTNBoneDagger.blp",
        slot = equipment.SLOT.WEAPON,
        requiredLevel = 10,
        itemLevel = 16,
        rarity = RARITY.COMMON,
        cost = 6,
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
        itemLevel = 21,
        rarity = RARITY.COMMON,
        cost = 7,
        stats = {
            {
                type = stats.RAW_SPELL_DAMAGE,
                amount = 15,
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
        usableClasses = {tarczaId},
        slot = equipment.SLOT.WEAPON,
        requiredLevel = 22,
        itemLevel = 39,
        rarity = RARITY.UNCOMMON,
        cost = 20,
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
        name = "Spiked Bone Club",
        icon = "war3mapImported\\BTNSpikedClub.blp",
        usableClasses = {tarczaId,yujiId},
        slot = equipment.SLOT.WEAPON,
        requiredLevel = 5,
        itemLevel = 9,
        rarity = RARITY.COMMON,
        cost = 3,
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
        icon = "war3mapImported\\BTNPrehistoric Dino Club.blp",
        usableClasses = {tarczaId,yujiId},
        slot = equipment.SLOT.WEAPON,
        requiredLevel = 12,
        itemLevel = 21,
        rarity = RARITY.UNCOMMON,
        cost = 7,
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
        usableClasses = {tarczaId,yujiId},
        slot = equipment.SLOT.WEAPON,
        requiredLevel = 13,
        itemLevel = 21,
        rarity = RARITY.COMMON,
        cost = 7,
        stats = {
            {
                type = stats.RAW_DAMAGE,
                amount = 35,
                tickrate = 5,
            },
        },
    },
    [44] = {
        type = TYPE.EQUIPMENT,
        name = "Joe's Mining Pick",
        icon = "war3mapImported\\BTNOrcPickAxe.blp",
        usableClasses = {yujiId},
        slot = equipment.SLOT.WEAPON,
        requiredLevel = 20,
        itemLevel = 36,
        rarity = RARITY.UNCOMMON,
        cost = 12,
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
        icon = "war3mapImported\\BTNNerubianShield.blp",
        slot = equipment.SLOT.OFFHAND,
        requiredLevel = 1,
        itemLevel = 3,
        rarity = RARITY.COMMON,
        cost = 1,
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
        icon = "war3mapImported\\BTNbuckler1.blp",
        slot = equipment.SLOT.OFFHAND,
        requiredLevel = 12,
        itemLevel = 19,
        rarity = RARITY.COMMON,
        cost = 5,
        stats = {
            {
                type = stats.RAW_HIT_POINTS,
                amount = 30,
                tickrate = 5,
            },
            {
                type = stats.RAW_INCOMING_DAMAGE,
                amount = -5,
                tickrate = 5,
            },
        },
    },
    [47] = {
        type = TYPE.EQUIPMENT,
        name = "Miner's Lamp",
        icon = "war3mapImported\\BTNLantern.blp",
        usableClasses = {ivanovId},
        slot = equipment.SLOT.OFFHAND,
        requiredLevel = 20,
        itemLevel = 36,
        rarity = RARITY.UNCOMMON,
        cost = 13,
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
    [48] = {
        type = TYPE.CONSUMABLE,
        name = 'Return Stone',
        icon = "ReplaceableTextures\\CommandButtons\\BTNPhilosophersStone.blp",
        itemLevel = 1,
        requiredLevel = 1,
        rarity = RARITY.COMMON,
        stackSize = 1,
        text = "Return to town.|nMust be out of combat.",
        spell = 'hearthstone',
        cost = -1,
        consume = false,
    },
    [49] = {
        type = TYPE.CONSUMABLE,
        name = 'Spirit Winds',
        icon = "ReplaceableTextures\\CommandButtons\\BTNWindWalkOn.blp",
        itemLevel = 1,
        requiredLevel = 1,
        rarity = RARITY.COMMON,
        stackSize = 1,
        text = "Engage the spirit winds to travel faster.|nMust be out of combat.",
        spell = 'mount',
        cost = -1,
        consume = false,
    },
		[50] = {
        type = TYPE.CONSUMABLE,
        name = 'Mammoth Fur',
        icon = "ReplaceableTextures\\CommandButtons\\BTNRedDragon.blp",
        itemLevel = 1,
        requiredLevel = 1,
        rarity = RARITY.COMMON,
        stackSize = 10,
        text = "The fur of a Mammoth...sure looks warm.",
        cost = 20,
    },
		[51] = {
        type = TYPE.CONSUMABLE,
        name = 'Giant Mammoth Fur',
        icon = "ReplaceableTextures\\CommandButtons\\BTNRobeOfTheMagi.blp",
        itemLevel = 1,
        requiredLevel = 1,
        rarity = RARITY.COMMON,
        stackSize = 10,
        text = "This...looks warmer.",
        cost = 20,
    },
}

-- Precompute tooltips at initialization time or you get desyncs
local TOOLTIPS = {}

function getItemInfo(itemId)
    return ITEMS[itemId]
end

function getItemNameWithColor(itemId)
    local itemInfo = ITEMS[itemId]
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
    ITEMS = ITEMS,
    RARITY = RARITY,
    init = init,
    getItemInfo = getItemInfo,
    getItemTooltip = getItemTooltip,
    getItemTooltipNumLines = getItemTooltipNumLines,
    getItemNameWithColor = getItemNameWithColor,
}
