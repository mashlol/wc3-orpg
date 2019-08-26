local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local animations = require('src/animations.lua')
local target = require('src/target.lua')
local casttime = require('src/casttime.lua')
local buff = require('src/buff.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 30

local getSpellId = function()
    return 'dampenpot'
end

local getSpellName = function()
    return 'Dampening Potion'
end

local getSpellTooltip = function(playerId)
    return 'Ivanov throws a potion that dampens an enemy target, increasing the damage they take by 20% for 5 seconds.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0.5
end

local cast = function(playerId)
    if cooldowns.isOnCooldown(playerId, getSpellId()) then
        log.log(playerId, getSpellName().." is on cooldown!", log.TYPE.ERROR)
        return false
    end

    local hero = hero.getHero(playerId)
    local target = target.getTarget(playerId)

    if target == nil then
        log.log(playerId, "You don't have a target!", log.TYPE.ERROR)
        return false
    end

    if IsUnitAlly(target, Player(playerId)) then
        log.log(playerId, "The target is friendly.", log.TYPE.ERROR)
        return
    end

    local heroV = Vector:new{x = GetUnitX(hero), y = GetUnitY(hero)}
    local targetV = Vector:new{x = GetUnitX(target), y = GetUnitY(target)}

    local dist = Vector:new(heroV):subtract(targetV)
    local mag = dist:magnitude()
    if mag > 800 then
        log.log(playerId, "Out of range!", log.TYPE.ERROR)
        return false
    end

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 3, 1)
    SetUnitFacingTimed(
        hero,
        bj_RADTODEG * Atan2(targetV.y - heroV.y, targetV.x - heroV.x),
        0.05)

    local castSuccess = casttime.cast(playerId, 0.5)
    if not castSuccess then
        return false
    end

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    projectile.createProjectile{
        playerId = playerId,
        model = "earm",
        fromV = heroV,
        destUnit = target,
        speed = 500,
        destroyOnCollide = false,
        onDestroy = function()
            buff.addBuff(hero, target, 'dampenpot', 5)
        end
    }

    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNLesserInvulneralbility.blp"
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
