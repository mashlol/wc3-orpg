local hero = require('src/hero.lua')

local animNum = 0

-- 5, 6, 8, 9, 10, 11, 12 attacks

-- 16 channel/cast

-- 17 is like victory

local debug = function()
    local hero = hero.getHero(GetPlayerId(GetTriggerPlayer()))

    SetUnitAnimationByIndex(hero, animNum)
    print(animNum)

    animNum = animNum + 1
end

local init = function()
    local trigger = CreateTrigger()

    -- TriggerRegisterAnyUnitEventBJ(trigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    -- TriggerRegisterAnyUnitEventBJ(trigger, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    -- TriggerRegisterAnyUnitEventBJ(trigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    -- TriggerRegisterAnyUnitEventBJ(trigger, EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)

    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(0), OSKEY_1, 0, true)

    TriggerAddAction(trigger, debug)
end

return {
    init = init,
}
