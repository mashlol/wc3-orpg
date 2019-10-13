local hero = require('src/hero.lua')
local effect = require('src/effect.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local combat = require('src/combat.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 120

local getSpellId = function()
    return 'hearthstone'
end

local getSpellName = function()
    return 'Return Stone'
end

local getSpellTooltip = function(playerId)
    return 'Return to town'
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

    local hero = hero.getHero(playerId)
    if combat.isInCombat(hero) then
        log.log(playerId, "You're in combat.", log.TYPE.ERROR)
        return false
    end

    local castSuccess = casttime.cast(playerId, 5, true)
    if not castSuccess then
        return false
    end
    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    effect.createEffect{
        model = "Abilities\\Spells\\Human\\DispelMagic\\DispelMagicTarget.mdl",
        unit = hero,
        duration = 0.5,
    }

    SetUnitPosition(hero, 4100, 3000)

    effect.createEffect{
        model = "Abilities\\Spells\\Human\\DispelMagic\\DispelMagicTarget.mdl",
        unit = hero,
        duration = 0.5,
    }

    if playerId == GetPlayerId(GetLocalPlayer()) then
        PanCameraToTimed(4100, 3000, 0)
    end

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
