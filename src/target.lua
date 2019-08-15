local hero = require('src/hero.lua')
local log = require('src/log.lua')
local unitmap = require('src/unitmap.lua')

targets = {}

local getTarget = function(playerId)
    return targets[playerId]
end

local hasTarget = function(playerId)
    return targets[playerId] ~= nil
end

local syncTarget = function(unit)
    BlzSendSyncData("unit-targeted", GetHandleId(unit))
end

local setTarget = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local handleId = S2I(BlzGetTriggerSyncData())
    local unit = unitmap.getUnitByHandleId(handleId)
    targets[playerId] = unit
end

function init()
    local trigger = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        BlzTriggerRegisterPlayerSyncEvent(
            trigger, Player(i), "unit-targeted", false)
    end
    TriggerAddAction(trigger, setTarget)
end

return {
    init = init,
    getTarget = getTarget,
    syncTarget = syncTarget,
}
