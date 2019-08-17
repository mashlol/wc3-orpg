-- Inits the various UI modules and calls their updates
-- Also hides the default blizz UI
local hero = require('src/hero.lua')
local target = require('src/target.lua')

-- UI Modules
local castbar = require('src/ui/castbar.lua')
local unitframe = require('src/ui/unitframe.lua')
local actionbar = require('src/ui/actionbar.lua')

local UI_MODULES = {
    castbar = {
        module = castbar,
    },
    heroframe = {
        module = unitframe,
        unit = 'hero',
        xLoc = 0.26,
    },
    targetframe = {
        module = unitframe,
        unit = 'target',
        xLoc = 0.54,
    },
    actionbar = {
        module = actionbar,
    },
}

local uiFrames = {}

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
        uiFrames[name] = mod.module.init(mod.xLoc or 0, mod.yLoc or 0)
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
        mod.module.update(
            uiFrames[name],
            playerId,
            mod.unit == 'hero' and heroUnit or targetUnit)
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
