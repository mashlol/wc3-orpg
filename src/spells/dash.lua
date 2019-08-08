local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 0.5
local COOLDOWN_S_LONG = 10

local cooldowns = {}
local storedData = {}

local isStuck = function(unit)
    return IsUnitType(unit, UNIT_TYPE_STUNNED) or
        IsUnitType(unit, UNIT_TYPE_SNARED) or
        IsUnitType(unit, UNIT_TYPE_POLYMORPHED)
end

local cast = function(playerId)
    if
        cooldowns[playerId] ~= nil and
        TimerGetRemaining(cooldowns[playerId]) > 0.05
    then
        log.log(playerId, "Dash is on cooldown!", log.TYPE.ERROR)
        return false
    end

    if cooldowns[playerId] ~= nil then
        DestroyTimer(cooldowns[playerId])
        cooldowns[playerId] = nil
    end

    local hero = hero.getHero(playerId)
    local heroV = vector.create(GetUnitX(hero), GetUnitY(hero))
    local mouseV = vector.create(
        mouse.getMouseX(playerId),
        mouse.getMouseY(playerId))

    if isStuck(hero) then
        log.log(playerId, "You can't move right now", log.TYPE.ERROR)
        return false
    end

    if storedData[playerId] == nil then
        storedData[playerId] = {
            attackCount = -1,
        }
    end

    storedData[playerId].attackCount =
        (storedData[playerId].attackCount + 1) % 2

    local timer = CreateTimer()
    TimerStart(
        timer,
        storedData[playerId].attackCount == 1 and
            COOLDOWN_S_LONG or
            COOLDOWN_S,
        false,
        nil)
    cooldowns[playerId] = timer

    IssueImmediateOrder(hero, "stop")
    SetUnitAnimationByIndex(hero, 8)

    SetUnitFacing(
        hero,
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x))

    projectile.createProjectile{
        playerId = playerId,
        model = "eoil",
        fromV = heroV,
        toV = mouseV,
        speed = 3000,
        length = 400,
        onCollide = function(collidedUnit)
            if IsUnitEnemy(collidedUnit, Player(playerId)) then
                UnitDamageTargetBJ(
                    hero,
                    collidedUnit,
                    200,
                    ATTACK_TYPE_PIERCE,
                    DAMAGE_TYPE_UNKNOWN)
            end
            return false
        end
    }

    casttime.cast(playerId, 0.15, false)

    local finalPos = vector.subtract(mouseV, heroV)
    finalPos = vector.normalize(finalPos)
    finalPos = vector.multiply(finalPos, 400)
    finalPos = vector.add(finalPos, heroV)
    SetUnitX(hero, finalPos.x)
    SetUnitY(hero, finalPos.y)
    SetUnitFacing(
        hero,
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x))

    return true
end

local getCooldown = function(playerId)
    if cooldowns[playerId] ~= nil then
        return TimerGetRemaining(cooldowns[playerId])
    end
    return 0
end

local getTotalCooldown = function(playerId)
    if cooldowns[playerId] ~= nil then
        return TimerGetTimeout(cooldowns[playerId])
    end
    return COOLDOWN_S
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNDizzy.blp"
end

return {
    cast = cast,
    getCooldown = getCooldown,
    getTotalCooldown = getTotalCooldown,
    getIcon = getIcon,
}
