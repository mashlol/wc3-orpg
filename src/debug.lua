local backpack = require('src/items/backpack.lua')
local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')

local animNum = 1

-- Blademaster anims
-- 2, 3, 8 atk
-- 13 bladestorm


local debug9 = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    -- local hero = hero.getHero(playerId)

    -- SetUnitAnimationByIndex(hero, animNum)

    -- BlzSetUnitIntegerField(hero, UNIT_IF_LEVEL, 10)

    print(animNum)

    animNum = animNum + 0.01

    backpack.addItemIdToBackpack(playerId, 8)

    -- BlzFrameSetScale(_PORTRAIT, animNum)
    -- BlzFrameSetSpriteAnimate(_PORTRAIT, animNum, 0)
end

local debug0 = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    print(animNum)

    animNum = animNum - 0.01

    backpack.addItemIdToBackpack(playerId, 6)

    -- BlzFrameSetScale(_PORTRAIT, animNum)
    -- BlzFrameSetSpriteAnimate(_PORTRAIT, animNum, 0)

    -- backpack.addItemIdToBackpack(playerId, 1)
end

local debug8 = function()
    local playerId = GetPlayerId(GetTriggerPlayer())

    local heroUnit = hero.getHero(playerId)
    SetUnitPosition(heroUnit, mouse.getMouseX(playerId), mouse.getMouseY(playerId))
end

local init = function()
    local trigger = CreateTrigger()
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(0), OSKEY_9, 0, true)
    TriggerAddAction(trigger, debug9)

    local trig2 = CreateTrigger()
    BlzTriggerRegisterPlayerKeyEvent(trig2, Player(0), OSKEY_0, 0, true)
    TriggerAddAction(trig2, debug0)

    local trig3 = CreateTrigger()
    BlzTriggerRegisterPlayerKeyEvent(trig3, Player(0), OSKEY_8, 0, true)
    TriggerAddAction(trig3, debug8)
end

return {
    init = init,
}
