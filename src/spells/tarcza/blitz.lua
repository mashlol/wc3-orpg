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

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 0.5
local COOLDOWN_S_LONG = 10

local storedData = {}

local isStuck = function(unit)
    return IsUnitType(unit, UNIT_TYPE_STUNNED) or
        IsUnitType(unit, UNIT_TYPE_SNARED) or
        IsUnitType(unit, UNIT_TYPE_POLYMORPHED) or
        IsUnitPaused(unit)
end

local getSpellId = function()
    return 'blitz'
end

local getSpellName = function()
    return 'Blitz / Assist'
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

    if isStuck(hero) then
        log.log(playerId, "You can't move right now", log.TYPE.ERROR)
        return false
    end

    local dist = Vector:new(heroV):subtract(targetV)
    local mag = dist:magnitude()
    if mag > 800 then
        log.log(playerId, "Out of range!", log.TYPE.ERROR)
        return false
    end

    if storedData[playerId] == nil then
        storedData[playerId] = {
            attackCount = -1,
        }
    end

    storedData[playerId].attackCount =
        (storedData[playerId].attackCount + 1) % 2

    cooldowns.startCooldown(
        playerId,
        getSpellId(),
        storedData[playerId].attackCount == 1 and
            COOLDOWN_S_LONG or
            COOLDOWN_S)

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 12, 2)

    local facingAngle = bj_RADTODEG * Atan2(targetV.y - heroV.y, targetV.x - heroV.x)
    SetUnitFacing(hero, facingAngle)

    if IsUnitAlly(target, Player(playerId)) then
        projectile.createProjectile{
            playerId = playerId,
            model = "eshr",
            fromV = heroV,
            destUnit = target,
            speed = 1010,
        }
    else
        projectile.createProjectile{
            playerId = playerId,
            model = "eshe",
            fromV = heroV,
            destUnit = target,
            speed = 1010,
        }
    end

    projectile.createProjectile{
        playerId = playerId,
        projectile = hero,
        fromV = heroV,
        destUnit = target,
        speed = 1000,
        onDestroy = function()
            -- TODO if target is ally, do buff, if enemy do damage
            if IsUnitAlly(target, Player(playerId)) then
                buff.addBuff(hero, target, 'assist', 2)
            else
                damage.dealDamage(hero, target, 40)
                buff.addBuff(hero, target, 'stun', 2)
            end
            casttime.stopCast(playerId)
            animations.queueAnimation(hero, 3, 0.6)
        end,
    }

    casttime.cast(playerId, 0.6, false)

    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNCleavingAttack.blp"
end

return {
    cast = cast,
    getSpellId = getSpellId,
    getSpellName = getSpellName,
    getIcon = getIcon,
}
