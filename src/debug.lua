local hero = require('src/hero.lua')
local backpack = require('src/items/backpack.lua')

local animNum = 0

-- Blademaster anims
-- 2, 3, 8 atk
-- 13 bladestorm


local debug = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local hero = hero.getHero(playerId)

    SetUnitAnimationByIndex(hero, animNum)

    animNum = animNum + 1

    -- backpack.addItemIdToBackpack(playerId, 1)
end

local init = function()
    local trigger = CreateTrigger()

    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(0), OSKEY_1, 0, true)

    TriggerAddAction(trigger, debug)
end

return {
    init = init,
}
