local hero = require('src/hero.lua')
local log = require('src/log.lua')
local animations = require('src/animations.lua')
local buff = require('src/buff.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 0.5

local getSpellId = function()
    return 'thunderlighting'
end

local getSpellName = function()
    return 'Thunder and Lightning'
end

local getSpellTooltip = function(playerId)
    return 'Toggle between Thunder and Lightning. With Thunder you deal 25% more damage on each hit, lightning increases your attack speed by 25%.'
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

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    animations.queueAnimation(hero, 17, 1)

    if buff.hasBuff(hero, 'thunder') then
        buff.removeBuff(hero, 'thunder')
        buff.addBuff(hero, hero, 'lightning', 36000)
    else
        buff.removeBuff(hero, 'lightning')
        buff.addBuff(hero, hero, 'thunder', 36000)
    end

    return true
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNMonsoon.blp"
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
