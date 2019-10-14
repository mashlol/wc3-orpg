-- Manages zones (text when you enter/leave zones and which zone is your respawn point)
local log = require('src/log.lua')

local DEFAULT_SPAWN_POINT = {
    x = 4100,
    y = 3000,
}

-- spawnPoints = {
--     [playerId] = {x = 1, y = 1},
-- }
local spawnPoints = {}

function getSpawnPoint(playerId)
    if spawnPoints[playerId] == nil then
        return DEFAULT_SPAWN_POINT
    end
    return spawnPoints[playerId]
end

function init()
    local ZONES = {
        FREYDELL = {
            name = "Freydell Village",
            rects = {
                gg_rct_freydellenter1,
            },
            spawnPoint = {
                x = 4100,
                y = 3000,
            },
        },
        FOREST = {
            name = "Forest",
            rects = {
                gg_rct_forestenter1,
            },
        },
        WOLVES = {
            name = "Wolf Forest",
            rects = {
                gg_rct_wolvesenter1,
                gg_rct_wolvesenter2,
            },
        },
        WOLF_CAVE = {
            name = 'Wolf Cave',
            rects = {
                gg_rct_wolfcaveenter1,
            },
        },
        CULTIST_CAMP = {
            name = 'Cultist Camp',
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
    }

    for _, zoneInfo in pairs(ZONES) do
        for _, rect in pairs(zoneInfo.rects) do
            local enterZoneTrig = CreateTrigger()
            TriggerRegisterEnterRectSimple(enterZoneTrig, rect)
            TriggerAddAction(enterZoneTrig, function()
                local playerId = GetPlayerId(GetOwningPlayer(GetEnteringUnit()))
                log.log(
                    playerId,
                    "You entered " .. zoneInfo.name .. ".",
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
            end)
        end
    end
end

return {
    DEFAULT_SPAWN_POINT = DEFAULT_SPAWN_POINT,
    init = init,
    getSpawnPoint = getSpawnPoint,
}