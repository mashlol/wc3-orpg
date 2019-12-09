-- Spawn rats from hay when its killed

function onHayKilled()
    local deadUnit = GetDyingUnit()

    if GetUnitTypeId(deadUnit) == FourCC('ihay') then
        local unitX = GetUnitX(deadUnit)
        local unitY = GetUnitY(deadUnit)
        for _ = 1, GetRandomInt(2, 4), 1 do
            CreateUnit(
                Player(PLAYER_NEUTRAL_AGGRESSIVE),
                FourCC('irat'),
                unitX,
                unitY,
                GetRandomInt(0, 360))
        end
    end
end

function init()
    local killTrig = CreateTrigger()
    TriggerRegisterPlayerUnitEvent(
        killTrig,
        Player(PLAYER_NEUTRAL_AGGRESSIVE),
        EVENT_PLAYER_UNIT_DEATH,
        nil)
    TriggerAddAction(killTrig, onHayKilled)
end

return {
    init = init,
}