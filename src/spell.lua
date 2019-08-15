-- Generic
local heal = require('src/spells/generic/heal.lua')

-- Azora
local fireball = require('src/spells/azora/fireball.lua')
local frostnova = require('src/spells/azora/frostnova.lua')
local frostorb = require('src/spells/azora/frostorb.lua')
local blink = require('src/spells/azora/blink.lua')

-- Yuji
local slash = require('src/spells/yuji/slash.lua')
local dash = require('src/spells/yuji/dash.lua')
local throwingstar = require('src/spells/yuji/throwingstar.lua')
local slashult = require('src/spells/yuji/slashult.lua')
local focus = require('src/spells/yuji/focus.lua')

-- Ivanov
local rejuvpot = require('src/spells/ivanov/rejuvpot.lua')
local armorpot = require('src/spells/ivanov/armorpot.lua')

local casttime = require('src/casttime.lua')
local hero = require('src/hero.lua')

local SPELL_MAP = {
    -- Generic
    heal = heal,

    -- Azora
    fireball = fireball,
    frostnova = frostnova,
    frostorb = frostorb,
    blink = blink,

    -- Yuji
    slash = slash,
    dash = dash,
    throwingstar = throwingstar,
    slashult = slashult,
    focus = focus,

    -- Ivanov
    rejuvpot = rejuvpot,
    armorpot = armorpot,
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

local getIcon = function(playerId, idx)
    local spell = getSpell(playerId, idx)
    if spell ~= nil then
        return spell.getIcon()
    end
    return ""
end

return {
    castSpell = castSpell,
    getCooldown = getCooldown,
    getCooldownPct = getCooldownPct,
    getIcon = getIcon,
}
