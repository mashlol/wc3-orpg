local Vector = require('src/vector.lua')
local hero = require('src/hero.lua')
local collision = require('src/collision.lua')

local projectiles = {}
local timer

local isCloseTo = function(val, expected, range)
    return val + range >= expected and val - range <= expected
end

local destroyProjectile = function(projectile)
    if projectile.options.shouldRemove then
        if projectile.options.removeInsteadOfKill then
            RemoveUnit(projectile.unit)
        else
            KillUnit(projectile.unit)
        end
    end
    projectile.toRemove = true
    if projectile.options.onDestroy then
        projectile.options.onDestroy(projectile.unit)
    end
end

local getGoalV = function(options)
    if options.toV ~= nil then
        return Vector:new(options.toV)
    elseif options.destUnit ~= nil then
        return Vector:new{
            x = GetUnitX(options.destUnit),
            y = GetUnitY(options.destUnit),
        }
    else
        return Vector:fromAngle(options.toAngle)
            :multiply(options.toRadius)
            :add(options.fromV)
    end
end

local isAtFinalRotation = function(projectile)
    local curProjectileX = GetUnitX(projectile.unit)
    local curProjectileY = GetUnitY(projectile.unit)

    local projectileV = Vector:new{x = curProjectileX, y = curProjectileY}
    local curVec = Vector:new(projectileV)
        :subtract(projectile.options.fromV)
    local curRadius = curVec:magnitude()
    return projectile.options.toRadius ~=  projectile.options.fromRadius and
        isCloseTo(curRadius, projectile.options.toRadius, 5)
end

local clearProjectiles = function()
    local elapsedTime = TimerGetElapsed(timer)

    for idx, projectile in pairs(projectiles) do
        local curProjectileX = GetUnitX(projectile.unit)
        local curProjectileY = GetUnitY(projectile.unit)

        local projectileV = Vector:new{x = curProjectileX, y = curProjectileY}
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
            isCloseTo(curProjectileX, goalV.x, 15) and
            isCloseTo(curProjectileY, goalV.y, 15) or
            isAtFinalRotation(projectile)
        then
            -- Already at destination, can finish
            destroyProjectile(projectile)
        else
            local newPos
            local facingRad
            if projectile.options.fromAngle ~= nil then
                -- Rotation projectile
                local curVec = Vector:new(projectileV)
                    :subtract(projectile.options.fromV)
                local curRotation = curVec:angle()
                local curRadius = curVec:magnitude()

                local newRotation = curRotation +
                    (projectile.options.speed * (projectile.options.toAngle - projectile.options.fromAngle)) / (2 * math.pi * curRadius) *
                    elapsedTime

                local newRadius = curRadius +
                    ((projectile.options.toRadius - projectile.options.fromRadius) / ((2 * math.pi * curRadius) / (projectile.options.speed)))  *
                    elapsedTime

                newPos = Vector:fromAngle(newRotation)
                    :multiply(newRadius)
                    :add(projectile.options.fromV)

                facingRad = newRotation + math.pi / 2 * projectile.options.angleDir
            else
                -- Linear projectile
                local distVector = Vector:new(goalV):subtract(projectileV)

                newPos = Vector:new(distVector)
                    :normalize()
                    :multiply(projectile.options.speed * elapsedTime)

                if newPos:magnitude() >= distVector:magnitude() then
                    newPos = distVector
                end

                newPos:add(projectileV)

                facingRad = Atan2(
                    goalV.y - projectile.options.fromV.y,
                    goalV.x - projectile.options.fromV.x)
            end
            SetUnitFacing(projectile.unit, bj_RADTODEG * facingRad)
            SetUnitPosition(projectile.unit, newPos.x, newPos.y)
            if projectile.options.onMove then
                projectile.options.onMove(newPos.x, newPos.y)
            end
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
        local lengthNormalizedV = Vector:new(goalV)
            :subtract(options.fromV)
            :normalize()
            :multiply(options.length)
            :add(options.fromV)
        goalV = lengthNormalizedV
        options.toV = goalV
    end

    if options.projectile == nil then
        local startV
        if options.fromAngle ~= nil and options.fromRadius ~= nil then
            startV = Vector:fromAngle(options.fromAngle)
                :multiply(options.fromRadius)
                :add(options.fromV)

            options.radiusDir = options.fromRadius > options.toRadius and -1 or 1
            options.angleDir = options.fromAngle > options.toAngle and -1 or 1
        else
            startV = Vector:new(options.fromV)
        end
        options.projectile = CreateUnit(
            Player(PLAYER_NEUTRAL_PASSIVE),
            FourCC(options.model),
            startV.x,
            startV.y,
            bj_RADTODEG * Atan2(goalV.y - options.fromV.y, goalV.x - options.fromV.x))
        options.shouldRemove = true
    else
        options.shouldRemove = false
    end

    table.insert(projectiles, {
        unit = options.projectile,
        options = options,
        alreadyCollided = {}
    })

    return options.projectile
end

return {
    init = init,
    createProjectile = createProjectile,
}
