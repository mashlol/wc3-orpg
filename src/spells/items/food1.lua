local hero = require('src/hero.lua')
local combat = require('src/combat.lua')
local log = require('src/log.lua')
local buff = require('src/buff.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 2

local getSpellId = function()
    return 'food1'
end

local getSpellName = function()
    return 'Cheese'
end

local getSpellTooltip = function(playerId)
    return 'Eat to heal 60 HP per 3 seconds. Must be out of combat.'
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

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)
    buff.addBuff(hero, hero, 'food1', 30)

    return true
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\Cheese.blp"
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
