// Script to read the items csv and convert to lua code for items

const fs = require('fs');
const convertJson = require('./convert_json');

const input = fs.readFileSync('../json/vendors.json', {encoding: 'utf8'});
const parsed = JSON.parse(input);

let finalResult = '';

for (const key in parsed) {
    const value = parsed[key];

    finalResult += '[GetHandleId(' + key + ')] = {\n    unit = ' + key + ',\n';
    finalResult += '    items = {' + value.join(',') + '},\n';
    finalResult += '},\n';
}

finalResult =
    'function getVendors()\nreturn {\n' +
    finalResult +
    '}\nend\n' +
    'return {getVendors = getVendors}';

fs.writeFileSync('../gen/items/vendorlist.lua', finalResult);
