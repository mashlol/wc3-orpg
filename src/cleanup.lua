local clearDeadUnits = function()
    TriggerSleepAction(3)
    RemoveUnit(GetDyingUnit())
end

local init = function()
    local trigger = CreateTrigger()

    TriggerRegisterAnyUnitEventBJ(trigger, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(trigger, clearDeadUnits)
end

return {
    init = init,
}
