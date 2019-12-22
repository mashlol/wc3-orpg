local backpack = require('src/items/backpack.lua')
local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local itemmanager = require('src/items/itemmanager.lua')
local items = require('src/items/items.lua')
local log = require('src/log.lua')

local SKYBOXES = {
    "Environment\\Sky\\AshenvaleSky\\AshenvaleSky.mdl",
    "Environment\\Sky\\BarrensSky\\BarrensSky.mdl",
    "Environment\\Sky\\BlizzardSky\\BlizzardSky.mdl",
    "Environment\\Sky\\DalaranSky\\DalaranSky.mdl",
    "Environment\\Sky\\DalaranRuinsSky\\DalaranRuinsSky.mdl",
    "Environment\\Sky\\FelwoodSky\\FelwoodSky.mdl",
    "Environment\\Sky\\FoggedSky\\FoggedSky.mdl",
    "Environment\\Sky\\Sky\\SkyLight.mdl",
    "Environment\\Sky\\IcecrownGlacierSky\\IcecrownGlacierSky.mdl",
    "Environment\\Sky\\LordaeronFallSky\\LordaeronFallSky.mdl",
    "Environment\\Sky\\LordaeronSummerSky\\LordaeronSummerSky.mdl",
    "Environment\\Sky\\LordaeronWinterSky\\LordaeronWinterSky.mdl",
    "Environment\\Sky\\LordaeronWinterSkyBrightGreen\\LordaeronWinterSkyBrightGreen.mdl",
    "Environment\\Sky\\LordaeronWinterSkyPink\\LordaeronWinterSkyPink.mdl",
    "Environment\\Sky\\LordaeronWinterSkyPurple\\LordaeronWinterSkyPurple.mdl",
    "Environment\\Sky\\LordaeronWinterSkyRed\\LordaeronWinterSkyRed.mdl",
    "Environment\\Sky\\LordaeronWinterSkyYellow\\LordaeronWinterSkyYellow.mdl",
    "Environment\\Sky\\NorthrendSky\\NorthrendSky.mdl",
    "Environment\\Sky\\Outland_Sky\\Outland_Sky.mdl",
    "Environment\\Sky\\PrologueSky\\PrologueSky.mdl",
    "Environment\\Sky\\VillageSky\\VillageSky.mdl",
    "Environment\\Sky\\VillageFallSky\\VillageFallSky.mdl",
}

local animNum = 1

-- Blademaster anims
-- 2, 3, 8 atk
-- 13 bladestorm

local itemId = 1

local screenshotId = 1
local skyboxId = 0

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

local debugMinus = function()
    print("Disabling print statements, you will no longer see debug messages")
    print = function() end
    log.log = function() end

    BlzEnableCursor(false)
    BlzFrameSetVisible(BlzGetFrameByName("menuButtonsOrigin", 0), false)

    if GetLocalPlayer() == GetTriggerPlayer() then
        hero.removeHero(GetPlayerId(GetTriggerPlayer()))
        print("Applying camera: \"Camera Screenshot " .. screenshotId .. "\"")
        local camName = "gg_cam_Camera_Screenshot_"..screenshotId
        CameraSetupApplyForceDuration(_G[camName], true, 0)
        screenshotId = screenshotId + 1

        local newCamName = "gg_cam_Camera_Screenshot_"..screenshotId
        if _G[newCamName] == nil then
            screenshotId = 1
        end
    end
end

local debugAdd = function()
    local skyboxModel = SKYBOXES[skyboxId + 1]
    print("Set skybox to " .. skyboxModel)
    SetSkyModel(skyboxModel)
    skyboxId = skyboxId + 1
    skyboxId = skyboxId % #SKYBOXES
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

    local trig4 = CreateTrigger()
    BlzTriggerRegisterPlayerKeyEvent(trig4, Player(0), OSKEY_SUBTRACT, 0, true)
    TriggerAddAction(trig4, debugMinus)

    local trig5 = CreateTrigger()
    BlzTriggerRegisterPlayerKeyEvent(trig5, Player(0), OSKEY_ADD, 0, true)
    TriggerAddAction(trig5, debugAdd)

    local giveItemTrig = CreateTrigger()
    TriggerRegisterPlayerChatEvent(giveItemTrig, Player(0), "-g", false)
    TriggerAddAction(giveItemTrig, onGiveItem)
end

return {
    init = init,
}
