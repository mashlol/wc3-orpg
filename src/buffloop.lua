local buff = require('src/buff.lua')

function applyBuffs()
    local buffInstances = buff.getBuffInstances()
    for unitId,unitInfo in pairs(buffInstances) do
        local unit = unitInfo.unit
        local buffs = unitInfo.buffs
        local baseSpeed = GetUnitDefaultMoveSpeed(unit)
        local hp = BlzGetUnitRealField(unit, UNIT_RF_HP)

        for buffName,val in pairs(buffs) do
            local effects = buff.BUFF_INFO[buffName].effects
            for idx,info in pairs(effects) do
                if info.type == 'modifyMoveSpeed' then
                    baseSpeed = baseSpeed * info.amount
                end
                if info.type == 'heal' then
                    hp = hp +
                        info.amount *
                        buff.getHealingModifier(val.source, unit)
                end
            end
        end

        BlzSetUnitRealField(unit, UNIT_RF_HP, hp)
        SetUnitMoveSpeed(unit, baseSpeed)
    end
end

function init()
    TimerStart(CreateTimer(), 1, true, applyBuffs)
end

return {
    init = init,
}
