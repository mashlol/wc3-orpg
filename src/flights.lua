local hero = require('src/hero.lua')
local Map = require('src/ui/map.lua')

local _FLIGHT_PATHS
local _FLIGHT_VENDORS

function startFlightExitTimer(playerId, vendorUnit)
    local timer = CreateTimer()
    TimerStart(timer, 1, true, function()
        if not IsUnitInRange(hero.getHero(playerId), vendorUnit, 300) then
            DestroyTimer(timer)
            Map.hide(playerId)
        end
    end)
end

function onFlightPathNpcClicked()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local hero = hero.getHero(playerId)
    local selectedUnit = GetTriggerUnit()

    local unitHandle = GetHandleId(selectedUnit)

    if
        _FLIGHT_VENDORS[unitHandle] ~= nil and
        IsUnitInRange(hero, selectedUnit, 300)
    then
        Map.showForChooseFlightPath(playerId, function(flightPathInfo)
            SetUnitPosition(hero, flightPathInfo.x, flightPathInfo.y)
            if playerId == GetPlayerId(GetLocalPlayer()) then
                PanCameraToTimed(flightPathInfo.x, flightPathInfo.y, 0)
            end

            Map.hide(playerId)
        end)

        startFlightExitTimer(playerId, selectedUnit)
    end
end

function getFlightPaths()
    if _FLIGHT_PATHS == nil then
        _FLIGHT_PATHS = {
            FREYDELL = {
                x = 1474,
                y = -4322.4,
                name = "Freydell Village",
            },
            IRONWELL = {
                x = 13544.1,
                y = -11397.2,
                name = "Ironwell City",
            },
        }
    end
    return _FLIGHT_PATHS
end

function init()
    _FLIGHT_VENDORS = {
        [GetHandleId(gg_unit_nvil_0016)] = gg_unit_nvil_0016,
        [GetHandleId(gg_unit_nvil_0383)] = gg_unit_nvil_0383
    }

    for _, vendor in pairs(_FLIGHT_VENDORS) do
        AddSpecialEffectTarget(
            "Objects\\InventoryItems\\runicobject\\runicobject.mdl",
            vendor,
            'overhead')
    end

    local selectTrig = CreateTrigger()
    for i=0,bj_MAX_PLAYERS-1,1 do
        TriggerRegisterPlayerUnitEvent(
            selectTrig, Player(i), EVENT_PLAYER_UNIT_SELECTED, nil)
    end
    TriggerAddAction(selectTrig, onFlightPathNpcClicked)
end

return {
    init = init,
    getFlightPaths = getFlightPaths,
}