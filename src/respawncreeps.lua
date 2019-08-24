local spawnpoint = require('src/spawnpoint.lua')

local clearDeadUnits = function()
    local unit = GetTriggerUnit()
    local spawnV = spawnpoint.getSpawnPoint(unit)
    local unitId = GetUnitUserData(unit)

    if spawnV then
        TriggerSleepAction(3)

        local newUnit = CreateUnit(
            Player(PLAYER_NEUTRAL_AGGRESSIVE),
            GetUnitTypeId(unit),
            spawnV.x,
            spawnV.y,
            0)
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
