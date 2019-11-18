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
        'Common': 'RARITY.COMMON',
        'uncommon': 'RARITY.UNCOMMON',
        'Rare': 'RARITY.RARE',
        'Epic': 'RARITY.EPIC',
        'Legendary': 'RARITY.LEGENDARY',
        'Divine': 'RARITY.DIVINE',
    },
};

const INITIAL_ID = 10;
const COLUMNS = {
    'Item Name': {
        name: 'name',
        type: 'string',
    },
    'Item Icon': {
        name: 'icon',
        type: 'string',
    },
    'Item type': {
        name: 'slot',
        type: 'mapping',
        mapping: 'slot',
    },
    'Required Level': {
        name: 'requiredLevel',
        type: 'int',
    },
    'Rarity': {
        name: 'rarity',
        type: 'mapping',
        mapping: 'rarity',
    },
    'iLVL': {
        name: 'itemLevel',
        type: 'int',
    },
    'Sell': {
        name: 'cost',
        type: 'int',
    },
    'Can wear': {
        name: 'usableClasses',
        type: 'classList',
    },
};

const STATS = {
    'AD': {
        lua: 'stats.RAW_DAMAGE',
    },
    '%AS': {
        lua: 'stats.PERCENT_ATTACK_SPEED',
        fn: (x) => 1 - (x / 100),
    },
    'SP': {
        lua: 'stats.RAW_SPELL_DAMAGE',
    },
    'CastSp': {
        lua: 'stats.PERCENT_CAST_SPEED',
        fn: (x) => 1 - (x / 100),
    },
    'Stam': {
        lua: 'stats.RAW_HIT_POINTS',
    },
    'DmgR': {
        lua: 'stats.RAW_INCOMING_DAMAGE',
        fn: (x) => -x,
    },
    'MS': {
        lua: 'stats.PERCENT_MOVE_SPEED',
        fn: (x) => (x / 100) + 1,
    },
    'Stam': {
        lua: 'stats.RAW_HIT_POINTS',
    },
    'Hregen': {
        lua: 'stats.HEALTH_REGEN',
    },
    'CritChan': {
        lua: 'stats.RAW_PERCENT_CRITICAL',
    },
    'CritDam': {
        lua: 'stats.RAW_CRITICAL_DAMAGE',
    },
    'HealRec': {
        lua: 'stats.RAW_INCOMING_HEALING',
    },
    'Healing': {
        lua: 'stats.RAW_HEALING',
    },
}

const csv = fs.readFileSync('items.csv', {encoding: 'utf8'});

const parsed = csvParse(csv, {
    columns: true,
});

let currentId = INITIAL_ID;
for (const x in parsed) {
    const row = parsed[x];

    if (!row['Item Name']) {
        continue;
    }

    let itemResult = "[" + currentId + "] = {\n    type = TYPE.EQUIPMENT,\n";
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
            if (value.toLowerCase() == 'all') {
                // Ignored
            } else {
                const allowedClasses = value.replace(/\s/g, "").split(',').map(x => {
                    if (x == 'Ta') {
                        return 'tarczaId';
                    } else if (x == 'Yu') {
                        return 'yujiId';
                    } else if (x == 'Az') {
                        return 'azoraId';
                    } else if (x == 'Iv') {
                        return 'ivanovId';
                    } else if (x == 'St') {
                        return 'stormfistId';
                    }
                }).join(',');
                itemResult += '    ' + column.name + ' = ' + '{' + allowedClasses + '},\n';
            }
        }

        const stat = STATS[y];
        if (stat && value) {
            if (stat.fn) {
                value = stat.fn(value);
            }
            stats += '        {\n            type = ' + stat.lua + ',\n            amount = ' + value + ',\n            tickrate = 5,\n        },\n';
        }
    }

    console.log(itemResult + '    stats = ' + stats + '    },\n},');

    currentId++;
}
