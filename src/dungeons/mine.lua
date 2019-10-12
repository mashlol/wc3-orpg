
function moveUnitToRegion(unit, region)
    local x = GetRectCenterX(region)
    local y = GetRectCenterY(region)
    SetUnitPosition(unit, x, y)
    if GetOwningPlayer(unit) == GetLocalPlayer() then
        PanCameraToTimed(x, y, 0)
    end
end

function onEnterDungeon()
    moveUnitToRegion(GetEnteringUnit(), gg_rct_mineentrance)
end

function onExitDungeon()
    moveUnitToRegion(GetEnteringUnit(), gg_rct_mineexit)
end

function init()
    local enterDungeonTrig = CreateTrigger()
    TriggerRegisterEnterRectSimple(enterDungeonTrig, gg_rct_mineenter)
    TriggerAddAction(enterDungeonTrig, onEnterDungeon)

    local exitDungeonTrig = CreateTrigger()
    TriggerRegisterEnterRectSimple(exitDungeonTrig, gg_rct_minefinish)
    TriggerRegisterEnterRectSimple(exitDungeonTrig, gg_rct_mineleave)
    TriggerAddAction(exitDungeonTrig, onExitDungeon)
end

return {
    init = init,
}