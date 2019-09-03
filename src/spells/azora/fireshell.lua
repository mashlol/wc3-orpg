local hero = require('src/hero.lua')
local log = require('src/log.lua')
local animations = require('src/animations.lua')
local buff = require('src/buff.lua')
local casttime = require('src/casttime.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 120

local getSpellId = function()
    return 'fireshell'
end

local getSpellName = function()
    return 'Fireshell'
end

local getSpellTooltip = function(playerId)
    return 'Azora summons a flame to surround her and protect her from incoming attacks for 10 seconds. She is unable do anything during this time.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0.1
end

local cast = function(playerId)
    if cooldowns.isOnCooldown(playerId, getSpellId()) then
        log.log(playerId, getSpellName().." is on cooldown!", log.TYPE.ERROR)
        return false
    end

    local hero = hero.getHero(playerId)
    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 4, 10)

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    casttime.cast(playerId, 0.1, false)

    buff.addBuff(hero, hero, 'fireshell', 10)

    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNCloakOfFlames.blp"
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
