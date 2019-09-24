-- unitCombatMap = {
--     [unitHandleId] = timer or nil
-- }
local unitCombatMap = {}

function maybePutUnitInCombat(unit)
    local unitId = GetHandleId(unit)

    local timer = CreateTimer()
    if unitCombatMap[unitId] ~= nil then
        -- Already in combat, restart the timer
        DestroyTimer(unitCombatMap[unitId])
    end

    unitCombatMap[unitId] = timer
    TimerStart(timer, 5, false, function()
        unitCombatMap[unitId] = nil
        DestroyTimer(timer)

        if
            GetPlayerId(GetOwningPlayer(unit)) == PLAYER_NEUTRAL_AGGRESSIVE and
            GetUnitState(unit, UNIT_STATE_LIFE) > 0
        then
            -- Heal unit to max
            SetUnitState(unit, UNIT_STATE_LIFE, BlzGetUnitMaxHP(unit))
        end
    end)
end

function onAttacked()
    maybePutUnitInCombat(GetAttacker())
    maybePutUnitInCombat(GetTriggerUnit())
end

function isInCombat(unit)
    return unitCombatMap[GetHandleId(unit)] ~= nil
end

function init()
    local attackedTrigger = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        TriggerRegisterPlayerUnitEvent(
            attackedTrigger, Player(i), EVENT_PLAYER_UNIT_ATTACKED, nil)
    end
    TriggerAddAction(attackedTrigger, onAttacked)
end

return {
    init = init,
    isInCombat = isInCombat,
}