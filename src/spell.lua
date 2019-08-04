local fireball = require('src/spells/fireball.lua')
local dummy = require('src/spells/dummy.lua')

-- TODO base on hero or let people customize or w/e
local SPELL_MAP = {
    [1] = fireball,
    [2] = dummy,
}

local castSpell = function(playerId, idx)
    local spell = SPELL_MAP[idx]
    if spell ~= nil then
        spell.cast(playerId)
    end
end

local getCooldown = function(playerId, idx)
    local spell = SPELL_MAP[idx]
    if spell ~= nil then
        return spell.getCooldown(playerId)
    end
    return 0
end

return {
    castSpell = castSpell,
    getCooldown = getCooldown,
}
