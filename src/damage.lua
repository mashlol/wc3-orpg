local buff = require('src/buff.lua')

function createCombatText(text, target, green)
    local targetSize = BlzGetUnitCollisionSize(target)

    local tag = CreateTextTag()
    SetTextTagText(tag, text, TextTagSize2Height(targetSize * 0.04 + 6))
    SetTextTagPosUnit(tag, target, 10)
    if green then
        SetTextTagColor(tag, 0, 100, 0, 0)
    else
        SetTextTagColor(tag, 100, 0, 0, 0)
    end
    SetTextTagVelocity(
        tag,
        TextTagSpeed2Velocity(GetRandomReal(-100, 100)),
        TextTagSpeed2Velocity(100))
    SetTextTagPermanent(tag, false)
    SetTextTagLifespan(tag, 0.5)
    SetTextTagFadepoint(tag, 0.01)
end

function dealDamage(source, target, amount)
    local curHealth = BlzGetUnitRealField(target, UNIT_RF_HP)
    local modifiedAmt = amount * buff.getDamageModifier(source, target)
    local newHealth = curHealth - modifiedAmt

    BlzSetUnitRealField(
        target,
        UNIT_RF_HP,
        newHealth)

    createCombatText(modifiedAmt, target, false)

    -- TODO feed into threat system
end

function heal(source, target, amount)
    local curHealth = BlzGetUnitRealField(target, UNIT_RF_HP)
    local modifiedAmt = amount * buff.getHealingModifier(source, target)
    local newHealth = curHealth + modifiedAmt

    BlzSetUnitRealField(
        target,
        UNIT_RF_HP,
        newHealth)

    createCombatText(modifiedAmt, target, true)

    -- TODO feed into threat system
end

function onDamageTaken()
    -- All auto attacks will deal 0 damage. We customize it here.
    local source = GetEventDamageSource()
    local target = GetTriggerUnit()
    dealDamage(source, target, GetUnitPointValue(source))
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
    init = init,
    dealDamage = dealDamage,
    heal = heal,
}
