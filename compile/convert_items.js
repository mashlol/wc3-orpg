// Script to read the items csv and convert to lua code for items

const fs = require('fs');
const csvParse = require('csv-parse/lib/sync');

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
        'Common': 'itemmanager.RARITY.COMMON',
        'Uncommon': 'itemmanager.RARITY.UNCOMMON',
        'Rare': 'itemmanager.RARITY.RARE',
        'Epic': 'itemmanager.RARITY.EPIC',
        'Legendary': 'itemmanager.RARITY.LEGENDARY',
        'Divine': 'itemmanager.RARITY.DIVINE',
    },
    'type': {
        'Equipment': 'itemmanager.TYPE.EQUIPMENT',
        'Consumable': 'itemmanager.TYPE.CONSUMABLE',
    },
};

const INITIAL_ID = 10;
const COLUMNS = {
    'name': {
        name: 'name',
        type: 'string',
    },
    'icon': {
        name: 'icon',
        type: 'string',
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

const STATS = {
    '% Move Speed': {
        lua: 'stats.PERCENT_MOVE_SPEED',
        fn: (x) => (x / 100) + 1,
    },
    '% Scale': {
        lua: 'stats.SCALE',
        fn: (x) => (x / 100) + 1,
    },
    'Stam': {
        lua: 'stats.RAW_HIT_POINTS',
    },
    'HP Regen': {
        lua: 'stats.HEALTH_REGEN',
    },
    'Attack Damage': {
        lua: 'stats.RAW_DAMAGE',
    },
    '% Attack Damage': {
        lua: 'stats.PCT_DAMAGE',
        fn: (x) => (x / 100) + 1,
    },
    'Spell Damage': {
        lua: 'stats.RAW_SPELL_DAMAGE',
    },
    '% Spell Damage': {
        lua: 'stats.PCT_SPELL_DAMAGE',
        fn: (x) => (x / 100) + 1,
    },
    'Healing': {
        lua: 'stats.RAW_HEALING',
    },
    '% Healing': {
        lua: 'stats.PCT_HEALING',
        fn: (x) => (x / 100) + 1,
    },
    '% Physical Damage Taken': {
        lua: 'stats.PCT_INCOMING_DAMAGE',
        fn: (x) => (x / 100) + 1,
    },
    '% Spell Damage Taken': {
        lua: 'stats.PCT_INCOMING_SPELL_DAMAGE',
        fn: (x) => (x / 100) + 1,
    },
    '% Healing Received': {
        lua: 'stats.PCT_ICOMING_HEALING',
        fn: (x) => (x / 100) + 1,
    },
    'Physical Damage Taken': {
        lua: 'stats.RAW_INCOMING_DAMAGE',
    },
    'Spell Damage Taken': {
        lua: 'stats.RAW_INCOMING_SPELL_DAMAGE',
    },
    'INCOMING_HEALING_RAW': {
        lua: 'stats.RAW_INCOMING_HEALING',
    },
    '% Cooldown Reduction': {
        lua: 'stats.PERCENT_COOLDOWN_REDUCTION',
        fn: (x) => 1 - (x / 100),
    },
    '% Cooldown Reduction': {
        lua: 'stats.PERCENT_COOLDOWN_REDUCTION',
        fn: (x) => 1 - (x / 100),
    },
    '% Cast Speed': {
        lua: 'stats.PERCENT_CAST_SPEED',
        fn: (x) => 1 - (x / 100),
    },
    '% Attack Speed': {
        lua: 'stats.PERCENT_ATTACK_SPEED',
        fn: (x) => 1 - (x / 100),
    },
    '% Crit Chance': {
        lua: 'stats.RAW_PERCENT_CRITICAL',
    },
    'Critical Damage': {
        lua: 'stats.RAW_CRITICAL_DAMAGE',
    },
    '% Critical Damage': {
        lua: 'stats.PCT_CRITICAL_DAMAGE',
        fn: (x) => (x / 100) + 1,
    }
}

const input = fs.readFileSync('../json/items.json', {encoding: 'utf8'});
const parsed = JSON.parse(input);

let finalResult = "";

for (const x in parsed) {
    const row = parsed[x];

    let itemResult = "[" + x + "] = {\n";
    let stats = "{\n";
    for (const y in row) {
        const column = COLUMNS[y];
        let value = row[y];

        if (column && column.type === 'string') {
            itemResult += '    ' + column.name + " = \"" + value + "\",\n";
        } else if (column && column.type === 'mapping') {
            const result = MAPPINGS[column.mapping][value];
            itemResult += '    ' + column.name + " = " + result + ",\n";
        } else if (column && column.type === 'int') {
            if (!value) {
                value = '0';
            }
            itemResult += '    ' + column.name + " = " + value + ",\n";
        } else if (column && column.type === 'classList') {
            if (value.length == 0) {
                // Ignored
            } else {
                const allowedClasses = value.map(x => {
                    if (x == 'Tarcza') {
                        return 'FourCC(\'Htar\')';
                    } else if (x == 'Yuji') {
                        return 'FourCC(\'Hyuj\')';
                    } else if (x == 'Azora') {
                        return 'FourCC(\'Hazr\')';
                    } else if (x == 'Ivanov') {
                        return 'FourCC(\'Hivn\')';
                    } else if (x == 'Stormfist') {
                        return 'FourCC(\'Hstm\')';
                    }
                }).join(',');
                itemResult += '    ' + column.name + ' = ' + '{' + allowedClasses + '},\n';
            }
        } else if (column && column.type === 'statList') {
            const statList = value;
            for (const statKey in value) {
                const stat = STATS[statKey];
                let statValue = value[statKey];
                if (stat && statValue) {
                    if (stat.fn) {
                        statValue = stat.fn(statValue);
                    }
                    stats += '        {\n            type = ' + stat.lua + ',\n            amount = ' + statValue + ',\n            tickrate = 5,\n        },\n';
                }
            }

        }


    }

    finalResult += itemResult + '    stats = ' + stats + '    },\n},\n';
}

finalResult = "local equipment = require('src/items/equipment.lua')\n" +
    "local stats = require('src/stats.lua')\n" +
    "local itemmanager = require('src/stats.lua')\n" +
    'local ITEMS = {\n' +
    finalResult +
    '}\n return {ITEMS=ITEMS}\n';

fs.writeFileSync('../src/items/items.lua', finalResult);
