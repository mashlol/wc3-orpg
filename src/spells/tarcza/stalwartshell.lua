local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local collision = require('src/collision.lua')
local log = require('src/log.lua')
local buff = require('src/buff.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local threat = require('src/threat.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 10

local getSpellId = function()
    return 'stalwartshell'
end

local getSpellName = function()
    return 'Stalwart Shell'
end

local cast = function(playerId)
    if cooldowns.isOnCooldown(playerId, getSpellId()) then
        log.log(playerId, getSpellName().." is on cooldown!", log.TYPE.ERROR)
        return false
    end

    local hero = hero.getHero(playerId)

    local heroV = Vector:new{x = GetUnitX(hero), y = GetUnitY(hero)}
    local mouseV = Vector:new{
        x = mouse.getMouseX(playerId),
        y = mouse.getMouseY(playerId)
    }

    animations.queueAnimation(hero, 10, 1.5)

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    buff.addBuff(hero, hero, 'stalwartshell', 1.5)

    casttime.cast(playerId, 1.5, false)

    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNDefendStop.blp"
end

return {
    cast = cast,
    getSpellId = getSpellId,
    getSpellName = getSpellName,
    getIcon = getIcon,
}
