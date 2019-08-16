local hero = require('src/hero.lua')
local log = require('src/log.lua')
local unitmap = require('src/unitmap.lua')

targets = {}
targetEffects = {}

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

    if targetEffects[playerId] ~= nil then
        BlzSetSpecialEffectPosition(targetEffects[playerId], 0, 0, -2000)
        DestroyEffect(targetEffects[playerId])
    end
    if targets[playerId] ~= nil then
        targetEffects[playerId] = AddSpecialEffect(
            GetPlayerId(GetLocalPlayer()) == playerId and
                "UI\\Feedback\\TargetPreSelected\\TargetPreSelected.mdl" or
                "",
            GetUnitX(targets[playerId]),
            GetUnitY(targets[playerId]))
        BlzSetSpecialEffectHeight(targetEffects[playerId], 0)
        if IsUnitAlly(targets[playerId], Player(playerId)) then
            BlzSetSpecialEffectColor(targetEffects[playerId], 0, 255, 0)
        else
            BlzSetSpecialEffectColor(targetEffects[playerId], 255, 0, 0)
        end
        BlzSetSpecialEffectZ(targetEffects[playerId], -1000)
        BlzSetSpecialEffectScale(
            targetEffects[playerId],
            BlzGetUnitRealField(targets[playerId], UNIT_RF_SELECTION_SCALE))
    end
end

function updateTargetEffectLocations()
    for playerId, targetEffect in pairs(targetEffects) do
        if targets[playerId] ~= nil then
            BlzSetSpecialEffectPosition(
                targetEffect,
                GetUnitX(targets[playerId]),
                GetUnitY(targets[playerId]),
                -60)
        end
    end
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
    updateTargetEffectLocations = updateTargetEffectLocations,
}
