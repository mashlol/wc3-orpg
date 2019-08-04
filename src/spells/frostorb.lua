local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 160

local cooldowns = {}

local cast = function(playerId)
    if
        cooldowns[playerId] ~= nil and
        TimerGetRemaining(cooldowns[playerId]) > 0.05
    then
        print("Frost Orb is on cooldown!")
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

    IssueImmediateOrder(hero, "stop")
    SetUnitAnimationByIndex(hero, 7)

    for x=0,30,10 do
        for i=x,360+x,40 do
            local toV = vector.fromAngle(bj_DEGTORAD * i)

            projectile.createProjectile{
                playerId = playerId,
                model = "efor",
                fromV = mouseV,
                toV = vector.add(mouseV, toV),
                speed = 300,
                length = 350,
                destroyOnCollide = true,
                onCollide = function(collidedUnit)
                    UnitDamageTargetBJ(
                        hero,
                        collidedUnit,
                        500,
                        ATTACK_TYPE_PIERCE,
                        DAMAGE_TYPE_UNKNOWN)
                end
            }
        end
        TriggerSleepAction(0.03)
    end

    local timer = CreateTimer()
    TimerStart(timer, COOLDOWN_S, false, nil)
    cooldowns[playerId] = timer

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
