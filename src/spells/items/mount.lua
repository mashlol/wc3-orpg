local hero = require('src/hero.lua')
local effect = require('src/effect.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local combat = require('src/combat.lua')
local buff = require('src/buff.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 1

local getSpellId = function()
    return 'mount'
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

    IssueImmediateOrder(hero, "stop")

    local castSuccess = casttime.cast(playerId, 1, true)
    if not castSuccess then
        return false
    end
    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    buff.addBuff(hero, hero, 'mount', 86400)

    return true
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNWindWalkOn.blp"
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
