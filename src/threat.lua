-- THREAT system

-- Keep track of every heroes "threat" level on every other unit

-- e.g.
-- threatLevels = {
--     unitId = {
--         unit = unit,
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

-- Iterates through the targets & prunes dead units or units which are too far
-- away
function pruneThreatLevels()
    local newThreatLevels = {}

    for targetUnitId,threatInfo in pairs(threatLevels) do
        local newThreats = {}
        local hasAnyThreats = false
        if GetUnitState(threatInfo.unit, UNIT_STATE_LIFE) > 0 then
            for sourceUnitId,sourceThreatInfo in pairs(threatInfo.threats) do
                if GetUnitState(sourceThreatInfo.unit, UNIT_STATE_LIFE) > 0 then
                    hasAnyThreats = true
                    newThreats[sourceUnitId] = sourceThreatInfo
                end
            end
            if hasAnyThreats then
                threatInfo.threats = newThreats
                newThreatLevels[targetUnitId] = threatInfo
            end
        end
    end

    threatLevels = newThreatLevels
end

-- On tick, we can go through a each units threat on each unit, and make them
-- attack whoever appropriatly (assuming they are NPC controlled)
function onTick()
    pruneThreatLevels()

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
            threatInfo.currentTarget = newTarget
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
