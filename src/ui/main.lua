-- Inits the various UI modules and calls their updates
-- Also hides the default blizz UI
local hero = require('src/hero.lua')
local target = require('src/target.lua')
local consts = require('src/ui/consts.lua')

-- UI Modules
local CastBar = require('src/ui/castbar.lua')
local UnitFrame = require('src/ui/unitframe.lua')
local ActionBar = require('src/ui/actionbar.lua')

local UI_MODULES = {
    ActionBar:new(),
    CastBar:new(),
    UnitFrame:new{
        xLoc = 0.54,
        yLoc = consts.ACTION_ITEM_SIZE + consts.BAR_HEIGHT * 5,
        forTarget = true,
    },
    UnitFrame:new{
        xLoc = 0.26,
        yLoc = consts.ACTION_ITEM_SIZE + consts.BAR_HEIGHT * 5,
        forTarget = false,
    },
}

for i=0,9,1 do
    local xloC = i % 2 * (consts.BAR_WIDTH / 2 + 0.005)

    table.insert(UI_MODULES, UnitFrame:new{
        xLoc = xloC,
        yLoc = 0.5 - (consts.BAR_HEIGHT * 5 + 0.005) * (i - i % 2) / 2,
        anchor = FRAMEPOINT_TOPLEFT,
        forTarget = false,
        forParty = i,
        width = consts.BAR_WIDTH / 2,
    })
end

function hideBlizzUI()
    BlzHideOriginFrames(true)

    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    local worldFrame = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)
    BlzFrameSetAllPoints(worldFrame, originFrame)

    for i=0,11,1 do
        local commandFrame = BlzGetOriginFrame(ORIGIN_FRAME_COMMAND_BUTTON, i)
        BlzFrameClearAllPoints(commandFrame)
        BlzFrameSetAbsPoint(commandFrame, FRAMEPOINT_TOPLEFT, 0, 0)
    end

    local miniMapFrame = BlzGetOriginFrame(ORIGIN_FRAME_MINIMAP, 0)

    local miniMapBackdrop = BlzCreateFrameByType(
        "BACKDROP",
        "miniMapBackdrop",
        originFrame,
        "",
        0)
    BlzFrameSetAllPoints(miniMapBackdrop, miniMapFrame)
    BlzFrameSetTexture(
        miniMapBackdrop,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)

    BlzFrameSetVisible(miniMapFrame, true)
    BlzFrameSetParent(miniMapFrame, miniMapBackdrop)
end

function initCustomUI()
    for name, mod in pairs(UI_MODULES) do
        mod:init()
    end
end

function updateCustomUI()
    local playerId = GetPlayerId(GetLocalPlayer())
    local heroUnit = hero.getHero(playerId)
    local targetUnit = target.getTarget(playerId)

    SelectUnit(
        heroUnit,
        true)

    for name, mod in pairs(UI_MODULES) do
        mod.hero = heroUnit
        mod.target = targetUnit
        mod.playerId = playerId
        mod:update(playerId)
    end

    target.updateTargetEffectLocations()
end

function init()
    hideBlizzUI()
    initCustomUI()

    TimerStart(CreateTimer(), 0.0078125, true, updateCustomUI)
end

return {
    init = init,
}
