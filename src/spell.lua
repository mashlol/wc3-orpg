local fireball = require('src/spells/fireball.lua')
local dummy = require('src/spells/dummy.lua')

local castSpell = function(playerId, idx)
    if idx == 1 then
        return fireball.cast(playerId)
    end
    if idx == 2 then
        dummy.cast(playerId)
    end
end

local getCooldown = function(playerId, idx)
    if idx == 1 then
        return fireball.getCooldown(playerId)
    end
    if idx == 2 then
        return dummy.getCooldown(playerId)
    end
    return 0
end

return {
    castSpell = castSpell,
    getCooldown = getCooldown,
}
