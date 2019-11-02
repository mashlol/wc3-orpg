local hero = require('src/hero.lua')
local bossmanager = require('src/bosses/bossmanager.lua')
local spawnpoint = require('src/spawnpoint.lua')

local DUNGEONS
local TP_MAPPINGS = {}

-- List of units which we're going to respawn when we reset the dungeon
-- unitsToRespawn = {
--     [dungeon_key] = {
--         {
--             unitId = 1,
--             unitType = FourCC('hfoo'),
--             facing = 123,
--             spawnV = {
--                 x = 1,
--                 y = 2,
--             },
--         },
--     },
-- }
local unitsToRespawn = {}

function moveUnitToRegion(unit, region)
    local x = GetRectCenterX(region)
    local y = GetRectCenterY(region)
    SetUnitPosition(unit, x, y)
    if GetOwningPlayer(unit) == GetLocalPlayer() then
        PanCameraToTimed(x, y, 0)
    end
end

function onEnterRegion()
    local region = GetTriggeringRegion()

    local toInfo = TP_MAPPINGS[GetHandleId(region)]
    if toInfo ~= nil then
        moveUnitToRegion(GetEnteringUnit(), toInfo.toRect)

        maybeResetDungeon(toInfo.dungeonKey)
    end
end

function maybeResetDungeon(dungeonKey)
    for i=0,bj_MAX_PLAYERS,1 do
        local heroUnit = hero.getHero(i)
        if heroUnit ~= nil and getUnitDungeonKey(heroUnit) == dungeonKey then
            return
        end
    end

    if
        DUNGEONS[dungeonKey].finalBoss == nil or
        not bossmanager.isBossAlive(DUNGEONS[dungeonKey].finalBoss)
    then
        if unitsToRespawn[dungeonKey] ~= nil then
            for _, unitInfo in pairs(unitsToRespawn[dungeonKey]) do
                local newUnit = CreateUnit(
                Player(PLAYER_NEUTRAL_AGGRESSIVE),
                    unitInfo.unitType,
                    unitInfo.spawnV.x,
                    unitInfo.spawnV.y,
                    unitInfo.facing)
                SetUnitUserData(newUnit, unitInfo.unitId)
            end
        end

        if DUNGEONS[dungeonKey].finalBoss ~= nil then
            bossmanager.maybeRespawnBoss(DUNGEONS[dungeonKey].finalBoss)
        end
        for _, boss in pairs(DUNGEONS[dungeonKey].otherBosses) do
            bossmanager.maybeRespawnBoss(boss)
        end

        unitsToRespawn[dungeonKey] = {}
        print(DUNGEONS[dungeonKey].name .. ' has been reset.')
    end
end

function getUnitDungeonKey(unit)
    for dungeonKey, dungeonInfo in pairs(DUNGEONS) do
        local region = CreateRegion()
        for _, rect in pairs(dungeonInfo.rects) do
            RegionAddRect(region, rect)
        end
        local ret = IsUnitInRegion(region, unit)
        RemoveRegion(region)
        if ret then
            return dungeonKey
        end
    end
    return nil
end

function maybeAddUnitForRespawning()
    local unit = GetTriggerUnit()

    -- Bosses respawn via boss manager.
    if bossmanager.isBoss(unit) then
        return
    end

    local dungeonKey = getUnitDungeonKey(unit)

    if dungeonKey == nil then
        return
    end

    local spawnV = spawnpoint.getSpawnPoint(unit)
    local facing = spawnpoint.getFacing(unit)
    local unitId = GetUnitUserData(unit)
    local unitType = GetUnitTypeId(unit)

    if unitsToRespawn[dungeonKey] == nil then
        unitsToRespawn[dungeonKey] = {}
    end

    table.insert(unitsToRespawn[dungeonKey], {
        unitId = unitId,
        unitType = unitType,
        spawnV = spawnV,
        facing = facing,
    })
end

function init()
    DUNGEONS = {
        MINES = {
            name = "The mines",
            tps = {
                {
                    from = gg_rct_mineenter,
                    to = gg_rct_mineentrance,
                },
                {
                    from = gg_rct_minefinish,
                    to = gg_rct_mineexit,
                },
                {
                    from = gg_rct_mineleave,
                    to = gg_rct_mineexit,
                },
            },
            rects = {
                gg_rct_minedungeon1,
            },
            finalBoss = bossmanager.ALL_BOSSES.THE_OVERSEER,
            otherBosses = {
                bossmanager.ALL_BOSSES.MINER_JOE,
            },
        },
        WOLF_LAIR = {
            name = "Wolf Lair",
            tps = {
                {
                    from = gg_rct_wolfenter,
                    to = gg_rct_wolfentrance,
                },
                {
                    from = gg_rct_wolfleave,
                    to = gg_rct_wolfexit,
                },
            },
            rects = {
                gg_rct_wolfdungeon1,
                gg_rct_wolfdungeon2,
            },
            finalBoss = nil,
            otherBosses = {},
        },
    }

    local enterRegionTrig = CreateTrigger()
    for dungeonKey, dungeonInfo in pairs(DUNGEONS) do
        for _, tpInfo in pairs(dungeonInfo.tps) do
            local fromRegion = CreateRegion()
            local toRect = tpInfo.to
            RegionAddRect(fromRegion, tpInfo.from)
            TriggerRegisterEnterRegion(enterRegionTrig, fromRegion, nil)
            TP_MAPPINGS[GetHandleId(fromRegion)] = {
                dungeonKey = dungeonKey,
                toRect = toRect,
            }
        end
    end
    TriggerAddAction(enterRegionTrig, onEnterRegion)

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
}