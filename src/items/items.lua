local equipment = require('src/items/equipment.lua')
local stats = require('src/stats.lua')
local itemmanager = require('src/stats.lua')
local ITEMS = {
[1] = {
    name = "Boots of Power",
    icon = "BTNINV_Boots_07.blp",
    usableClasses = {FourCC('Hyuj'),FourCC('Hstm'),FourCC('Hivn'),FourCC('Hazr')},
    slot = equipment.SLOT.HELMET,
    requiredLevel = 50,
    itemLevel = 10,
    rarity = itemmanager.RARITY.RARE,
    cost = 5,
    type = itemmanager.TYPE.EQUIPMENT,
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
    rarity = itemmanager.RARITY.EPIC,
    icon = "BTNArmor.blp",
    requiredLevel = 123,
    itemLevel = 14,
    cost = 25,
    usableClasses = {FourCC('Hstm')},
    type = itemmanager.TYPE.EQUIPMENT,
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
    rarity = itemmanager.RARITY.RARE,
    icon = "BTNDagger.blp",
    requiredLevel = 12,
    itemLevel = 12,
    cost = 50,
    usableClasses = {FourCC('Hazr'),FourCC('Htar')},
    type = itemmanager.TYPE.EQUIPMENT,
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
    type = itemmanager.TYPE.CONSUMABLE,
    text = "Heal yourself for 250",
    icon = "BTNAllianceHelmet.blp",
    requiredLevel = 1,
    itemLevel = 1,
    cost = 5,
    stackSize = 5,
    spell = "food1",
    stats = {
    },
},
}
 return {ITEMS=ITEMS}
