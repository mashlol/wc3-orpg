local projectiles = {}

local isCloseTo = function(val, expected)
    return val + 15 >= expected and val - 15 <= expected
end

local clearProjectiles = function()
    local toRemove = {}
    for idx, projectile in pairs(projectiles) do
        if
            isCloseTo(GetUnitX(projectile.unit), projectile.toX) and
            isCloseTo(GetUnitY(projectile.unit), projectile.toY)
        then
            RemoveUnit(projectile.unit)
            projectile.toRemove = true
        end
    end
    for idx, projectile in pairs(projectiles) do
        if projectile.toRemove then
            tables.remove(projectiles, idx)
        end
    end
end

local init = function()
    TimerStart(CreateTimer(), 0.1, true, clearProjectiles)
end

local createProjectile = function(model, fromX, fromY, toX, toY, length)
    local projectile = CreateUnit(
        Player(0),
        FourCC(model),
        fromX,
        fromY,
        bj_RADTODEG * Atan2(toY - fromY, toX - fromX))

    IssuePointOrder(projectile, "move", toX, toY)

    table.insert(projectiles, {
        unit = projectile,
        toX = toX,
        toY = toY,
    })

    return projectile
end

return {
    init = init,
    createProjectile = createProjectile,
}
