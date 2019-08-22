local buff = require('src/buff.lua')

local ignite = require('src/buffs/ignite.lua')
local corrosivedecay = require('src/buffs/corrosivedecay.lua')

function init()
    buff.registerBuff('ignite', ignite)
    buff.registerBuff('corrosivedecay', corrosivedecay)
end

return {
    init = init,
}
