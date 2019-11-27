// Script to read the items csv and convert to lua code for items

const fs = require('fs');
const convertJson = require('./convert_json');

const MAPPINGS = {
    // 'slot': {
    //     'Helmet': 'equipment.SLOT.HELMET',
    //     'Necklace': 'equipment.SLOT.NECK',
    //     'Shoulders': 'equipment.SLOT.SHOULDERS',
    //     'Chest': 'equipment.SLOT.CHEST',
    //     'Back': 'equipment.SLOT.BACK',
    //     'Gloves': 'equipment.SLOT.HANDS',
    //     'Pants': 'equipment.SLOT.LEGS',
    //     'Feet': 'equipment.SLOT.FEET',
    //     'Ring': 'equipment.SLOT.RING',
    //     'Trinket': 'equipment.SLOT.TRINKET',
    //     '1H Weapon': 'equipment.SLOT.WEAPON',
    //     '2H Weapon': 'equipment.SLOT.WEAPON',
    //     'Off-hand': 'equipment.SLOT.OFFHAND',
    // },
    // 'rarity': {
    //     'Common': 'RARITY.COMMON',
    //     'Uncommon': 'RARITY.UNCOMMON',
    //     'Rare': 'RARITY.RARE',
    //     'Epic': 'RARITY.EPIC',
    //     'Legendary': 'RARITY.LEGENDARY',
    //     'Divine': 'RARITY.DIVINE',
    // },
    // 'type': {
    //     'Equipment': 'TYPE.EQUIPMENT',
    //     'Consumable': 'TYPE.CONSUMABLE',
    // },
};

const COLUMNS = {
    'name': {
        name: 'name',
        type: 'string',
    },
    'getQuestFrom': {
        name: 'getQuestFrom',
        type: 'int',
    },
    'handQuestTo': {
        name: 'handQuestTo',
        type: 'int',
    },
    'obtainText': {
        name: 'obtainText',
        type: 'string',
    },
    'incompleteText': {
        name: 'incompleteText',
        type: 'string',
    },
    'completedText': {
        name: 'completedText',
        type: 'string',
    },
    'levelRequirement': {
        name: 'levelRequirement',
        type: 'int',
    },
    'rewards': {
        name: 'rewards',
        type: 'rewardList',
    },
    'objectives': {
        name: 'objectives',
        type: 'sublist',
        columns: {
            'type': {
                name: 'type',
                type: 'mapping',
                mapping: 'objectiveType',
            },
            'amount': {
                name: 'amount',
                type: 'int',
            },
            'itemId': {
                name: 'itemId',
                type: 'int',
            },
            'toKill': {
                name: 'toKill',
                type: 'int',
                fn: (x) => 'FourCC(\'' + x + '\')',
            },
            'name': {
                name: 'name',
                type: 'string',
            },
            'verb': {
                name: 'verb',
                type: 'string',
            },
            'verbPast': {
                name: 'verbPast',
                type: 'string',
            },
        },
        mappings: {
            'objectiveType': {
                'Kill': 'TYPE.KILL',
                'Gather': 'TYPE.ITEM',
                'Discover': 'TYPE.DISCOVER',
            }
        },
    },
    'prerequisites': {
        name: 'prerequisites',
        type: 'intlist',
    },
};

const input = fs.readFileSync('../json/quests.json', {encoding: 'utf8'});
const parsed = JSON.parse(input);

let finalResult = convertJson(parsed, COLUMNS, MAPPINGS);

finalResult = `

local TYPE = {
    KILL = {},
    ITEM = {},
    DISCOVER = {},
}

` +
    'function getQuests() \n' +
    'return {\n' +
    finalResult +
    '}\n' +
    'end\n' +
    'return {getQuests = getQuests, TYPE=TYPE}';

fs.writeFileSync('../gen/quests/quests.lua', finalResult);
