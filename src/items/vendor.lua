local hero = require('src/hero.lua')
local vendorlist = require('src/items/vendorlist.lua')
local Vendor = require('src/ui/vendor.lua')

local VENDORS

function startVendorExitTimer(playerId, vendorUnit)
    local timer = CreateTimer()
    TimerStart(timer, 1, true, function()
        if not IsUnitInRange(hero.getHero(playerId), vendorUnit, 300) then
            DestroyTimer(timer)
            Vendor.hide(playerId)
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

        startVendorExitTimer(playerId, selectedUnit)
    end
end

function init()
    VENDORS = vendorlist.getVendors()

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