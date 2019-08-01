local vector = require('src/vector.lua')

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

        if
            isCloseTo(curProjectileX, projectile.toX) and
            isCloseTo(curProjectileY, projectile.toY)
        then
            -- Already at destination, can finish
            RemoveUnit(projectile.unit)
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

local createProjectile = function(model, fromX, fromY, toX, toY, speed, length)
    if length ~= nil then
        local fromVector = vector.create(fromX, fromY)
        local toVector = vector.create(toX, toY)
        local totalVector = vector.subtract(toVector, fromVector)
        totalVector = vector.normalize(totalVector)
        totalVector = vector.multiply(totalVector, length)
        totalVector = vector.add(fromVector, totalVector)
        toX = totalVector.x
        toY = totalVector.y
    end

    local projectile = CreateUnit(
        Player(0),
        FourCC(model),
        fromX,
        fromY,
        bj_RADTODEG * Atan2(toY - fromY, toX - fromX))

    table.insert(projectiles, {
        unit = projectile,
        toX = toX,
        toY = toY,
        speed = speed,
    })

    return projectile
end

return {
    init = init,
    createProjectile = createProjectile,
}
