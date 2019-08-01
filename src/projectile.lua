local vector = require('src/vector.lua')
local hero = require('src/hero.lua')

local projectiles = {}
local timer

local isCloseTo = function(val, expected)
    return val + 15 >= expected and val - 15 <= expected
end

local clearProjectiles = function()
    local elapsedTime = TimerGetElapsed(timer)

    local toRemove = {}
    for idx, projectile in pairs(projectiles) do
        local curProjectileX = GetUnitX(projectile.unit)
        local curProjectileY = GetUnitY(projectile.unit)

        local grp = GetUnitsInRangeOfLocAll(50, GetUnitLoc(projectile.unit))
        ForGroupBJ(grp, function()
            local ownerHero = hero.getHero(projectile.playerId)
            local collidedUnit = GetEnumUnit()
            if
                collidedUnit ~= ownerHero and
                GetUnitState(collidedUnit, UNIT_STATE_LIFE) > 0
            then
                UnitDamageTargetBJ(
                    ownerHero,
                    collidedUnit,
                    100,
                    ATTACK_TYPE_PIERCE,
                    DAMAGE_TYPE_UNKNOWN)
                KillUnit(projectile.unit)
                projectile.toRemove = true
            end
        end)

        if projectile.toRemove then

        elseif
            isCloseTo(curProjectileX, projectile.toX) and
            isCloseTo(curProjectileY, projectile.toY)
        then
            -- Already at destination, can finish
            KillUnit(projectile.unit)
            projectile.toRemove = true
        else
            -- Move toward destination at speed
            local totalDistX = projectile.toX - curProjectileX
            local totalDistY = projectile.toY - curProjectileY

            local distVector = vector.create(totalDistX, totalDistY)

            local v1 = vector.normalize(distVector)
            v1 = vector.multiply(v1, projectile.speed * elapsedTime)

            if vector.magnitude(v1) >= vector.magnitude(distVector) then
                v1 = distVector
            end

            v1 = vector.add(
                v1,
                vector.create(curProjectileX, curProjectileY))

            SetUnitX(projectile.unit, v1.x)
            SetUnitY(projectile.unit, v1.y)
        end
    end
    for idx, projectile in pairs(projectiles) do
        if projectile.toRemove then
            tables.remove(projectiles, idx)
        end
    end
end

local init = function()
    timer = CreateTimer()
    TimerStart(timer, 0.03125, true, clearProjectiles)
end

local createProjectile = function(playerId, model, fromV, toV, speed, length)
    if length ~= nil then
        local lengthNormalizedV = vector.subtract(toV, fromV)
        lengthNormalizedV = vector.normalize(lengthNormalizedV)
        lengthNormalizedV = vector.multiply(lengthNormalizedV, length)
        lengthNormalizedV = vector.add(fromV, lengthNormalizedV)
        toV = lengthNormalizedV
    end

    local projectile = CreateUnit(
        Player(0),
        FourCC(model),
        fromV.x,
        fromV.y,
        bj_RADTODEG * Atan2(toV.y - fromV.y, toV.x - fromV.x))

    table.insert(projectiles, {
        unit = projectile,
        toX = toV.x,
        toY = toV.y,
        speed = speed,
        playerId = playerId,
    })

    return projectile
end

return {
    init = init,
    createProjectile = createProjectile,
}
