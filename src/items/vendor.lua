local hero = require('src/hero.lua')
local Vendor = require('src/ui/vendor.lua')

local VENDORS
local forceExitTimers = {}

function startExitTimer(playerId, vendorUnit)
    forceExitTimers[playerId] = CreateTimer()
    TimerStart(forceExitTimers[playerId], 1, true, function()
        local hero = hero.getHero(playerId)
        if not IsUnitInRange(hero, vendorUnit, 300) then
            DestroyTimer(forceExitTimers[playerId])
            Vendor.hide(playerId)
            forceExitTimers[playerId] = nil
        end
    end)
end

function onNpcVendorClicked()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local hero = hero.getHero(playerId)
    local selectedUnit = GetTriggerUnit()

    local unitHandle = GetHandleId(selectedUnit)

    if
        VENDORS[unitHandle] ~= nil and
        IsUnitInRange(hero, selectedUnit, 300)
    then
        Vendor.show(playerId, {items = VENDORS[unitHandle].items})

        startExitTimer(playerId, selectedUnit)
    end
end

function init()
    VENDORS = {
        [GetHandleId(gg_unit_nvlw_0006)] = {
            unit = gg_unit_nvlw_0006,
            items = {5, 6,}
        },
		[GetHandleId(gg_unit_nvlw_0332)] = {
            unit = gg_unit_nvlw_0332,
            items = {5, 6,}
        },
    }

    for _, vendorInfo in pairs(VENDORS) do
        AddSpecialEffectTarget(
            "Objects\\InventoryItems\\PotofGold\\PotofGold.mdl",
            vendorInfo.unit,
            'overhead')
    end

    local selectTrig = CreateTrigger()
    for i=0,bj_MAX_PLAYERS-1,1 do
        TriggerRegisterPlayerUnitEvent(
            selectTrig, Player(i), EVENT_PLAYER_UNIT_SELECTED, nil)
    end
    TriggerAddAction(selectTrig, onNpcVendorClicked)
end

return {
    init = init,
}