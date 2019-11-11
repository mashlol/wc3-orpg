-- Manages zones (text when you enter/leave zones and which zone is your respawn point)
local log = require('src/log.lua')

local ZONES

local DEFAULT_SPAWN_POINT = {
    x = 1998,
    y = -3141,
}

-- spawnPoints = {
--     [playerId] = {x = 1, y = 1},
-- }
local spawnPoints = {}

-- zones = {
--     [playerId] = [ZONE_KEY]
-- }
local zones = {}

function getSpawnPoint(playerId)
    if spawnPoints[playerId] == nil then
        return DEFAULT_SPAWN_POINT
    end
    return spawnPoints[playerId]
end

function getCurrentZone(playerId)
    return zones[playerId]
end

function init()
    ZONES = {
        FREYDELL = {
            name = "Freydell Village",
            rects = {
                gg_rct_freydellenter1,
            },
            spawnPoint = {
                x = 1998,
                y = -3141,
            },
        },
        FOREST = {
            name = "Freydell Forest",
            levelRange = {1, 6},
            rects = {
                gg_rct_forestenter1,
            },
        },
        WOLVES = {
            name = "Wolf Plains",
            levelRange = {7, 12},
            rects = {
                gg_rct_wolvesenter1,
                gg_rct_wolvesenter2,
            },
        },
        ICE_ZONE = {
            name = "Ice Zone",
            levelRange = {7, 12},
            rects = {
                gg_rct_iceenter1,
            },
        },
        WOLF_CAVE = {
            name = 'Wolf Cave',
            levelRange = {10, 14},
            rects = {
                gg_rct_wolfcaveenter1,
                gg_rct_wolfexit,
            },
        },
        CULTIST_CAMP = {
            name = 'Cultist Camp',
            levelRange = {15, 20},
            rects = {
                gg_rct_cultistenter1,
            },
        },
        IRONWELL_CAMP = {
            name = 'Ironwell Camp',
            rects = {
                gg_rct_campenter1,
            },
            spawnPoint = {
                x = 14527,
                y = -5345,
            },
        },
        THE_MINES = {
            name = 'The Mines',
            levelRange = {20, 25},
            rects = {
                gg_rct_minedungeon1,
            },
        },
        WOLF_LAIR = {
            name = 'Wolf Lair',
            levelRange = {8, 13},
            rects = {
                gg_rct_wolfdungeon1,
                gg_rct_wolfdungeon2,
            },
        },
        BEATEN_ROAD = {
            name = 'The Beaten Road',
            rects = {
                gg_rct_roadenter1,
                gg_rct_roadenter2,
            },
        },
    }

    for zoneKey, zoneInfo in pairs(ZONES) do
        for _, rect in pairs(zoneInfo.rects) do
            local enterZoneTrig = CreateTrigger()
            TriggerRegisterEnterRectSimple(enterZoneTrig, rect)
            TriggerAddAction(enterZoneTrig, function()
                local playerId = GetPlayerId(GetOwningPlayer(GetEnteringUnit()))

                if zones[playerId] ~= zoneKey then
                    zones[playerId] = zoneKey

                    local levelRange = ""
                    if zoneInfo.levelRange ~= nil then
                        levelRange = "|cffffffff (Recommended Lv: " ..
                            zoneInfo.levelRange[1] ..
                            " - " ..
                            zoneInfo.levelRange[2] ..
                            ')'
                    end

                    log.log(
                        playerId,
                        "Now entering |cffdb8b1a" .. zoneInfo.name .. "|r" .. levelRange,
                        log.TYPE.INFO)

                    local curSpawnPoint = getSpawnPoint(playerId)
                    if zoneInfo.spawnPoint ~= nil then
                        if
                            curSpawnPoint.x ~= zoneInfo.spawnPoint.x or
                            curSpawnPoint.y ~= zoneInfo.spawnPoint.y
                        then
                            log.log(
                                playerId,
                                "Updating spawn point to " .. zoneInfo.name .. ".",
                                log.TYPE.INFO)
                        end
                        spawnPoints[playerId] = zoneInfo.spawnPoint
                    end
                end
            end)
        end
    end
end

return {
    ZONES = ZONES,
    DEFAULT_SPAWN_POINT = DEFAULT_SPAWN_POINT,
    init = init,
    getSpawnPoint = getSpawnPoint,
    getCurrentZone = getCurrentZone,
}