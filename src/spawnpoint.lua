-- Spawnpoint module keeps track of all of the spawn points of creeps
local Vector = require('src/vector.lua')

-- spawnPoints = {
--     [0] = {facing = 12, position = Vector:new{x = 0, y = 0}},
-- }
local spawnPoints = {}

function getSpawnPoint(unit)
    return spawnPoints[GetUnitUserData(unit)] and
        spawnPoints[GetUnitUserData(unit)].position
end

function getFacing(unit)
    return spawnPoints[GetUnitUserData(unit)] and
        spawnPoints[GetUnitUserData(unit)].facing
end

function storeUnit()
    local unit = GetEnumUnit()

    if GetOwningPlayer(unit) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE) then
        return
    end

    local unitId = #spawnPoints+1
    SetUnitUserData(unit, unitId)
    spawnPoints[unitId] = {
        position = Vector:new{x = GetUnitX(unit), y = GetUnitY(unit)},
        facing = GetUnitFacing(unit),
    }
end

function init()
    ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), storeUnit)
end

return {
    init = init,
    getSpawnPoint = getSpawnPoint,
    getFacing = getFacing,
}
