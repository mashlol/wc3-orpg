local hero = require('src/hero.lua')
local target = require('src/target.lua')

local ACTION_ITEM_SIZE = 0.04
local BAR_WIDTH = ACTION_ITEM_SIZE * 5
local BAR_HEIGHT = 0.01

local TEMP_ICONS = {
    "ReplaceableTextures\\CommandButtons\\BTNEnchantedGemstone.blp",
    "ReplaceableTextures\\CommandButtons\\BTNAbsorbMagic.blp",
    "ReplaceableTextures\\CommandButtons\\BTNAcidBomb.blp",
    "ReplaceableTextures\\CommandButtons\\BTNAmbushDay.blp",
    "ReplaceableTextures\\CommandButtons\\BTNBash.blp",
    "ReplaceableTextures\\CommandButtons\\BTNBattleRoar.blp",
    "ReplaceableTextures\\CommandButtons\\BTNBearBlink.blp",
    "ReplaceableTextures\\CommandButtons\\BTNBlink.blp",
    "ReplaceableTextures\\CommandButtons\\BTNBreathOfFrost.blp",
    "ReplaceableTextures\\CommandButtons\\BTNCarrionSwarm.blp",
    "ReplaceableTextures\\CommandButtons\\BTNCharm.blp",
    "ReplaceableTextures\\CommandButtons\\BTNClusterRockets.blp",
}

local DEFAULT_HOTKEYS = {
    "Q", "W", "E", "R",
    "A", "S", "D", "F",
    "Z", "X", "C", "V"
}

local myFrames
local targetFrames

local hideBlizzUI = function()
    BlzHideOriginFrames(true)

    local worldFrame = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)
    BlzFrameSetAllPoints(worldFrame, BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0))

    for i=0,11,1 do
        local commandFrame = BlzGetOriginFrame(ORIGIN_FRAME_COMMAND_BUTTON, i)
        BlzFrameClearAllPoints(commandFrame)
        BlzFrameSetAbsPoint(commandFrame, FRAMEPOINT_TOPLEFT, 0, 0)
    end

    local miniMapFrame = BlzGetOriginFrame(ORIGIN_FRAME_MINIMAP, 0)
    BlzFrameSetVisible(miniMapFrame, true)
end

local initUnitFrame = function(xLoc)
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local healthBarFrameBackground = BlzCreateFrameByType(
        "BACKDROP",
        "healthBarFrameBackground",
        originFrame,
        "",
        0)
    BlzFrameSetSize(healthBarFrameBackground, BAR_WIDTH, BAR_HEIGHT)
    BlzFrameSetAbsPoint(
        healthBarFrameBackground,
        FRAMEPOINT_CENTER,
        xLoc,
        ACTION_ITEM_SIZE + BAR_HEIGHT * 5)
    BlzFrameSetTexture(
        healthBarFrameBackground,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)

    local healthBarFrameFilled = BlzCreateFrameByType(
        "BACKDROP",
        "healthBarFrameFilled",
        originFrame,
        "",
        0)
    BlzFrameSetSize(healthBarFrameFilled, BAR_WIDTH, BAR_HEIGHT)
    BlzFrameSetPoint(
        healthBarFrameFilled,
        FRAMEPOINT_LEFT,
        healthBarFrameBackground,
        FRAMEPOINT_LEFT,
        0,
        0)
    BlzFrameSetTexture(
        healthBarFrameFilled,
        "Replaceabletextures\\Teamcolor\\Teamcolor06.blp",
        0,
        true)

    local energyBarFrameBackground = BlzCreateFrameByType(
        "BACKDROP",
        "energyBarFrameBackground",
        originFrame,
        "",
        0)
    BlzFrameSetSize(energyBarFrameBackground, BAR_WIDTH, BAR_HEIGHT)
    BlzFrameSetAbsPoint(
        energyBarFrameBackground,
        FRAMEPOINT_CENTER,
        xLoc,
        ACTION_ITEM_SIZE + BAR_HEIGHT * 4)
    BlzFrameSetTexture(
        energyBarFrameBackground,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)

    local energyBarFrameFilled = BlzCreateFrameByType(
        "BACKDROP",
        "energyBarFrameFilled",
        originFrame,
        "",
        0)
    BlzFrameSetSize(energyBarFrameFilled, BAR_WIDTH, BAR_HEIGHT)
    BlzFrameSetPoint(
        energyBarFrameFilled,
        FRAMEPOINT_LEFT,
        energyBarFrameBackground,
        FRAMEPOINT_LEFT,
        0,
        0)
    BlzFrameSetTexture(
        energyBarFrameFilled,
        "Replaceabletextures\\Teamcolor\\Teamcolor01.blp",
        0,
        true)

    return {
        healthBar = healthBarFrameFilled,
        energyBar = energyBarFrameFilled,
    }
end

