local clearDeadUnits = function()
    local dyingUnit = GetDyingUnit()
    if IsHeroUnitId(GetUnitTypeId(dyingUnit)) then
        return
    end
    TriggerSleepAction(3)
    RemoveUnit(dyingUnit)
end

local init = function()
    local trigger = CreateTrigger()

    TriggerRegisterAnyUnitEventBJ(trigger, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(trigger, clearDeadUnits)
end

return {
    init = init,
}
