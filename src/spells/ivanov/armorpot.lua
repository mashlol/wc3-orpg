local hero = require('src/hero.lua')
local Vector = require('src/vector.lua')
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
    return 'armorpot'
end

local getSpellName = function()
    return 'Armor Potion'
end

local getSpellTooltip = function(playerId)
    return 'Ivanov tosses a potion of armor at an ally, reducing the damage they take by 30% and incresing the healing done to them by 30% for 10 seconds.'
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
        target = hero
    end

    if not IsUnitAlly(target, Player(playerId)) then
        target = hero
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
        model = "Abilities\\Weapons\\BrewmasterMissile\\BrewmasterMissile.mdl",
        height = 35,
        fromV = heroV,
        destUnit = target,
        speed = 500,
        destroyOnCollide = false,
        onDestroy = function()
            buff.addBuff(hero, target, 'armorpot', 10)
            buff.addBuff(hero, target, 'corrosivedecay', 300)
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
    return "ReplaceableTextures\\CommandButtons\\BTNPotionOfRestoration.blp"
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
