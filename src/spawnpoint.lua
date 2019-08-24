-- Spawnpoint module keeps track of all of the spawn points of creeps
local Vector = require('src/vector.lua')

-- spawnPoints = {
--     [0] = Vector:new{x = 0, y = 0},
-- }
local spawnPoints = {}

function getSpawnPoint(unit)
    return spawnPoints[GetUnitUserData(unit)]
end

function storeUnit()
    local unit = GetEnumUnit()

    if not BlzGetUnitBooleanField(unit, UNIT_BF_RAISABLE) then
        return
    end

    local unitId = #spawnPoints+1
    SetUnitUserData(unit, unitId)
    spawnPoints[unitId] = Vector:new{x = GetUnitX(unit), y = GetUnitY(unit)}
end

function init()
    ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), storeUnit)
end

return {
    init = init,
    getSpawnPoint = getSpawnPoint,
}
