local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 0.5

local cooldowns = {}

local cast = function(playerId)
    if
        cooldowns[playerId] ~= nil and
        TimerGetRemaining(cooldowns[playerId]) > 0.05
    then
        log.log(playerId, "Fireball is on cooldown!", log.TYPE.ERROR)
        return false
    end

    if cooldowns[playerId] ~= nil then
        DestroyTimer(cooldowns[playerId])
        cooldowns[playerId] = nil
    end


    local timer = CreateTimer()
    TimerStart(timer, COOLDOWN_S, false, nil)
    cooldowns[playerId] = timer

    local hero = hero.getHero(playerId)

    local heroV = vector.create(GetUnitX(hero), GetUnitY(hero))
    local mouseV = vector.create(
        mouse.getMouseX(playerId),
        mouse.getMouseY(playerId))

    IssueImmediateOrder(hero, "stop")
    SetUnitAnimationByIndex(hero, 4)

    SetUnitFacingTimed(
            hero,
            bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x),
            0.05)

    projectile.createProjectile{
        playerId = playerId,
        model = "eoil",
        fromV = heroV,
        toV = mouseV,
        speed = 900,
        length = 500,
        destroyOnCollide = true,
        onCollide = function(collidedUnit)
            UnitDamageTargetBJ(
                hero,
                collidedUnit,
                100,
                ATTACK_TYPE_PIERCE,
                DAMAGE_TYPE_UNKNOWN)
        end
    }

    return true
end

local getCooldown = function(playerId)
    if cooldowns[playerId] ~= nil then
        return TimerGetRemaining(cooldowns[playerId])
    end
    return 0
end

local getTotalCooldown = function()
    return COOLDOWN_S
end

return {
    cast = cast,
    getCooldown = getCooldown,
    getTotalCooldown = getTotalCooldown,
}
