local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local buff = require('src/buff.lua')
local casttime = require('src/casttime.lua')
local target = require('src/target.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local cooldowns = require('src/spells/cooldowns.lua')
local threat = require('src/threat.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 5

local getSpellId = function()
    return 'challenge'
end

local getSpellName = function()
    return 'Challenge'
end

local cast = function(playerId)
    if cooldowns.isOnCooldown(playerId, getSpellId()) then
        log.log(playerId, getSpellName().." is on cooldown!", log.TYPE.ERROR)
        return false
    end

    local hero = hero.getHero(playerId)
    local target = target.getTarget(playerId)
    local heroV = Vector:new{x = GetUnitX(hero), y = GetUnitY(hero)}
    local targetV = Vector:new{x = GetUnitX(target), y = GetUnitY(target)}

    if target == nil then
        log.log(playerId, "You have no target", log.TYPE.ERROR)
        return false
    end

    if IsUnitAlly(target, Player(playerId)) then
        log.log(playerId, "The target is friendly.", log.TYPE.ERROR)
        return
    end

    local dist = Vector:new(heroV):subtract(targetV)
    local mag = dist:magnitude()
    if mag > 800 then
        log.log(playerId, "Out of range!", log.TYPE.ERROR)
        return false
    end

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 9, 1)

    local facingAngle = bj_RADTODEG * Atan2(targetV.y - heroV.y, targetV.x - heroV.x)
    SetUnitFacing(hero, facingAngle)

    threat.addThreat(hero, target, 40000)

    casttime.cast(playerId, 0.1, false)

    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNDevourMagic.blp"
end

return {
    cast = cast,
    getSpellId = getSpellId,
    getSpellName = getSpellName,
    getIcon = getIcon,
}
