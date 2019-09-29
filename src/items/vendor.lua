local hero = require('src/hero.lua')
local Vendor = require('src/ui/vendor.lua')

local VENDORS

function onNpcClicked()
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
        Vendor.show(playerId, {items = VENDORS[unitHandle]})
    end
end

function init()
    VENDORS = {
        [GetHandleId(gg_unit_nvlw_0015)] = {
            5, 6
        }
    }

    local selectTrig = CreateTrigger()
    for i=0,bj_MAX_PLAYERS-1,1 do
        TriggerRegisterPlayerUnitEvent(
            selectTrig, Player(i), EVENT_PLAYER_UNIT_SELECTED, nil)
    end
    TriggerAddAction(selectTrig, onNpcClicked)
end

return {
    init = init,
}