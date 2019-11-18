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
            levelRange = {1, 7},
            rects = {
                gg_rct_forestenter1,
            },
        },
        ICE_ZONE = {
            name = "The Glacial Tundra",
            levelRange = {7, 15},
            rects = {
                gg_rct_iceenter1,
                gg_rct_iceenter2,
            },
        },
        TROLL_CAVE = {
            name = 'Troll Cave',
            rects = {
                gg_rct_trolldungeon,
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