const STATS = {
    '% Move Speed': {
        lua: 'stats.PERCENT_MOVE_SPEED',
        fn: (x) => (x / 100) + 1,
    },
    '% Scale': {
        lua: 'stats.PERCENT_SCALE',
        fn: (x) => (x / 100) + 1,
    },
    'Raw HP': {
        lua: 'stats.RAW_HIT_POINTS',
    },
    'HP Regen': {
        lua: 'stats.HEALTH_REGEN',
    },
    'Attack Damage': {
        lua: 'stats.RAW_DAMAGE',
    },
    '% Attack Damage': {
        lua: 'stats.PERCENT_DAMAGE',
        fn: (x) => (x / 100) + 1,
    },
    'Spell Damage': {
        lua: 'stats.RAW_SPELL_DAMAGE',
    },
    '% Spell Damage': {
        lua: 'stats.PERCENT_SPELL_DAMAGE',
        fn: (x) => (x / 100) + 1,
    },
    'Healing': {
        lua: 'stats.RAW_HEALING',
    },
    '% Healing': {
        lua: 'stats.PERCENT_HEALING',
        fn: (x) => (x / 100) + 1,
    },
    '% Physical Damage Taken': {
        lua: 'stats.PERCENT_INCOMING_DAMAGE',
        fn: (x) => (x / 100) + 1,
    },
    '% Spell Damage Taken': {
        lua: 'stats.PERCENT_INCOMING_SPELL_DAMAGE',
        fn: (x) => (x / 100) + 1,
    },
    '% Healing Received': {
        lua: 'stats.PERCENT_ICOMING_HEALING',
        fn: (x) => (x / 100) + 1,
    },
    'Physical Damage Taken': {
        lua: 'stats.RAW_INCOMING_DAMAGE',
    },
    'Spell Damage Taken': {
        lua: 'stats.RAW_INCOMING_SPELL_DAMAGE',
    },
    'Healing Received': {
        lua: 'stats.RAW_INCOMING_HEALING',
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
        lua: 'stats.PERCENT_CRITICAL_DAMAGE',
        fn: (x) => (x / 100) + 1,
    }
};

const convertJson = function(parsedJson, COLUMNS, MAPPINGS) {
    let finalResult = "";
    for (const x in parsedJson) {
        const row = parsedJson[x];

        let rowResult = "[" + x + "] = {\n";
        for (const y in row) {
            const column = COLUMNS[y];
            let value = row[y];

            if (column && column.fn) {
                value = column.fn(value);
            }

            if (column && column.type === 'string') {
                rowResult += '    ' + column.name + " = [[" + value + "]],\n";
            } else if (column && column.type === 'mapping') {
                const result = MAPPINGS[column.mapping][value];
                rowResult += '    ' + column.name + " = " + result + ",\n";
            } else if (column && column.type === 'int') {
                if (!value) {
                    value = '0';
                }
                rowResult += '    ' + column.name + " = " + value + ",\n";
            } else if (column && column.type === 'sublist') {
                const subResult = convertJson(value, column.columns, column.mappings);
                rowResult += '    ' + column.name + ' = {\n' + subResult + '},\n';
            } else if (column && column.type === 'intlist') {
                rowResult += '    ' + column.name + ' = {' + value.join(',') + '},\n';
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
                    rowResult += '    ' + column.name + ' = ' + '{' + allowedClasses + '},\n';
                }
            } else if (column && column.type === 'statList') {
                const statList = value;
                let stats = "{\n";
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
                rowResult += '    stats = ' + stats + '    },\n';
            } else if (column && column.type === 'rewardList') {
                const rewardList = value;
                let rewards = "{\n";

                const exp = rewardList.exp;
                const gold = rewardList.gold;
                const items = rewardList.items;

                if (exp) {
                    rewards += '        exp = ' + exp + ',\n';
                }
                if (gold) {
                    rewards += '        gold = ' + gold + ',\n';
                }
                if (items) {
                    rewards += '        items = {\n';
                    for (const itemId in items) {
                        rewards += '            [' + itemId + '] = ' + items[itemId] + ',\n';
                    }
                    rewards += '        },\n';
                }

                rowResult += '    rewards = ' + rewards + '    },\n';
            }
        }

        finalResult += rowResult + '},\n';
    }

    return finalResult;
}


module.exports = convertJson;
