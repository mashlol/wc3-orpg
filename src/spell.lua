local fireball = require('src/spells/fireball.lua')
local slash = require('src/spells/slash.lua')
local dummy = require('src/spells/dummy.lua')
local frostnova = require('src/spells/frostnova.lua')
local frostorb = require('src/spells/frostorb.lua')
local blink = require('src/spells/blink.lua')
local heal = require('src/spells/heal.lua')

-- TODO base on hero or let people customize or w/e
local SPELL_MAP = {
    [1] = slash,
    [2] = frostnova,
    [3] = heal,
    [4] = frostorb,
    [8] = blink,
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

local getCooldownPct = function(playerId, idx)
    local spell = SPELL_MAP[idx]
    if spell ~= nil then
        return spell.getCooldown(playerId) / spell.getTotalCooldown(playerId)
    end
    return 0
end

return {
    castSpell = castSpell,
    getCooldown = getCooldown,
    getCooldownPct = getCooldownPct,
}
