local hero = require('src/hero.lua')
local log = require('src/log.lua')

targets = {}
targetEffects = {}

local getTarget = function(playerId)
    return targets[playerId]
end

local hasTarget = function(playerId)
    return targets[playerId] ~= nil
end

local onTargetChanged = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local selectedUnit = GetTriggerUnit()
    targets[playerId] = selectedUnit
end

function init()
    local trig = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        TriggerRegisterPlayerUnitEvent(
            trig, Player(i), EVENT_PLAYER_UNIT_SELECTED, nil)
    end
    TriggerAddAction(trig, onTargetChanged)
end

return {
    init = init,
    getTarget = getTarget,
}
