local vector = require('src/vector.lua')
local hero = require('src/hero.lua')

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

local clearProjectiles = function()
    local elapsedTime = TimerGetElapsed(timer)

    for idx, projectile in pairs(projectiles) do
        local curProjectileX = GetUnitX(projectile.unit)
        local curProjectileY = GetUnitY(projectile.unit)

        local grp = GetUnitsInRangeOfLocAll(800, GetUnitLoc(projectile.unit))
        ForGroupBJ(grp, function()
            local ownerHero = hero.getHero(projectile.options.playerId)
            local collidedUnit = GetEnumUnit()
            if
                collidedUnit ~= ownerHero and
                GetUnitState(collidedUnit, UNIT_STATE_LIFE) > 0 and
                projectile.toRemove ~= true and
                projectile.alreadyCollided[GetHandleId(collidedUnit)] ~= true
            then
                local collisionSize = BlzGetUnitCollisionSize(collidedUnit)
                local projectileV = vector.create(curProjectileX, curProjectileY)
                local collidedV = vector.create(
                    GetUnitX(collidedUnit), GetUnitY(collidedUnit))
                local collisionDist = vector.subtract(projectileV, collidedV)
                collisionDist = vector.normalize(collisionDist)
                collisionDist = vector.multiply(collisionDist, collisionSize)
                collisionDist = vector.add(collisionDist, collidedV)
                collisionDist = vector.subtract(projectileV, collisionDist)
                collisionDist = vector.magnitude(collisionDist)

                if collisionDist <= 50 then
                    projectile.alreadyCollided[GetHandleId(collidedUnit)] = true
                    if projectile.options.onCollide then
                        projectile.options.onCollide(collidedUnit)
                    end
                    if projectile.options.destroyOnCollide then
                        destroyProjectile(projectile)
                    end
                end
            end
        end)

        if projectile.toRemove then
            -- do nothing
        elseif
            isCloseTo(curProjectileX, projectile.options.toV.x) and
            isCloseTo(curProjectileY, projectile.options.toV.y)
        then
            -- Already at destination, can finish
            destroyProjectile(projectile)
        else
            -- Move toward destination at speed
            local totalDistX = projectile.options.toV.x - curProjectileX
            local totalDistY = projectile.options.toV.y - curProjectileY

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
    TimerStart(timer, 0.03125, true, clearProjectiles)
end

local createProjectile = function(options)
    if options.length ~= nil then
        local lengthNormalizedV = vector.subtract(options.toV, options.fromV)
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
        bj_RADTODEG * Atan2(options.toV.y - options.fromV.y, options.toV.x - options.fromV.x))

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
