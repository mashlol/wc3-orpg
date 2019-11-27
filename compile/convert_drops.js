// Script to read the items csv and convert to lua code for items

const fs = require('fs');
const convertJson = require('./convert_json');

const input = fs.readFileSync('../json/drops.json', {encoding: 'utf8'});
const parsed = JSON.parse(input);

let finalResult = '';

for (const key in parsed) {
    const value = parsed[key];


    finalResult += '[FourCC(\'' + key + '\')] = {\n';
    for (const itemId in value) {
        if (itemId === 'none') {
            finalResult += '    none = ' + value[itemId] + ',\n';
        } else {
            finalResult += '    [' + itemId  + '] = ' + value[itemId] + ',\n';
        }
    }

    finalResult += '},\n';
}

finalResult =
    'local DROPS = {\n' +
    finalResult +
    '}\n' +
    'return {DROPS = DROPS}';

fs.writeFileSync('../gen/items/droptable.lua', finalResult);
