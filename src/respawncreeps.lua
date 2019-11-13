local spawnpoint = require('src/spawnpoint.lua')
local hero = require('src/hero.lua')

local isCloseTo = function(val, expected, range)
    return val + range >= expected and val - range <= expected
end

function isHeroNearby(vec)
    for i=0,bj_MAX_PLAYERS,1 do
        local heroUnit = hero.getHero(i)
        if
            isCloseTo(GetUnitX(heroUnit), vec.x, 500) and
            isCloseTo(GetUnitY(heroUnit), vec.y, 500)
        then
            return true
        end
    end

    return false
end

local clearDeadUnits = function()
    local unit = GetTriggerUnit()
    local spawnV = spawnpoint.getSpawnPoint(unit)
    local facing = spawnpoint.getFacing(unit)
    local unitId = GetUnitUserData(unit)
    local unitType = GetUnitTypeId(unit)

    if not BlzGetUnitBooleanField(unit, UNIT_BF_RAISABLE) then
        return
    end

    if spawnV and facing then
        TriggerSleepAction(5)

        -- Check if any heroes are nearby, if so, don't respawn
        while isHeroNearby(spawnV) do
            TriggerSleepAction(5)
        end

        local newUnit = CreateUnit(
            Player(PLAYER_NEUTRAL_AGGRESSIVE),
            unitType,
            spawnV.x,
            spawnV.y,
            facing)
        SetUnitUserData(newUnit, unitId)
    end
end

local init = function()
    local trigger = CreateTrigger()
    TriggerRegisterPlayerUnitEvent(
        trigger,
        Player(PLAYER_NEUTRAL_AGGRESSIVE),
        EVENT_PLAYER_UNIT_DEATH,
        nil)
    TriggerAddAction(trigger, clearDeadUnits)
end

return {
    init = init,
}