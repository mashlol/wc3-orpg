local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local collision = require('src/collision.lua')
local animations = require('src/animations.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 0.5
local COOLDOWN_S_LONG = 1.2

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
        log.log(playerId, "Slash is on cooldown!", log.TYPE.ERROR)
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

    if storedData[playerId] == nil then
        storedData[playerId] = {
            attackCount = -1,
        }
    end

    storedData[playerId].attackCount =
        (storedData[playerId].attackCount + 1) % 3

    local timer = CreateTimer()
    TimerStart(
        timer,
        storedData[playerId].attackCount == 2 and
            COOLDOWN_S_LONG or
            COOLDOWN_S, false,
        nil)
    cooldowns[playerId] = timer

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(
        hero,
        storedData[playerId].attackCount == 2 and
            3 or
            2,
        storedData[playerId].attackCount == 2 and
            1.5 or
            1)

    SetUnitFacing(
        hero,
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x))

    casttime.cast(
        playerId,
        storedData[playerId].attackCount == 2 and
            0.7 or
            0.2,
        false)

    local damage = storedData[playerId].attackCount == 2 and 300 or 50

    local facingVec = vector.fromAngle(
        Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x))
    facingVec = vector.multiply(facingVec, 50)
    facingVec = vector.add(facingVec, heroV)

    local collidedUnits = collision.getAllCollisions(facingVec, 100)
    for idx, unit in pairs(collidedUnits) do
        if IsUnitEnemy(unit, Player(playerId)) then
            UnitDamageTargetBJ(
                hero,
                unit,
                damage,
                ATTACK_TYPE_PIERCE,
                DAMAGE_TYPE_UNKNOWN)

            effect.createEffect{
                model = "ebld",
                x = facingVec.x,
                y = facingVec.y,
                duration = 0.1,
            }
        end
    end

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
    return "ReplaceableTextures\\CommandButtons\\BTNCleavingAttack.blp"
end

return {
    cast = cast,
    getCooldown = getCooldown,
    getTotalCooldown = getTotalCooldown,
    getIcon = getIcon,
}
