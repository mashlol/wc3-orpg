local hero = require('src/hero.lua')
local log = require('src/log.lua')

local targets = {}
local targetEffects = {}
local ignoreTargetChange = {}

local getTarget = function(playerId)
    return targets[playerId]
end

function setupEffectForTarget(playerId)
    if targetEffects[playerId] ~= nil then
        BlzSetSpecialEffectPosition(targetEffects[playerId], 0, 0, -2000)
        DestroyEffect(targetEffects[playerId])
        targetEffects[playerId] = nil
    end
    if targets[playerId] ~= nil and targets[playerId] ~= hero.getHero(playerId) then
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

local onTargetChanged = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    if hero.getHero(playerId) == nil then
        return
    end

    local selectedUnit = GetTriggerUnit()
    if not ignoreTargetChange[playerId] then
        targets[playerId] = selectedUnit
        setupEffectForTarget(playerId)
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
    local trig = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        TriggerRegisterPlayerUnitEvent(
            trig, Player(i), EVENT_PLAYER_UNIT_SELECTED, nil)
    end
    TriggerAddAction(trig, onTargetChanged)
    TimerStart(CreateTimer(), 0.06, true, updateTargetEffectLocations)
end

return {
    init = init,
    getTarget = getTarget,
}
