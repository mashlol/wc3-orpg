local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 15

local cooldowns = {}

local cast = function(playerId)
    if
        cooldowns[playerId] ~= nil and
        TimerGetRemaining(cooldowns[playerId]) > 0.05
    then
        log.log(playerId, "Frost Nova is on cooldown!", log.TYPE.ERROR)
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

    local dist = vector.subtract(heroV, mouseV)
    local mag = vector.magnitude(dist)
    if mag > 800 then
        log.log(playerId, "Out of range!", log.TYPE.ERROR)
        return false
    end

    local timer = CreateTimer()
    TimerStart(timer, COOLDOWN_S, false, nil)
    cooldowns[playerId] = timer

    IssueImmediateOrder(hero, "stop")
    SetUnitAnimationByIndex(hero, 5)

    for i=0,360,20 do
        local toV = vector.fromAngle(bj_DEGTORAD * i)

        projectile.createProjectile{
            playerId = playerId,
            model = "efnv",
            fromV = mouseV,
            toV = vector.add(mouseV, toV),
            speed = 450,
            length = 250,
            onCollide = function(collidedUnit)
                if IsUnitEnemy(collidedUnit, playerId) then
                    local dummy = CreateUnit(
                        Player(playerId),
                        FourCC("hfoo"),
                        GetUnitX(collidedUnit),
                        GetUnitY(collidedUnit), 0)

                    effect.createEffect{
                        model = "efir",
                        unit = collidedUnit,
                        duration = 0.5,
                    }

                    ShowUnit(dummy, false)

                    UnitRemoveAbility(dummy, FourCC('Aatk'))
                    UnitAddAbility(dummy, FourCC('Aenr'))

                    IssueTargetOrder(dummy, "entanglingroots", collidedUnit)

                    UnitApplyTimedLifeBJ(2, FourCC('BTLF'), dummy)
                end
            end
        }
    end

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
