local Vector = require('src/vector.lua')
local hero = require('src/hero.lua')
local collision = require('src/collision.lua')

local projectiles = {}
local timer

local sharedLocationObj = Location(0, 0)

local isCloseTo = function(val, expected, range)
    return val + range >= expected and val - range <= expected
end

local destroyProjectile = function(projectile)
    if projectile.options.shouldRemove then
        if projectile.options.removeInsteadOfKill then
            if projectile.unit then
                RemoveUnit(projectile.unit)
            else
                BlzSetSpecialEffectPosition(
                    projectile.effect, -30000, -30000, -30000)
                DestroyEffect(projectile.effect)
            end
        else
            if projectile.unit then
                KillUnit(projectile.unit)
            else
                DestroyEffect(projectile.effect)
            end
        end
    end
    projectile.toRemove = true
    if projectile.options.onDestroy then
        projectile.options.onDestroy(projectile)
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
        local origin = options.fromUnit and
            Vector:new{
                x = GetUnitX(options.fromUnit),
                y = GetUnitY(options.fromUnit)} or
            options.fromV
        return Vector:fromAngle(options.toAngle)
            :multiply(options.toRadius)
            :add(origin)
    end
end

local isAtFinalRotation = function(projectile)
    local curProjectileX = projectile.x
    local curProjectileY = projectile.y

    local projectileV = Vector:new{x = curProjectileX, y = curProjectileY}
    local curVec = Vector:new(projectileV)
        :subtract(projectile.options.fromV)
    local curRadius = curVec:magnitude()
    return projectile.options.toRadius ~= projectile.options.fromRadius and
        isCloseTo(curRadius, projectile.options.toRadius, 5)
end

local clearProjectiles = function()
    local elapsedTime = TimerGetElapsed(timer)

    for _, projectile in pairs(projectiles) do
        -- TODO extensive testing to see if this can desync
        local curProjectileX = projectile.x
        local curProjectileY = projectile.y

        local projectileV = Vector:new{x = curProjectileX, y = curProjectileY}
        local ownerHero = hero.getHero(projectile.options.playerId)
        if projectile.options.radius ~= 0 then
            local collidedUnits, collidedDoodads = collision.getAllCollisions(
                projectileV,
                projectile.options.radius or 50)
            for _, collidedUnit in pairs(collidedUnits) do
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
            for _, doodad in pairs(collidedDoodads) do
                if
                    projectile.toRemove ~= true and
                    projectile.alreadyCollided[GetHandleId(doodad)] ~= true
                then
                    projectile.alreadyCollided[GetHandleId(doodad)] = true
                    local destroyOnCollide = false
                    if projectile.options.onDoodadCollide then
                        destroyOnCollide = projectile.options.onDoodadCollide(
                            doodad)
                    end
                    if destroyOnCollide then
                        destroyProjectile(projectile)
                    end
                end
            end
        end

        local goalV = getGoalV(projectile.options)
        if projectile.toRemove then
            -- do nothing
        elseif
            not projectile.options.permanent and
            (isCloseTo(curProjectileX, goalV.x, 15) and
            isCloseTo(curProjectileY, goalV.y, 15) or
            isAtFinalRotation(projectile))
        then
            -- Already at destination, can finish
            destroyProjectile(projectile)
        else
            local newPos
            local facingRad
            if projectile.options.fromAngle ~= nil then
                -- Rotation projectile
                local origin = projectile.options.fromUnit and
                    Vector:new{
                        x = GetUnitX(projectile.options.fromUnit),
                        y = GetUnitY(projectile.options.fromUnit)} or
                    projectile.options.fromV

                local curRotation = projectile.curRotation
                local curRadius = projectile.curRadius

                local newRotation = curRotation +
                    (projectile.options.speed * (projectile.options.toAngle - projectile.options.fromAngle)) / (2 * math.pi * curRadius) *
                    elapsedTime

                local newRadius = curRadius +
                    ((projectile.options.toRadius - projectile.options.fromRadius) / ((2 * math.pi * curRadius) / (projectile.options.speed)))  *
                    elapsedTime

                projectile.curRadius = newRadius
                projectile.curRotation = newRotation

                newPos = Vector:fromAngle(newRotation)
                    :multiply(newRadius)
                    :add(origin)

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
            if projectile.unit ~= nil then
                SetUnitFacing(projectile.unit, bj_RADTODEG * facingRad)
                SetUnitX(projectile.unit, newPos.x)
                SetUnitY(projectile.unit, newPos.y)
            else
                BlzSetSpecialEffectYaw(projectile.effect, facingRad)
                MoveLocation(sharedLocationObj, newPos.x, newPos.y)
                BlzSetSpecialEffectPosition(
                    projectile.effect,
                    newPos.x,
                    newPos.y,
                    GetLocationZ(sharedLocationObj) +
                        (projectile.options.z or 0))
            end
            projectile.x = newPos.x
            projectile.y = newPos.y
            if projectile.options.onMove then
                projectile.options.onMove(newPos.x, newPos.y)
            end
            if projectile.options.acceleration then
                projectile.options.speed = projectile.options.speed +
                    projectile.options.acceleration *
                    elapsedTime
            end
            if projectile.options.visionRadius then
                SetFogStateRadius(
                    Player(projectile.options.playerId),
                    FOG_OF_WAR_VISIBLE,
                    newPos.x,
                    newPos.y,
                    projectile.options.visionRadius,
                    false)
            end
            if
                projectile.options.cameraFollow and
                projectile.options.playerId == GetPlayerId(GetLocalPlayer())
            then
                PanCameraToTimed(
                    newPos.x, newPos.y + (projectile.options.z or 0) / 2, 0)
            end
        end
    end
    local newProjectiles = {}
    for _, projectile in pairs(projectiles) do
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

    local startV
    local origin = options.fromUnit and
        Vector:new{
            x = GetUnitX(options.fromUnit),
            y = GetUnitY(options.fromUnit)} or
        options.fromV

    local unitToProject = nil
    local effectToProject = nil
    if options.projectile == nil then
        local startFacing
        if options.fromAngle ~= nil and options.fromRadius ~= nil then
            startV = Vector:fromAngle(options.fromAngle)
                :multiply(options.fromRadius)
                :add(origin)

            options.radiusDir = options.fromRadius > options.toRadius and
                -1 or
                1
            options.angleDir = options.fromAngle > options.toAngle and -1 or 1
            startFacing = options.fromAngle + math.pi / 2 * options.angleDir
        else
            startV = Vector:new(origin)
            startFacing = Atan2(goalV.y - origin.y, goalV.x - origin.x)
        end
        options.projectile = AddSpecialEffect(options.model, startV.x, startV.y)
        BlzSetSpecialEffectYaw(options.projectile, bj_RADTODEG * startFacing)
        if options.scale then
            BlzSetSpecialEffectScale(options.projectile, options.scale)
        end
        if options.pitch then
            BlzSetSpecialEffectPitch(options.projectile, options.pitch)
        end
        if options.roll then
            BlzSetSpecialEffectRoll(options.projectile, options.roll)
        end
        options.shouldRemove = true
        effectToProject = options.projectile
    else
        startV = Vector:new(origin)
        options.shouldRemove = false
        unitToProject = options.projectile
    end

    local proj = {
        unit = unitToProject,
        effect = effectToProject,
        x = startV.x,
        y = startV.y,
        options = options,
        alreadyCollided = {},
        curRadius = options.fromRadius,
        curRotation = options.fromAngle,
    }
    table.insert(projectiles, proj)

    return proj
end

return {
    init = init,
    createProjectile = createProjectile,
    destroyProjectile = destroyProjectile,
}
