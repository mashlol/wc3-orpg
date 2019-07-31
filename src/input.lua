function initInput()
    print("INited inputs")
    unit1 = CreateUnit(Player(0), FourCC("Hpal"), -150, -125, 0)
    unit2 = CreateUnit(Player(1), FourCC("Hpal"), -150, -125, 0)
end

TimerStart(CreateTimer(), 0.0, false, initInput)

function mouseMoved()
    local pos = BlzGetTriggerPlayerMousePosition()
    local player = GetTriggerPlayer()
    if GetPlayerId(player) == 0 then
        SetUnitPosition(unit1, GetLocationX(pos), GetLocationY(pos))
    end
    if GetPlayerId(player) == 1 then
        SetUnitPosition(unit2, GetLocationX(pos), GetLocationY(pos))
    end
end

local trigger = CreateTrigger()

TriggerRegisterPlayerEvent(trigger, Player(0), EVENT_PLAYER_MOUSE_MOVE)
TriggerRegisterPlayerEvent(trigger, Player(1), EVENT_PLAYER_MOUSE_MOVE)

TriggerAddAction(trigger, mouseMoved)