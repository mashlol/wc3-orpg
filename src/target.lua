targets = {}

local onUnitSelected = function()
    print("Selected a unit", GetTriggerUnit())
    targets[GetPlayerId(GetTriggerPlayer())] = GetTriggerUnit()
end

local onUnitDeselected = function()
    print("Deselected a unit", GetTriggerUnit())
    targets[GetPlayerId(GetTriggerPlayer())] = nil
end

local init = function()
    local deselectTrigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(deselectTrigger, EVENT_PLAYER_UNIT_DESELECTED)
    TriggerAddAction(selectTrigger, onUnitDeselected)

    local selectTrigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(selectTrigger, EVENT_PLAYER_UNIT_SELECTED)
    TriggerAddAction(selectTrigger, onUnitSelected)
end

local getTarget = function(playerId)
    return targets[playerId]
end

local hasTarget = function(playerId)
    return targets[playerId] ~= nil
end

return {
    init = init,
    getTarget = getTarget,
}
