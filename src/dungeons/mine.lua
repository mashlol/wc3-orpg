local hero = require('src/hero.lua')
local bossmanager = require('src/bosses/bossmanager.lua')
local spawnpoint = require('src/spawnpoint.lua')

-- List of units which we're going to respawn when we reset the dungeon
local unitsToRespawn = {}

function moveUnitToRegion(unit, region)
    local x = GetRectCenterX(region)
    local y = GetRectCenterY(region)
    SetUnitPosition(unit, x, y)
    if GetOwningPlayer(unit) == GetLocalPlayer() then
        PanCameraToTimed(x, y, 0)
    end
end

function onEnterDungeon()
    moveUnitToRegion(GetEnteringUnit(), gg_rct_mineentrance)
end

function onExitDungeon()
    moveUnitToRegion(GetEnteringUnit(), gg_rct_mineexit)

    maybeResetDungeon()
end

function maybeResetDungeon()
    for i=0,bj_MAX_PLAYERS,1 do
        local heroUnit = hero.getHero(i)
        if heroUnit ~= nil and isUnitInMine(heroUnit) then
            return
        end
    end

    -- TODO check if the final boss is dead.
    if not bossmanager.isBossAlive(bossmanager.ALL_BOSSES.THE_OVERSEER) then
        for _, unitInfo in pairs(unitsToRespawn) do
            local newUnit = CreateUnit(
            Player(PLAYER_NEUTRAL_AGGRESSIVE),
                unitInfo.unitType,
                unitInfo.spawnV.x,
                unitInfo.spawnV.y,
                unitInfo.facing)
            SetUnitUserData(newUnit, unitInfo.unitId)
        end

        bossmanager.maybeRespawnBoss(bossmanager.ALL_BOSSES.THE_OVERSEER)
        bossmanager.maybeRespawnBoss(bossmanager.ALL_BOSSES.MINER_JOE)

        unitsToRespawn = {}
        print('The mine has been reset.')
    end
end

function isUnitInMine(unit)
    local region = CreateRegion()
    RegionAddRect(region, gg_rct_minedungeon1)
    local ret = IsUnitInRegion(region, unit)
    RemoveRegion(region)
    return ret
end

function maybeAddUnitForRespawning()
    local unit = GetTriggerUnit()

    -- Bosses respawn via boss manager.
    if bossmanager.isBoss(unit) then
        return
    end

    local spawnV = spawnpoint.getSpawnPoint(unit)
    local facing = spawnpoint.getFacing(unit)
    local unitId = GetUnitUserData(unit)
    local unitType = GetUnitTypeId(unit)

    table.insert(unitsToRespawn, {
        unitId = unitId,
        unitType = unitType,
        spawnV = spawnV,
        facing = facing,
    })
end

function init()
    local enterDungeonTrig = CreateTrigger()
    TriggerRegisterEnterRectSimple(enterDungeonTrig, gg_rct_mineenter)
    TriggerAddAction(enterDungeonTrig, onEnterDungeon)

    local exitDungeonTrig = CreateTrigger()
    TriggerRegisterEnterRectSimple(exitDungeonTrig, gg_rct_minefinish)
    TriggerRegisterEnterRectSimple(exitDungeonTrig, gg_rct_mineleave)
    TriggerAddAction(exitDungeonTrig, onExitDungeon)

    local deathTrigger = CreateTrigger()
    TriggerRegisterPlayerUnitEvent(
        deathTrigger,
        Player(PLAYER_NEUTRAL_AGGRESSIVE),
        EVENT_PLAYER_UNIT_DEATH,
        nil)
    TriggerAddAction(deathTrigger, maybeAddUnitForRespawning)
end

return {
    init = init,
    isUnitInMine = isUnitInMine,
}