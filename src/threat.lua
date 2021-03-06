-- THREAT system
-- Keep track of every heroes "threat" level on every other unit
local Vector = require('src/vector.lua')
local spawnpoint = require('src/spawnpoint.lua')
local hero = require('src/hero.lua')

local AGGRO_RADIUS = 500

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

function hasAnyThreat(unit)
    if threatLevels[GetHandleId(unit)] == nil then
        return false
    end
    for _, _ in pairs(threatLevels[GetHandleId(unit)].threats) do
        return true
    end
    return false
end

-- Iterates through the targets & prunes dead units or units which are too far
-- away
function pruneThreatLevels()
    local newThreatLevels = {}

    for targetUnitId,threatInfo in pairs(threatLevels) do
        local newThreats = {}
        if GetUnitState(threatInfo.unit, UNIT_STATE_LIFE) > 0 then
            local targetSpawnPos = spawnpoint.getSpawnPoint(threatInfo.unit)
            for sourceUnitId,sourceThreatInfo in pairs(threatInfo.threats) do
                local unitIsAlive =
                    GetUnitState(sourceThreatInfo.unit, UNIT_STATE_LIFE) > 0
                local sourcePos = Vector:new{
                    x = GetUnitX(sourceThreatInfo.unit),
                    y = GetUnitY(sourceThreatInfo.unit)}
                local unitIsWithinRange = true
                if BlzGetUnitBooleanField(threatInfo.unit, UNIT_BF_RAISABLE) then
                    local dist = sourcePos
                        :subtract(targetSpawnPos)
                        :magnitude()
                    unitIsWithinRange = dist <= 1500
                end

                if unitIsAlive and unitIsWithinRange then
                    hasAnyThreats = true
                    newThreats[sourceUnitId] = sourceThreatInfo
                end
            end
            threatInfo.threats = newThreats
            newThreatLevels[targetUnitId] = threatInfo
        end
    end
    threatLevels = newThreatLevels
end

function manageAggroRanges()
    -- Loop through all heroes
    -- Get all units within x yards of hero
    -- If its a creep, add some threat to it.
    for i=0,bj_MAX_PLAYERS,1 do
        local hero = hero.getHero(i)
        if hero then
            local loc = Location(GetUnitX(hero), GetUnitY(hero))
            ForGroupBJ(GetUnitsInRangeOfLocAll(AGGRO_RADIUS, loc), function()
                local unit = GetEnumUnit()
                if
                    GetOwningPlayer(unit) == Player(PLAYER_NEUTRAL_AGGRESSIVE) and
                    IsVisibleToPlayer(GetUnitX(unit), GetUnitY(unit), Player(i))
                then
                    addThreat(hero, unit, 0.01)
                end
            end)
            RemoveLocation(loc)
        end
    end
end

-- On tick, we can go through a each units threat on each unit, and make them
-- attack whoever appropriatly (assuming they are NPC controlled)
function onTick()
    manageAggroRanges()
    pruneThreatLevels()
    for _,threatInfo in pairs(threatLevels) do
        local newTarget
        local highestThreat = 0
        local targetUnit = threatInfo.unit
        for _,sourceThreatInfo in pairs(threatInfo.threats) do
            if sourceThreatInfo.threat > highestThreat then
                highestThreat = sourceThreatInfo.threat
                newTarget = sourceThreatInfo.unit
            end
        end

        if newTarget ~= nil then
            -- Attack new target
            IssueTargetOrder(targetUnit, "attack", newTarget)
        else
            local targetSpawnPos = spawnpoint.getSpawnPoint(targetUnit)
            if targetSpawnPos ~= nil then
                IssuePointOrder(
                    targetUnit, "move", targetSpawnPos.x, targetSpawnPos.y)
            end
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
    hasAnyThreat = hasAnyThreat,
}
