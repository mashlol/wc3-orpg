local hero = require('src/hero.lua')
local backpack = require('src/items/backpack.lua')

local animNum = 1

-- Blademaster anims
-- 2, 3, 8 atk
-- 13 bladestorm


local debug = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    -- local hero = hero.getHero(playerId)

    -- SetUnitAnimationByIndex(hero, animNum)

    -- BlzSetUnitIntegerField(hero, UNIT_IF_LEVEL, 10)

    print(animNum)

    animNum = animNum + 0.01

    backpack.addItemIdToBackpack(playerId, 1)

    -- BlzFrameSetScale(_PORTRAIT, animNum)
    -- BlzFrameSetSpriteAnimate(_PORTRAIT, animNum, 0)
end

local debugDown = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    print(animNum)

    animNum = animNum - 0.01

    backpack.addItemIdToBackpack(playerId, 5)

    -- BlzFrameSetScale(_PORTRAIT, animNum)
    -- BlzFrameSetSpriteAnimate(_PORTRAIT, animNum, 0)

    -- backpack.addItemIdToBackpack(playerId, 1)
end

local init = function()
    local trigger = CreateTrigger()
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(0), OSKEY_1, 0, true)
    TriggerAddAction(trigger, debug)

    local trig2 = CreateTrigger()
    BlzTriggerRegisterPlayerKeyEvent(trig2, Player(0), OSKEY_2, 0, true)
    TriggerAddAction(trig2, debugDown)
end

return {
    init = init,
}
