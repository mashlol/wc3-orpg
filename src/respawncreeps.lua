local spawnpoint = require('src/spawnpoint.lua')

local clearDeadUnits = function()
    local unit = GetTriggerUnit()
    local spawnV = spawnpoint.getSpawnPoint(unit)
    local facing = spawnpoint.getFacing(unit)
    local unitId = GetUnitUserData(unit)
    local unitType = GetUnitTypeId(unit)

    if spawnV and facing then
        TriggerSleepAction(30)

        local newUnit = CreateUnit(
            Player(PLAYER_NEUTRAL_AGGRESSIVE),
            unitType,
            spawnV.x,
            spawnV.y,
            facing)
        SetUnitUserData(newUnit, unitId)
    end
end

local init = function()
    local trigger = CreateTrigger()

    TriggerRegisterAnyUnitEventBJ(trigger, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(trigger, clearDeadUnits)
end

return {
    init = init,
}