local hero = require('src/hero.lua')
local Vendor = require('src/ui/vendor.lua')

local VENDORS

function onNpcVendorClicked()
    -- Check if its a questgiver, and if the player is close enough.
    -- If they are, give them the quest.
    -- TODO If they aren't order them to move to the questgiver and wait X time
    -- Then check again after X time and try to give quest again
    local playerId = GetPlayerId(GetTriggerPlayer())
    local hero = hero.getHero(playerId)
    local selectedUnit = GetTriggerUnit()

    local unitHandle = GetHandleId(selectedUnit)

    if
        VENDORS[unitHandle] ~= nil and
        IsUnitInRange(hero, selectedUnit, 300)
    then
        Vendor.show(playerId, {items = VENDORS[unitHandle].items})
    end
end

function init()
    VENDORS = {
        [GetHandleId(gg_unit_nvlw_0015)] = {
            unit = gg_unit_nvlw_0015,
            items = {5, 6}
        }
    }

    for _, vendorInfo in pairs(VENDORS) do
        AddSpecialEffectTarget(
            "Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl",
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