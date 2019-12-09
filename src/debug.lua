local backpack = require('src/items/backpack.lua')
local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local itemmanager = require('src/items/itemmanager.lua')
local items = require('src/items/items.lua')

local animNum = 1

-- Blademaster anims
-- 2, 3, 8 atk
-- 13 bladestorm

local itemId = 1

local debug9 = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local hero = hero.getHero(playerId)

    local curLevel = GetHeroLevel(hero)
    SetHeroLevel(hero, curLevel + 1, true)

    -- SetUnitAnimationByIndex(hero, animNum)

    -- BlzSetUnitIntegerField(hero, UNIT_IF_LEVEL, 10)



    -- print(animNum)

    -- animNum = animNum + 0.01

    -- backpack.addItemIdToBackpack(playerId, 48)

    -- itemId = itemId + 1

    -- BlzFrameSetScale(_PORTRAIT, animNum)
    -- BlzFrameSetSpriteAnimate(_PORTRAIT, animNum, 0)
end

local debug0 = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local hero = hero.getHero(playerId)
    -- print(animNum)

    -- animNum = animNum - 0.01

    -- backpack.addItemIdToBackpack(playerId, 49)

    SetUnitAnimationByIndex(hero, itemId)

    print(itemId)

    itemId = itemId + 1

    -- BlzFrameSetScale(_PORTRAIT, animNum)
    -- BlzFrameSetSpriteAnimate(_PORTRAIT, animNum, 0)

    -- backpack.addItemIdToBackpack(playerId, 1)
end

local debug8 = function()
    local playerId = GetPlayerId(GetTriggerPlayer())

    local heroUnit = hero.getHero(playerId)
    SetUnitPosition(heroUnit, mouse.getMouseX(playerId), mouse.getMouseY(playerId))
end

local onGiveItem = function()
    local sentString = GetEventPlayerChatString()
    local itemNameOrId = SubString(
        sentString, 3, StringLength(sentString))

    local itemId = S2I(itemNameOrId)

    if itemId == 0 then
        for idx, info in pairs(items.ITEMS) do
            if info.name == itemNameOrId then
                print("Giving: ", itemNameOrId)
                backpack.addItemIdToBackpack(0, idx)
                return
            end
        end
        print("No item with that name found")
    else
        print("Giving: ", itemmanager.getItemInfo(itemId).name)
        backpack.addItemIdToBackpack(0, itemId)
    end
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

    local giveItemTrig = CreateTrigger()
    TriggerRegisterPlayerChatEvent(giveItemTrig, Player(0), "-g", false)
    TriggerAddAction(giveItemTrig, onGiveItem)
end

return {
    init = init,
}
