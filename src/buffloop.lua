local buff = require('src/buff.lua')
local damage = require('src/damage.lua')
local hero = require('src/hero.lua')
local casttime = require('src/casttime.lua')
local equipment = require('src/items/equipment.lua')
local itemmanager = require('src/items/itemmanager.lua')

local BUFF_LOOP_INTERVAL = 0.1

local numLoops = 0

function applyEffectList(obj, effectList)
    for idx,info in pairs(effectList) do
        if info.type == 'modifyMoveSpeed' then
            obj.baseSpeed = obj.baseSpeed * info.amount
        end
        if info.type == 'modifySize' then
            obj.scale = obj.scale * info.amount
        end
        if info.type == 'stun' then
            obj.isStunned = true
        end
        if info.type == 'root' then
            obj.isRooted = true
        end
        if info.type == 'rawHp' and obj.baseHP ~= nil then
            obj.baseHP = obj.baseHP + info.amount
        end
    end

    return obj
end

function applyBuffSpecificEffects(unit, source, effects, stacks)
    local hpToHeal = 0
    local dmgToDeal = 0
    for idx,info in pairs(effects) do
        if
            info.type == 'heal' and
            numLoops % (1 / BUFF_LOOP_INTERVAL * info.tickrate) == 0
        then
            hpToHeal = hpToHeal + info.amount * stacks
        end
        if
            info.type == 'damage' and
            numLoops % (1 / BUFF_LOOP_INTERVAL * info.tickrate) == 0
        then
            dmgToDeal = dmgToDeal + info.amount * stacks
        end
    end
    if hpToHeal > 0 then
        damage.heal(source, unit, hpToHeal)
    end
    if dmgToDeal > 0 then
        damage.dealDamage(source, unit, dmgToDeal)
    end
end

function maybeAddEffectToList(effectsByUnitId, unit, effect)
    local unitId = GetHandleId(unit)
    if effectsByUnitId[unitId] == nil then
        effectsByUnitId[unitId] = {
            unit = unit,
            effects = {},
        }
    end
    table.insert(effectsByUnitId[unitId].effects, effect)
end

function applyBuffs()
    -- Get all affected units (all buff units + all units with equipped items)
    -- Loop through each unit
    -- Grab the buffs for that unit
    -- Go through each effect on that buff and run applyEffectList and also
    -- manually do the heal/dmg part
    -- Go through each item for that unit
    -- Go through each stat on each item and run applyEffectList

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
                local stats = itemmanager.ITEMS[itemId].stats
                for _, statInfo in pairs(stats) do
                    maybeAddEffectToList(effectsByUnitId, heroUnit, statInfo)
                end
            end
            -- print('getting hero stats', hero.getStatEffects)
            local stats = hero.getStatEffects(playerId)
            for _, stat in pairs(stats) do
                maybeAddEffectToList(effectsByUnitId, heroUnit, stat)
            end
        end
    end

    local buffInstances = buff.getBuffInstances()
    for _, unitInfo in pairs(buffInstances) do
        local unit = unitInfo.unit
        for buffName,val in pairs(unitInfo.buffs) do
            local effects = buff.BUFF_INFO[buffName].effects
            for _,info in pairs(effects) do
                for i=1,val.stacks,1 do
                    maybeAddEffectToList(effectsByUnitId, unit, info)
                end
            end
            applyBuffSpecificEffects(unit, val.source, effects, val.stacks)
        end
    end

    for _,unitInfo in pairs(effectsByUnitId) do
        local unit = unitInfo.unit
        local ownerPlayerId = GetPlayerId(GetOwningPlayer(unit))
        local ownerHero = hero.getHero(ownerPlayerId)
        local ownerHeroInfo = hero.getPickedHero(ownerPlayerId)
        local baseSpeed = GetUnitDefaultMoveSpeed(unit)
        local scale = GetUnitPointValue(unit) / 100
        local isStunned = unit == ownerHero and casttime.isCasting(ownerPlayerId)
        local isRooted = false

        local res = applyEffectList({
            baseSpeed = baseSpeed,
            scale = scale,
            isStunned = isStunned,
            isRooted = isRooted,
            baseHP = ownerHeroInfo and ownerHeroInfo.baseHP,
        }, unitInfo.effects)

        if res.isRooted then
            SetUnitMoveSpeed(unit, 0)
        else
            SetUnitMoveSpeed(unit, res.baseSpeed)
        end
        PauseUnit(unit, res.isStunned)
        SetUnitScale(unit, res.scale, res.scale, res.scale)
        if res.baseHP ~= nil then
            BlzSetUnitMaxHP(unit, res.baseHP)
        end
    end

    numLoops = numLoops + 1
end

function init()
    TimerStart(CreateTimer(), BUFF_LOOP_INTERVAL, true, applyBuffs)
end

return {
    init = init,
}
