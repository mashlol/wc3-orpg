// Script to read the items csv and convert to lua code for items

const fs = require('fs');
const convertJson = require('./convert_json');

const MAPPINGS = {
    'slot': {
        'Helmet': 'equipment.SLOT.HELMET',
        'Necklace': 'equipment.SLOT.NECK',
        'Shoulders': 'equipment.SLOT.SHOULDERS',
        'Chest': 'equipment.SLOT.CHEST',
        'Back': 'equipment.SLOT.BACK',
        'Gloves': 'equipment.SLOT.HANDS',
        'Pants': 'equipment.SLOT.LEGS',
        'Feet': 'equipment.SLOT.FEET',
        'Ring': 'equipment.SLOT.RING',
        'Trinket': 'equipment.SLOT.TRINKET',
        '1H Weapon': 'equipment.SLOT.WEAPON',
        '2H Weapon': 'equipment.SLOT.WEAPON',
        'Off-hand': 'equipment.SLOT.OFFHAND',
    },
    'rarity': {
        'Common': 'RARITY.COMMON',
        'Uncommon': 'RARITY.UNCOMMON',
        'Rare': 'RARITY.RARE',
        'Epic': 'RARITY.EPIC',
        'Legendary': 'RARITY.LEGENDARY',
        'Divine': 'RARITY.DIVINE',
    },
    'type': {
        'Equipment': 'TYPE.EQUIPMENT',
        'Consumable': 'TYPE.CONSUMABLE',
    },
};

const COLUMNS = {
    'name': {
        name: 'name',
        type: 'string',
    },
    'icon': {
        name: 'icon',
        type: 'string',
        fn: (x) => x.replace(/\\/g, '\\\\')
    },
    'type': {
        name: 'slot',
        type: 'mapping',
        mapping: 'slot',
    },
    'requiredLevel': {
        name: 'requiredLevel',
        type: 'int',
    },
    'rarity': {
        name: 'rarity',
        type: 'mapping',
        mapping: 'rarity',
    },
    'itemLevel': {
        name: 'itemLevel',
        type: 'int',
    },
    'cost': {
        name: 'cost',
        type: 'int',
    },
    'usable': {
        name: 'usableClasses',
        type: 'classList',
    },
    'stats': {
        name: 'stats',
        type: 'statList',
    },
    'classification': {
        name: 'type',
        type: 'mapping',
        mapping: 'type',
    },
    'stackSize': {
        name: 'stackSize',
        type: 'int',
    },
    'tooltip': {
        name: 'text',
        type: 'string',
    },
    'spellKey': {
        name: 'spell',
        type: 'string',
    },
};

const input = fs.readFileSync('../json/items.json', {encoding: 'utf8'});
const parsed = JSON.parse(input);

let finalResult = convertJson(parsed, COLUMNS, MAPPINGS);

finalResult = "local equipment = require('src/items/equipment.lua')\n" +
    "local stats = require('src/stats.lua')\n" + `
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

` +
    'local ITEMS = {\n' +
    finalResult +
    '}\n return {ITEMS=ITEMS, TYPE=TYPE}\n';

fs.writeFileSync('../gen/items/items.lua', finalResult);
