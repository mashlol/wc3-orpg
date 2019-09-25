local hero = require('src/hero.lua')
local effect = require('src/effect.lua')
local log = require('src/log.lua')
local damage = require('src/damage.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 30

local getSpellId = function()
    return 'healpot1'
end

local getSpellName = function()
    return 'Healing Potion'
end

local getSpellTooltip = function(playerId)
    return 'Heal for 200 HP'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0
end

local cast = function(playerId)
    if cooldowns.isOnCooldown(playerId, getSpellId()) then
        log.log(playerId, getSpellName().." is on cooldown!", log.TYPE.ERROR)
        return false
    end

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    local hero = hero.getHero(playerId)

    effect.createEffect{
        model = "Abilities\\Spells\\Human\\Heal\\HealTarget.mdl",
        unit = hero,
        duration = 0.5,
        z = 35,
    }

    damage.heal(hero, hero, 200)

    return true
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNHealingWave.blp"
end

return {
    cast = cast,
    getSpellId = getSpellId,
    getSpellName = getSpellName,
    getIcon = getIcon,
    getSpellTooltip = getSpellTooltip,
    getSpellCooldown = getSpellCooldown,
    getSpellCasttime = getSpellCasttime,
}
