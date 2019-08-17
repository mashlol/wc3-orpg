-- Inits the various UI modules and calls their updates
-- Also hides the default blizz UI
local hero = require('src/hero.lua')
local target = require('src/target.lua')

-- UI Modules
local CastBar = require('src/ui/castbar.lua')
local UnitFrame = require('src/ui/unitframe.lua')
local ActionBar = require('src/ui/actionbar.lua')

local UI_MODULES = {
    actionbar = ActionBar:new(),
    castbar = CastBar:new(),
    targetframe = UnitFrame:new{xLoc = 0.54, forTarget = true},
    heroframe = UnitFrame:new{xLoc = 0.26, forTarget = false},
}

function hideBlizzUI()
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
