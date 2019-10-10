local buff = require('src/buff.lua')
local threat = require('src/threat.lua')

local TYPE = {
    SPELL = {
        attackType = ATTACK_TYPE_HERO,
        damageType = DAMAGE_TYPE_UNKNOWN,
        weaponType = WEAPON_TYPE_WHOKNOWS,
    },
    PHYSICAL = {
        attackType = ATTACK_TYPE_NORMAL,
        damageType = DAMAGE_TYPE_UNKNOWN,
        weaponType = WEAPON_TYPE_WHOKNOWS,
    },
}

function createCombatText(text, target, green, isCrit)
    local targetSize = BlzGetUnitCollisionSize(target)

    local tag = CreateTextTag()
    SetTextTagText(
        tag,
        I2S(S2I(text)),
        TextTagSize2Height(targetSize * 0.04 + 6) * 1.5 * (isCrit and 1.5 or 1))
    SetTextTagPosUnit(tag, target, 7)
    if green then
        SetTextTagColor(tag, 0, 255, 0, 0)
    else
        SetTextTagColor(tag, 255, 0, 0, 0)
    end
    SetTextTagVelocity(
        tag,
        TextTagSpeed2Velocity(GetRandomReal(-70, 70)),
        TextTagSpeed2Velocity(70))
    SetTextTagPermanent(tag, false)
    SetTextTagLifespan(tag, 0.5)
    SetTextTagFadepoint(tag, 0.01)

    TimerStart(CreateTimer(), 0.5, false, function()
        DestroyTextTag(tag)
        DestroyTimer(GetExpiredTimer())
    end)
end

function dealDamage(source, target, amount, type)
    UnitDamageTarget(
        source,
        target,
        amount,
        true,
        false,
        type.attackType,
        type.damageType,
        type.weaponType)
end

function heal(source, target, amount)
    local curHealth = BlzGetUnitRealField(target, UNIT_RF_HP)
    local modifiedAmt = buff.getModifiedHealing(source, target, amount)
    local newHealth = curHealth + modifiedAmt

    BlzSetUnitRealField(
        target,
        UNIT_RF_HP,
        newHealth)

    createCombatText(modifiedAmt, target, true)

    -- TODO feed into threat system
end

function getTypeFromTypes(damageType, weaponType, attackType)
    for _, type in pairs(TYPE) do
        if
            type.damageType == damageType and
            type.weaponType == weaponType and
            type.attackType == attackType
        then
            return type
        end
    end
    -- All auto attacks are physical
    return TYPE.PHYSICAL
end

function onDamageTaken()
    local source = GetEventDamageSource()
    local target = GetTriggerUnit()
    local damageType = BlzGetEventDamageType()
    local weaponType = BlzGetEventWeaponType()
    local attackType = BlzGetEventAttackType()

    local type = getTypeFromTypes(damageType, weaponType, attackType)

    local amount = buff.getModifiedDamage(
        source, target, GetEventDamage(), type)
    -- TODO pull from buffs to get crit chance & crit modifier
    -- Roll a dice to check if its a crit
    local critChance = GetRandomInt(0, 100)
    local isCrit = critChance < 1
    if isCrit then
        amount = amount * 2
    end

    BlzSetEventDamage(amount)
    createCombatText(amount, target, false, isCrit)
    threat.addThreat(source, target, amount)
    buff.maybeRemoveBuffsOnDamage(source, target, amount)
end

function init()
    local trigger = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        TriggerRegisterPlayerUnitEvent(
            trigger, Player(i), EVENT_PLAYER_UNIT_DAMAGED, nil)
    end
    TriggerAddAction(trigger, onDamageTaken)
end

return {
    TYPE = TYPE,
    init = init,
    dealDamage = dealDamage,
    heal = heal,
}
