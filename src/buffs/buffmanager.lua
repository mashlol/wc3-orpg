local buff = require('src/buff.lua')

local ignite = require('src/buffs/ignite.lua')

function init()
    buff.registerBuff('ignite', ignite)
end

return {
    init = init,
}
