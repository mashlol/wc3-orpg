local equipment = require('src/items/equipment.lua')
local stats = require('src/stats.lua')

local RARITY = {
    COMMON = {
        color = '|cffffffff',
        text = 'Common',
        priority = 0,
    },
    UNCOMMON = {
        color = '|cff2cfc03',
        text = 'Uncommon',
        priority = 1,
    },
    RARE = {
        color = '|cff036ffc',
        text = 'Rare',
        priority = 2,
    },
    EPIC = {
        color = '|cff8403fc',
        text = 'Epic',
        priority = 3,
    },
    LEGENDARY = {
        color = '|cffc4ab1a',
        text = 'Legendary',
        priority = 4,
    },
    DIVINE = {
        color = '|cff16c48d',
        text = 'Divine',
        priority = 5,
    },
}

local TYPE = {
    EQUIPMENT = 'equipment',
    CONSUMABLE = 'consumable',
}

    local ITEMS = {
[1] = {
    name = "Boots of Power",
    icon = "BTNINV_Boots_07.blp",
    usableClasses = {FourCC('Hyuj'),FourCC('Hstm'),FourCC('Hivn'),FourCC('Hazr')},
    slot = equipment.SLOT.HELMET,
    requiredLevel = 50,
    itemLevel = 10,
    rarity = RARITY.RARE,
    cost = 5,
    type = TYPE.EQUIPMENT,
    stats = {
        {
            type = stats.HEALTH_REGEN,
            amount = 25,
            tickrate = 5,
        },
    },
},
[2] = {
    name = "Sweet Item",
    slot = equipment.SLOT.SHOULDERS,
    rarity = RARITY.EPIC,
    icon = "BTNArmor.blp",
    requiredLevel = 123,
    itemLevel = 14,
    cost = 25,
    usableClasses = {FourCC('Hstm')},
    type = TYPE.EQUIPMENT,
    stats = {
        {
            type = stats.PERCENT_MOVE_SPEED,
            amount = 1.05,
            tickrate = 5,
        },
    },
},
[3] = {
    name = "Saxons Item",
    slot = equipment.SLOT.WEAPON,
    rarity = RARITY.RARE,
    icon = "BTNDagger.blp",
    requiredLevel = 12,
    itemLevel = 12,
    cost = 50,
    usableClasses = {FourCC('Hazr'),FourCC('Htar')},
    type = TYPE.EQUIPMENT,
    stats = {
        {
            type = stats.RAW_SPELL_DAMAGE,
            amount = 50000000,
            tickrate = 5,
        },
    },
},
[4] = {
    name = "Cheese",
    type = TYPE.CONSUMABLE,
    text = "Heal yourself for 250",
    icon = "ReplaceableTextures\\CommandButtons\\BTNCheese.blp",
    requiredLevel = 1,
    itemLevel = 1,
    cost = 5,
    stackSize = 5,
    spell = "food1",
    rarity = RARITY.COMMON,
    stats = {
    },
},
}
 return {ITEMS=ITEMS, TYPE=TYPE}
