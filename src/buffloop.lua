local buff = require('src/buff.lua')
local damage = require('src/damage.lua')

local BUFF_LOOP_INTERVAL = 0.1

local numLoops = 0
function applyBuffs()
    local buffInstances = buff.getBuffInstances()
    for unitId,unitInfo in pairs(buffInstances) do
        local unit = unitInfo.unit
        local buffs = unitInfo.buffs
        local baseSpeed = GetUnitDefaultMoveSpeed(unit)
        local isStunned = false
        local isRooted = false

        for buffName,val in pairs(buffs) do
            local hpToHeal = 0
            local effects = buff.BUFF_INFO[buffName].effects
            for idx,info in pairs(effects) do
                if info.type == 'modifyMoveSpeed' then
                    baseSpeed = baseSpeed * info.amount * val.stacks
                end
                if
                    info.type == 'heal' and
                    numLoops % (1 / BUFF_LOOP_INTERVAL * info.tickrate) == 0
                then
                    hpToHeal = hpToHeal + info.amount * val.stacks
                end
                if info.type == 'stun' then
                    isStunned = true
                end
                if info.type == 'root' then
                    isRooted = true
                end
            end
            if hpToHeal > 0 then
                damage.heal(val.source, unit, hpToHeal)
            end
        end

        if isRooted then
            SetUnitMoveSpeed(unit, 0)
        else
            SetUnitMoveSpeed(unit, baseSpeed)
        end
        PauseUnit(unit, isStunned)
    end
    numLoops = numLoops + 1
end

function init()
    TimerStart(CreateTimer(), BUFF_LOOP_INTERVAL, true, applyBuffs)
end

return {
    init = init,
}
