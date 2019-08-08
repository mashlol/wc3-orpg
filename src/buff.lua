local BUFF_INFO = {
    focus = {
        effects = {
            {
                type = 'multiplyDamage',
                amount = 1.2,
            },
        },
    },
}

-- BuffInstances:
-- {
--   unitHandleID = {
--     buffName = true
--   }
-- }
local buffInstances = {}

function addBuff(unit, buffName)
    local unitId = GetHandleId(unit)
    if buffInstances[unitId] == nil then
        buffInstances[unitId] = {}
    end

    buffInstances[unitId][buffName] = true
end

function removeBuff(unit, buffName)
    local unitId = GetHandleId(unit)
    if buffInstances[unitId] == nil then
        return
    end

    buffInstances[unitId][buffName] = nil
end

function hasBuff(unit, buffName)
    local unitId = GetHandleId(unit)
    return buffInstances[unitId] ~= nil and buffInstances[unitId][buffName]
end

function getBuffs(unit)
    local unitId = GetHandleId(unit)
    return buffInstances[unitId] or {}
end

-- Iterate over all a units buffs and get the final damage modifier
function getDamageModifier(unit)
    local buffs = getBuffs(unit)
    local modifier = 1
    for buffName,val in pairs(buffs) do
        local effects = BUFF_INFO[buffName].effects
        for idx,info in pairs(effects) do
            if info.type == 'multiplyDamage' then
                modifier = modifier * info.amount
            end
        end
    end
    return modifier
end

return {
    addBuff = addBuff,
    removeBuff = removeBuff,
    hasBuff = hasBuff,
    getBuffs = getBuffs,
    getDamageModifier = getDamageModifier,
}
