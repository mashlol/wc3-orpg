local vector = require('src/vector.lua')
local hero = require('src/hero.lua')
local collision = require('src/collision.lua')

local projectiles = {}
local timer

local isCloseTo = function(val, expected)
    return val + 15 >= expected and val - 15 <= expected
end

local destroyProjectile = function(projectile)
    KillUnit(projectile.unit)
    projectile.toRemove = true
    if projectile.options.onDestroy then
        projectile.options.onDestroy()
    end
end

local getGoalV = function(options)
    if options.toV ~= nil then
        return options.toV
    else
        return vector.create(
            GetUnitX(options.destUnit),
            GetUnitY(options.destUnit))
    end
end

local clearProjectiles = function()
    local elapsedTime = TimerGetElapsed(timer)

    for idx, projectile in pairs(projectiles) do
        local curProjectileX = GetUnitX(projectile.unit)
        local curProjectileY = GetUnitY(projectile.unit)

        local projectileV = vector.create(curProjectileX, curProjectileY)
        local ownerHero = hero.getHero(projectile.options.playerId)
        local collidedUnits = collision.getAllCollisions(
            projectileV,
            projectile.options.radius or 50)
        for idx, collidedUnit in pairs(collidedUnits) do
            if
                collidedUnit ~= ownerHero and
                projectile.toRemove ~= true and
                projectile.alreadyCollided[GetHandleId(collidedUnit)] ~= true
            then
                projectile.alreadyCollided[GetHandleId(collidedUnit)] = true
                local destroyOnCollide = false
                if projectile.options.onCollide then
                    destroyOnCollide = projectile.options.onCollide(
                        collidedUnit)
                end
                if destroyOnCollide then
                    destroyProjectile(projectile)
                end
            end
        end

        local goalV = getGoalV(projectile.options)
        if projectile.toRemove then
            -- do nothing
        elseif
            isCloseTo(curProjectileX, goalV.x) and
            isCloseTo(curProjectileY, goalV.y)
        then
            -- Already at destination, can finish
            destroyProjectile(projectile)
        else
            -- Move toward destination at speed
            local totalDistX = goalV.x - curProjectileX
            local totalDistY = goalV.y - curProjectileY

            local distVector = vector.create(totalDistX, totalDistY)

            local deltaV = vector.normalize(distVector)
            deltaV = vector.multiply(
                deltaV,
                projectile.options.speed * elapsedTime)

            if vector.magnitude(deltaV) >= vector.magnitude(distVector) then
                deltaV = distVector
            end

            deltaV = vector.add(
                deltaV,
                vector.create(curProjectileX, curProjectileY))

            SetUnitX(projectile.unit, deltaV.x)
            SetUnitY(projectile.unit, deltaV.y)
        end
    end
    local newProjectiles = {}
    for idx, projectile in pairs(projectiles) do
        if projectile ~= nil and projectile.toRemove ~= true then
            table.insert(newProjectiles, projectile)
        end
    end
    projectiles = newProjectiles
end

local init = function()
    timer = CreateTimer()
    TimerStart(timer, 0.0078125, true, clearProjectiles)
end

local createProjectile = function(options)
    local goalV = getGoalV(options)
    if options.length ~= nil then
        local lengthNormalizedV = vector.subtract(goalV, options.fromV)
        lengthNormalizedV = vector.normalize(lengthNormalizedV)
        lengthNormalizedV = vector.multiply(lengthNormalizedV, options.length)
        lengthNormalizedV = vector.add(options.fromV, lengthNormalizedV)
        options.toV = lengthNormalizedV
    end

    local projectile = CreateUnit(
        Player(24),
        FourCC(options.model),
        options.fromV.x,
        options.fromV.y,
        bj_RADTODEG * Atan2(goalV.y - options.fromV.y, goalV.x - options.fromV.x))

    table.insert(projectiles, {
        unit = projectile,
        options = options,
        alreadyCollided = {}
    })

    return projectile
end

return {
    init = init,
    createProjectile = createProjectile,
}
