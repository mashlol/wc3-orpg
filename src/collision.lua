local Vector = require('src/vector2.lua')

function isCollided(unit, vec, radius)
    vec = Vector:new(vec)
    local collisionSize = BlzGetUnitCollisionSize(unit)
    local unitV = Vector:new{x = GetUnitX(unit), y = GetUnitY(unit)}
    local collisionDist = Vector:new(vec):subtract(unitV)
    if collisionDist:magnitude() <= collisionSize then
        return true
    end
    local mag = collisionDist:normalize()
        :multiply(collisionSize)
        :add(unitV)
        :multiply(-1)
        :add(vec)
        :magnitude()

    return mag <= radius
end

function getAllCollisions(vec, radius)
    -- Loop through all nearby units
    -- Check they are alive
    -- Check they aren't hidden
    -- TODO Check they aren't an effect unit
    -- Check they are coliding with the vector/radius

    local loc = Location(vec.x, vec.y)
    local grp = GetUnitsInRangeOfLocAll(1000, loc)
    local toReturn = {}
    ForGroupBJ(grp, function()
        local collidedUnit = GetEnumUnit()
        if
            GetUnitState(collidedUnit, UNIT_STATE_LIFE) > 0 and
            not IsUnitHidden(collidedUnit) and
            isCollided(collidedUnit, vec, radius)
        then
            table.insert(toReturn, collidedUnit)
        end
    end)

    RemoveLocation(loc)

    return toReturn
end


return {
    getAllCollisions = getAllCollisions,
    isCollided = isCollided,
}