local initActionBar = function()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local actionBar = BlzCreateFrameByType(
        "FRAME",
        "actionBar",
        originFrame,
        "",
        0)
    BlzFrameSetSize(actionBar, ACTION_ITEM_SIZE * 12, ACTION_ITEM_SIZE)
    BlzFrameSetAbsPoint(actionBar, FRAMEPOINT_CENTER, 0.4, ACTION_ITEM_SIZE)

    for i=0,11,1 do
        local actionItem = BlzCreateFrameByType(
            "BACKDROP",
            "actionItem",
            BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),
            "",
            0)
        BlzFrameSetSize(actionItem, ACTION_ITEM_SIZE, ACTION_ITEM_SIZE)
        BlzFrameSetPoint(
            actionItem,
            FRAMEPOINT_LEFT,
            actionBar,
            FRAMEPOINT_LEFT,
            i * ACTION_ITEM_SIZE,
            0)
        BlzFrameSetTexture(
            actionItem,
            TEMP_ICONS[i+1],
            0,
            true)

        local actionCooldownBackdrop = BlzCreateFrameByType(
            "BACKDROP",
            "actionCooldownBackdrop",
            actionItem,
            "",
            0)
        BlzFrameSetSize(
            actionCooldownBackdrop, ACTION_ITEM_SIZE, ACTION_ITEM_SIZE / 2)
        BlzFrameSetPoint(
            actionCooldownBackdrop,
            FRAMEPOINT_BOTTOM,
            actionItem,
            FRAMEPOINT_BOTTOM,
            0,
            0)
        BlzFrameSetTexture(
            actionCooldownBackdrop,
            "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
            0,
            true)
        BlzFrameSetAlpha(actionCooldownBackdrop, 200)

        local actionTintBackdrop = BlzCreateFrameByType(
            "BACKDROP",
            "actionTintBackdrop",
            actionItem,
            "",
            0)
        BlzFrameSetSize(
            actionTintBackdrop, ACTION_ITEM_SIZE, ACTION_ITEM_SIZE)
        BlzFrameSetPoint(
            actionTintBackdrop,
            FRAMEPOINT_BOTTOM,
            actionItem,
            FRAMEPOINT_BOTTOM,
            0,
            0)
        BlzFrameSetTexture(
            actionTintBackdrop,
            "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
            0,
            true)
        BlzFrameSetAlpha(actionTintBackdrop, 60)

        local actionHotkey = BlzCreateFrameByType(
            "TEXT",
            "actionItemHotkey",
            actionItem,
            "",
            0)
        BlzFrameSetSize(actionHotkey, 0.01, 0.01)
        BlzFrameSetText(actionHotkey, DEFAULT_HOTKEYS[i+1])
        BlzFrameSetPoint(
            actionHotkey,
            FRAMEPOINT_TOP_LEFT,
            actionItem,
            FRAMEPOINT_TOP_LEFT,
            0.002,
            -0.002)

         local actionCooldownText = BlzCreateFrameByType(
            "TEXT",
            "actionCooldownText",
            actionItem,
            "",
            0)
        BlzFrameSetSize(actionCooldownText, ACTION_ITEM_SIZE, ACTION_ITEM_SIZE)
        BlzFrameSetText(actionCooldownText, "3m")
        BlzFrameSetPoint(
            actionCooldownText,
            FRAMEPOINT_CENTER,
            actionItem,
            FRAMEPOINT_CENTER,
            0,
            0)
        BlzFrameSetTextAlignment(
            actionCooldownText, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)
    end
end

local initCustomUI = function()
    initActionBar()
    myFrames = initUnitFrame(0.26)
    targetFrames = initUnitFrame(0.54)
end

local updateUnitFrame = function(unit, frames)
    if unit == nil then
        -- TODO hide frames
    else
        local hp = BlzGetUnitRealField(unit, UNIT_RF_HP)
        local maxHp = BlzGetUnitMaxHP(unit)
        local mana = BlzGetUnitRealField(unit, UNIT_RF_MANA)
        local maxMana = BlzGetUnitMaxMana(unit)

        if maxHp ~= 0 then
            BlzFrameSetSize(frames.healthBar, BAR_WIDTH * hp / maxHp, BAR_HEIGHT)
        else
            BlzFrameSetSize(frames.healthBar, 0, BAR_HEIGHT)
        end
        if maxMana ~= 0 then
            BlzFrameSetSize(frames.energyBar, BAR_WIDTH * mana / maxMana, BAR_HEIGHT)
        else
            BlzFrameSetSize(frames.energyBar, 0, BAR_HEIGHT)
        end
    end
end

local updateCustomUI = function()
    -- Loops and updates the custom UI values
    local playerId = GetPlayerId(GetLocalPlayer())
    local hero = hero.getHero(playerId)
    local target = target.getTarget(playerId)

    updateUnitFrame(hero, myFrames)
    updateUnitFrame(target, targetFrames)
end

local init = function()
    hideBlizzUI()
    initCustomUI()

    TimerStart(CreateTimer(), 0.03125, true, updateCustomUI)
end

return {
    init = init,
}
