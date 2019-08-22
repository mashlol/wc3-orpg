local buff = require('src/buff.lua')
local damage = require('src/damage.lua')

function applyBuffs()
    local buffInstances = buff.getBuffInstances()
    for unitId,unitInfo in pairs(buffInstances) do
        local unit = unitInfo.unit
        local buffs = unitInfo.buffs
        local baseSpeed = GetUnitDefaultMoveSpeed(unit)
        local isStunned = false

        for buffName,val in pairs(buffs) do
            local hpToHeal = 0
            local effects = buff.BUFF_INFO[buffName].effects
            for idx,info in pairs(effects) do
                if info.type == 'modifyMoveSpeed' then
                    baseSpeed = baseSpeed * info.amount * val.stacks
                end
                if info.type == 'heal' then
                    hpToHeal = hpToHeal + info.amount * val.stacks
                end
                if info.type == 'stun' then
                    isStunned = true
                end
            end
            if hpToHeal > 0 then
                damage.heal(val.source, unit, hpToHeal)
            end
        end

        PauseUnit(unit, isStunned)
        SetUnitMoveSpeed(unit, baseSpeed)
    end
end

function init()
    TimerStart(CreateTimer(), 1, true, applyBuffs)
end

return {
    init = init,
}
