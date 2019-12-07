-- Manages zones (text when you enter/leave zones and which zone is your respawn point)
local log = require('src/log.lua')

local ZONES

local ASHENVALE_RAIN_HEAVY = FourCC('RAhr')
local ASHENVALE_RAIN_LIGHT = FourCC('RAlr')
local DALARAN_SHIELD = FourCC('MEds')
local DUNGEON_BLUE_FOG_HEAVY = FourCC('FDbh')
local DUNGEON_BLUE_FOG_LIGHT = FourCC('FDbl')
local DUNGEON_GREEN_FOG_HEAVY = FourCC('FDgh')
local DUNGEON_GREEN_FOG_LIGHT = FourCC('FDgl')
local DUNGEON_RED_FOG_HEAVY = FourCC('FDrh')
local DUNGEON_RED_FOG_LIGHT = FourCC('FDrl')
local DUNGEON_WHITE_FOG_HEAVY = FourCC('FDwh')
local DUNGEON_WHITE_FOG_LIGHT = FourCC('FDwl')
local LORDAERON_RAIN_HEAVY = FourCC('RLhr')
local LORDAERON_RAIN_LIGHT = FourCC('RLlr')
local NORTHREND_BLIZZARD = FourCC('SNbs')
local NORTHREND_SNOW_HEAVY = FourCC('SNhs')
local NORTHREND_SNOW_LIGHT = FourCC('SNls')
local OUTLAND_WIND_HEAVY = FourCC('WOcw')
local OUTLAND_WIND_LIGHT = FourCC('WOlw')
local RAYS_OF_SUNLIGHT = FourCC('LRaa')
local RAYS_OF_MOONLIGHT = FourCC('LRma')
local HEAVY_WIND = FourCC('WNcw')

local DEFAULT_SPAWN_POINT = {
    x = 2149,
    y = -11130,
}

-- spawnPoints = {
--     [playerId] = {x = 1, y = 1},
-- }
local spawnPoints = {}

-- zones = {
--     [playerId] = [ZONE_KEY]
-- }
local zones = {}

-- weatherEffects = {
--     [zoneId] = {
--       [weathereffect],
--       [weathereffect],
--     },
-- }
local weatherEffects = {}

function getSpawnPoint(playerId)
    if spawnPoints[playerId] == nil then
        return DEFAULT_SPAWN_POINT
    end
    return spawnPoints[playerId]
end

function getCurrentZone(playerId)
    return zones[playerId]
end

function getWeatherForZone(zoneInfo)
    local totalWeight = 0
    for _, weight in pairs(zoneInfo.weathers) do
        totalWeight = totalWeight + weight
    end
    local randNum = GetRandomReal(0, totalWeight)
    local curWeight = 0
    for weatherId, weight in pairs(zoneInfo.weathers) do
        curWeight = curWeight + weight
        if randNum < curWeight then
            if weatherId == 'none' then
                return nil
            end
            return weatherId
        end
    end

    return nil
end

function maybeChangeWeather()
    -- Every once in a while, roll some dice and maybe change the weather
    for zoneKey, zoneInfo in pairs(ZONES) do
        if zoneInfo.weathers ~= nil then
            local effectsToRemove = {}
            if weatherEffects[zoneKey] ~= nil then
                for _, effect in pairs(weatherEffects[zoneKey]) do
                    table.insert(effectsToRemove, effect)
                end
            end
            weatherEffects[zoneKey] = {}

            local weatherId = getWeatherForZone(zoneInfo)
            if weatherId ~= nil then
                for _, rect in pairs(zoneInfo.weatherRects) do
                    local effect = AddWeatherEffect(rect, weatherId)
                    table.insert(weatherEffects[zoneKey], effect)
                    EnableWeatherEffect(effect, true)
                end
            end

            for _, effect in pairs(effectsToRemove) do
                RemoveWeatherEffect(effect)
            end
        end
    end
end

function init()
    ZONES = {
        FREYDELL = {
            name = "Freydell Village",
            rects = {
                gg_rct_freydellenter1,
            },
            weatherRects = {
                gg_rct_freydellenter1
            },
            weathers = {
                [RAYS_OF_SUNLIGHT] = 1,
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
                gg_rct_rain1,
                gg_rct_rain2,
                gg_rct_rain3,
            },
            weatherRects = {
                gg_rct_rain1,
                gg_rct_rain2,
                gg_rct_rain3,
            },
            weathers = {
                [ASHENVALE_RAIN_HEAVY] = 9,
                [RAYS_OF_SUNLIGHT] = 1,
            },
        },
        ICE_ZONE = {
            name = "The Glacial Tundra",
            levelRange = {7, 15},
            rects = {
                gg_rct_iceenter1,
                gg_rct_iceenter2,
            },
            weatherRects = {
                gg_rct_iceenter1,
                gg_rct_iceenter2,
            },
            weathers = {
                [NORTHREND_SNOW_HEAVY] = 9,
                none = 1,
            },
        },
        CULTIST_FOREST = {
            name = "The Solemn Woods",
            levelRange = {15, 20},
            rects = {
                gg_rct_cultists1,
                gg_rct_cultists2,
                gg_rct_cultists3,
                gg_rct_cultists4,
            },
            weatherRects = {
                gg_rct_cultists1,
                gg_rct_cultists2,
                gg_rct_cultists3,
                gg_rct_cultists4,
            },
            weathers = {
                [ASHENVALE_RAIN_LIGHT] = 4,
                [OUTLAND_WIND_LIGHT] = 1,
                [RAYS_OF_SUNLIGHT] = 2,
            },
        },
        FARM = {
            name = "Joe's Farm",
            levelRange = {20, 25},
            rects = {
                gg_rct_farm1,
                gg_rct_farm2,
            },
        },
        IRONWELL_CAMP = {
            name = "Ironwell Military Camp",
            rects = {
                gg_rct_ironwellcamp,
            },
        },
        IRONWELL_CITY = {
            name = "Ironwell City",
            rects = {
                gg_rct_ironwell1,
                gg_rct_ironwell2,
                gg_rct_ironwell3,
            },
            weatherRects = {
                gg_rct_ironwell1,
                gg_rct_ironwell2,
                gg_rct_ironwell3,
            },
            weathers = {
                [RAYS_OF_MOONLIGHT] = 19,
                [ASHENVALE_RAIN_HEAVY] = 1,
            },
            spawnPoint = {
                x = 16676,
                y = -13636,
            },
        },
        TROLL_CAVE = {
            name = 'Dungeon: Icy Caverns',
            levelRange = {13, 17},
            rects = {
                gg_rct_trolldungeon,
            },
        },
        SEWERS = {
            name = 'Dungeon: The Sewers of Ironwell',
            levelRange = {20, 25},
            rects = {
                gg_rct_sewerdungeon,
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

    TimerStart(CreateTimer(), 87, true, maybeChangeWeather)
    maybeChangeWeather()
end

return {
    ZONES = ZONES,
    DEFAULT_SPAWN_POINT = DEFAULT_SPAWN_POINT,
    init = init,
    getSpawnPoint = getSpawnPoint,
    getCurrentZone = getCurrentZone,
}