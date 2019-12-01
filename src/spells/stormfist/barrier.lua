local hero = require('src/hero.lua')
local log = require('src/log.lua')
local animations = require('src/animations.lua')
local buff = require('src/buff.lua')
local casttime = require('src/casttime.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 14

local getSpellId = function()
    return 'barrier'
end

local getSpellName = function()
    return 'Thunder Barrier'
end

local getSpellTooltip = function(playerId)
    return 'The next two attacks against you within 5 seconds will deal no damage.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0.3
end

local cast = function(playerId)
    if cooldowns.isOnCooldown(playerId, getSpellId()) then
        log.log(playerId, getSpellName().." is on cooldown!", log.TYPE.ERROR)
        return false
    end

    local hero = hero.getHero(playerId)

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 17, 1)

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    casttime.cast(playerId, 0.3, false)

    buff.addBuff(hero, hero, 'thunderbarrier', 5)
    buff.addBuff(hero, hero, 'thunderbarrier', 5)

    return true
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNLightningShield.blp"
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
