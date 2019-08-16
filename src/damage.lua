local buff = require('src/buff.lua')

function dealDamage(source, target, amount)
    local curHealth = BlzGetUnitRealField(target, UNIT_RF_HP)
    local modifiedAmt = amount * buff.getDamageModifier(source, target)
    local newHealth = curHealth - modifiedAmt

    BlzSetUnitRealField(
        target,
        UNIT_RF_HP,
        newHealth)

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
