local hero = require('src/hero.lua')
local log = require('src/log.lua')

local targets = {}
local ignoreTargetChange = {}

local getTarget = function(playerId)
    return targets[playerId]
end

local hasTarget = function(playerId)
    return targets[playerId] ~= nil
end

local onTargetChanged = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local selectedUnit = GetTriggerUnit()
    if not ignoreTargetChange[playerId] then
        targets[playerId] = selectedUnit
    end
    ignoreTargetChange[playerId] = nil
    if selectedUnit ~= hero.getHero(playerId) then
        ignoreTargetChange[playerId] = true
        if playerId == GetPlayerId(GetLocalPlayer()) then
            ClearSelection()
            SelectUnit(hero.getHero(playerId), true)
        end
    end
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
