local buff = require('src/buff.lua')
local damage = require('src/damage.lua')
local hero = require('src/hero.lua')
local equipment = require('src/items/equipment.lua')
local itemmanager = require('src/items/itemmanager.lua')

local BUFF_LOOP_INTERVAL = 0.1

local finalBuffList = {}
local numLoops = 0

function applyBuffSpecificEffects(unit, source, effects, stacks)
    local obj = buff.getBaseObjForUnit(unit)
    for _,info in pairs(effects) do
        for i=1,stacks,1 do
            info.type.effect(info, obj, numLoops)
        end
    end
    if obj.hpToHeal > 0 then
        damage.heal(source, unit, obj.hpToHeal)
    end
    if obj.dmgToDeal > 0 then
        damage.dealDamage(source, unit, obj.dmgToDeal, damage.TYPE.SPELL)
    end
end

function applyBuffs()
    -- Get all affected units (all buff units + all units with equipped items)
    -- Loop through each unit
    -- Grab the buffs for that unit
    -- Go through each effect on that buff and run buff.applyEffectList and also
    -- manually do the heal/dmg part
    -- Go through each item for that unit
    -- Go through each stat on each item and run buff.applyEffectList

    -- effectsByUnitId = {
    --     [unitHandleId] = {
    --         unit = unit,
    --         effects = {
    --             {effect1}, {effect2}, {effect3},
    --         }
    --     },
    -- }

    local effectsByUnitId = {}

    for playerId=0,bj_MAX_PLAYERS,1 do
        local heroUnit = hero.getHero(playerId)
        if heroUnit ~= nil then
            local equippedItems = equipment.getEquippedItems(playerId)
            for _, itemId in pairs(equippedItems) do
                local stats = itemmanager.getItemInfo(itemId).stats
                for _, statInfo in pairs(stats) do
                    buff.maybeAddEffectToList(effectsByUnitId, heroUnit, statInfo)
                end
            end
            local stats = hero.getStatEffects(playerId)
            for _, stat in pairs(stats) do
                buff.maybeAddEffectToList(effectsByUnitId, heroUnit, stat)
            end

            applyBuffSpecificEffects(
                heroUnit,
                heroUnit,
                effectsByUnitId[GetHandleId(heroUnit)].effects,
                1)
        end
    end

    local buffInstances = buff.getBuffInstances()
    for _, unitInfo in pairs(buffInstances) do
        local unit = unitInfo.unit
        buff.maybeAddEffectToList(effectsByUnitId, unit)
        for buffName,val in pairs(unitInfo.buffs) do
            local effects = buff.BUFF_INFO[buffName].effects
            for _,info in pairs(effects) do
                for i=1,val.stacks,1 do
                    buff.maybeAddEffectToList(effectsByUnitId, unit, info)
                end
            end
            applyBuffSpecificEffects(unit, val.source, effects, val.stacks)
        end
    end

    for idx,unitInfo in pairs(effectsByUnitId) do
        local unit = unitInfo.unit
        local unitType = GetUnitTypeId(unit)

        local obj = buff.getBaseObjForUnit(unit)
        local res = buff.applyEffectList(obj, unitInfo.effects)
        finalBuffList[idx] = res

        if res.isRooted and buff.isUnitTypeStunnable(unitType) then
            SetUnitMoveSpeed(unit, 0)
        elseif buff.isUnitTypeSlowable(unitType) then
            SetUnitMoveSpeed(unit, res.baseSpeed)
        end
        if buff.isUnitTypeStunnable(unitType) then
            PauseUnit(unit, res.isStunned)
        end
        SetUnitScale(unit, res.scale, res.scale, res.scale)
        if res.baseHP then
            BlzSetUnitMaxHP(unit, res.baseHP)
        end
        if res.attackSpeed then
            BlzSetUnitAttackCooldown(unit, res.attackSpeed, 0)
        end
    end

    numLoops = numLoops + 1
end

function getUnitInfo(unit)
    return finalBuffList[GetHandleId(unit)] or buff.getBaseObjForUnit(unit)
end

function init()
    TimerStart(CreateTimer(), BUFF_LOOP_INTERVAL, true, applyBuffs)
end

return {
    init = init,
    getUnitInfo = getUnitInfo,
}
