local hero = require('src/hero.lua')

local ACTION_ITEM_SIZE = 0.04
local BAR_WIDTH = ACTION_ITEM_SIZE * 5
local BAR_HEIGHT = 0.01

local TEMP_ICONS = {
    "ReplaceableTextures\\CommandButtons\\BTNAbomination",
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
    end
end

local initCustomUI = function()
    initActionBar()
    myFrames = initUnitFrame(0.26)
    targetFrames = initUnitFrame(0.54)
end

local updateCustomUI = function()
    -- Loops and updates the custom UI values
    local hero = hero.getHero(GetPlayerId(GetLocalPlayer()))
    local hp = BlzGetUnitRealField(hero, UNIT_RF_HP)
    local maxHp = BlzGetUnitMaxHP(hero)
    local mana = BlzGetUnitRealField(hero, UNIT_RF_MANA)
    local maxMana = BlzGetUnitMaxMana(hero)

    BlzFrameSetSize(myFrames.healthBar, BAR_WIDTH * hp / maxHp, BAR_HEIGHT)
    BlzFrameSetSize(myFrames.energyBar, BAR_WIDTH * mana / maxMana, BAR_HEIGHT)
end

local init = function()
    hideBlizzUI()
    initCustomUI()

    TimerStart(CreateTimer(), 0.03125, true, updateCustomUI)
end

return {
    init = init,
}
