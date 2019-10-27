local buff = require('src/buff.lua')

local ignite = require('src/buffs/ignite.lua')
local corrosivedecay = require('src/buffs/corrosivedecay.lua')
local lightninggauntlet = require('src/buffs/lightninggauntlet.lua')

function init()
    buff.registerBuff('ignite', ignite)
    buff.registerBuff('corrosivedecay', corrosivedecay)
    buff.registerBuff('lightninggauntlet', lightninggauntlet)
end

return {
    init = init,
}
