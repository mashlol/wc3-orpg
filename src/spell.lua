local fireball = require('src/spells/fireball.lua')
local slash = require('src/spells/slash.lua')
local dash = require('src/spells/dash.lua')
local throwingstar = require('src/spells/throwingstar.lua')
local slashult = require('src/spells/slashult.lua')
local dummy = require('src/spells/dummy.lua')
local frostnova = require('src/spells/frostnova.lua')
local frostorb = require('src/spells/frostorb.lua')
local blink = require('src/spells/blink.lua')
local heal = require('src/spells/heal.lua')

local casttime = require('src/casttime.lua')
local hero = require('src/hero.lua')

local SPELL_MAP = {
    slash = slash,
    throwingstar = throwingstar,
    dash = dash,
    slashult = slashult,
    fireball = fireball,
    frostnova = frostnova,
    heal = heal,
    frostorb = frostorb,
    blink = blink,
}

local getSpell = function(playerId, idx)
    local pickedHero = hero.getPickedHero(playerId)
    if pickedHero == nil then
        return nil
    end
    return SPELL_MAP[pickedHero.spells[idx]]
end

local castSpell = function(playerId, idx)
    local isCasting = casttime.isCasting(playerId)

    if isCasting then
        return
    end

    if GetUnitState(hero.getHero(playerId), UNIT_STATE_LIFE) <= 0 then
        return
    end

    local spell = getSpell(playerId, idx)
    if spell ~= nil then
        spell.cast(playerId)
    end
end

local getCooldown = function(playerId, idx)
    local spell = getSpell(playerId, idx)
    if spell ~= nil then
        return spell.getCooldown(playerId)
    end
    return 0
end

local getCooldownPct = function(playerId, idx)
    local spell = getSpell(playerId, idx)
    if spell ~= nil and spell.getTotalCooldown(playerId) ~= 0 then
        return spell.getCooldown(playerId) / spell.getTotalCooldown(playerId)
    end
    return 1
end

return {
    castSpell = castSpell,
    getCooldown = getCooldown,
    getCooldownPct = getCooldownPct,
}
