-- THREAT system

-- Keep track of every heroes "threat" level on every other unit

-- e.g.
-- threatLevels = {
--     unitId = {
--         unit = unit,
--         currentTarget = nil,
--         threats = {
--             unitId = {
--                 unit = unit,
--                 threat = 12,
--             },
--             otherUnitId = {
--                 unit = unit,
--                 threat = 15,
--             },
--         },
--     },
-- }
local threatLevels = {}

-- On tick, we can go through a each units threat on each unit, and make them
-- attack whoever appropriatly (assuming they are NPC controlled)
-- TODO For non-instance units, reset threat if a certain range is exceeded
-- TODO Clear all threat for dead units
function onTick()
    for targetUnitId,threatInfo in pairs(threatLevels) do
        local newTarget
        local highestThreat = 0
        local targetUnit = threatInfo.unit
        for sourceUnitId,sourceThreatInfo in pairs(threatInfo.threats) do
            if sourceThreatInfo.threat > highestThreat then
                highestThreat = sourceThreatInfo.threat
                newTarget = sourceThreatInfo.unit
            end
        end

        if newTarget ~= nil then
            -- Attack new target
            IssueTargetOrder(targetUnit, "attack", newTarget)
            -- threatInfo.currentTarget = newTarget
        end
    end
end

function addThreat(source, target, amount)
    if GetOwningPlayer(target) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE) then
        -- We don't support threat on non-NPCs
        return
    end

    local sourceUnitId = GetHandleId(source)
    local targetUnitId = GetHandleId(target)

    if threatLevels[targetUnitId] == nil then
        threatLevels[targetUnitId] = {unit = target, threats = {}}
    end

    if threatLevels[targetUnitId].threats[sourceUnitId] == nil then
        threatLevels[targetUnitId].threats[sourceUnitId] = {
            unit=source,
            threat = 0,
        }
    end

    local curThreat = threatLevels[targetUnitId].threats[sourceUnitId].threat
    threatLevels[targetUnitId].threats[sourceUnitId].threat = curThreat + amount
end

function init()
    TimerStart(CreateTimer(), 0.5, true, onTick)
end

return {
    init = init,
    addThreat = addThreat,
}
