local hero = require('src/hero.lua')

targets = {}

local onUnitSelected = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local targetedUnit = GetTriggerUnit()
    if targetedUnit ~= hero.getHero(playerId) then
        targets[playerId] = targetedUnit
    end
end

local onUnitDeselected = function()
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

local setTarget = function(playerId, unit)
    if targets[playerId] ~= unit then
        local sound = CreateSound(
            "Sound\\Interface\\SubGroupSelectionChange1.wav",
            false,
            false,
            false,
            0,
            0,
            "DefaultEAXON")
        if playerId == GetPlayerId(GetLocalPlayer()) then
            StartSound(sound)
        end
        KillSoundWhenDone(sound)
    end

    targets[playerId] = unit
end

return {
    init = init,
    getTarget = getTarget,
    setTarget = setTarget,
}
