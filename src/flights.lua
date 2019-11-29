local hero = require('src/hero.lua')
local buff = require('src/buff.lua')
local Map = require('src/ui/map.lua')
local projectile = require('src/projectile.lua')
local Vector = require('src/vector.lua')

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
            local fromV = Vector:new{
                x = GetUnitX(hero),
                y = GetUnitY(hero),
            }
            projectile.createProjectile{
                playerId = playerId,
                model = _FLIGHT_VENDORS[unitHandle].flightModel,
                z = 650,
                fromV = fromV,
                toV = flightPathInfo,
                speed = 750,
                radius = 0,
                visionRadius = 800,
                removeInsteadOfKill = true,
                cameraFollow = true,
                onDestroy = function()
                    SetUnitPosition(hero, flightPathInfo.x, flightPathInfo.y)
                    ShowUnit(hero, true)

                    if playerId == GetPlayerId(GetLocalPlayer()) then
                        SelectUnit(hero, true)
                        PanCameraToTimed(flightPathInfo.x, flightPathInfo.y, 0)
                    end
                end,
            }

            ShowUnit(hero, false)
            local distance = Vector:new(fromV)
                :subtract(flightPathInfo)
                :magnitude()
            local duration = distance / 750
            buff.addBuff(hero, hero, 'stunnoicon', duration)

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
            SWAMP_HUB = {
                x = 10107,
                y = 10721,
                name = "TODO Name",
            },
        }
    end
    return _FLIGHT_PATHS
end

function init()
    _FLIGHT_VENDORS = {
        [GetHandleId(gg_unit_nvil_0016)] = {
            unit = gg_unit_nvil_0016,
            flightModel = "units\\human\\BloodElfDragonHawk\\BloodElfDragonHawk"
        },
        [GetHandleId(gg_unit_nvil_0383)] = {
            unit = gg_unit_nvil_0383,
            flightModel = "units\\human\\phoenix\\phoenix.mdl"
        },
        [GetHandleId(gg_unit_nvil_0501)] = {
            unit = gg_unit_nvil_0501,
            flightModel = "Units\\Creeps\\RedDrake\\RedDrake.mdl"
        },
    }

    for _, vendor in pairs(_FLIGHT_VENDORS) do
        AddSpecialEffectTarget(
            "Objects\\InventoryItems\\runicobject\\runicobject.mdl",
            vendor.unit,
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