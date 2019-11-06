-- Inits the various UI modules and calls their updates
-- Also hides the default blizz UI
local hero = require('src/hero.lua')
local target = require('src/target.lua')
local consts = require('src/ui/consts.lua')

-- UI Modules
local CastBar = require('src/ui/castbar.lua')
local Dialog = require('src/ui/dialog.lua')
local Vendor = require('src/ui/vendor.lua')
local QuestLog = require('src/ui/questlog.lua')
local MenuButtons = require('src/ui/menubuttons.lua')
local SimpleButton = require('src/ui/simplebutton.lua')
local ExpBar = require('src/ui/expbar.lua')
local UnitFrame = require('src/ui/unitframe.lua')
local ActionBar = require('src/ui/actionbar.lua')
local ItemBar = require('src/ui/itembar.lua')
local Backpack = require('src/ui/backpack.lua')
local Stats = require('src/ui/stats.lua')
local Equipment = require('src/ui/equipment.lua')
local LootRoll = require('src/ui/lootroll.lua')
local Map = require('src/ui/map.lua')
local HeroSelect = require('src/ui/heroselect.lua')
local DpsMeter = require('src/ui/dpsmeter.lua')

local UI_MODULES = {
    ActionBar:new(),
    ItemBar:new(),
    CastBar:new(),
    ExpBar:new(),
    MenuButtons:new(),
    SimpleButton:new(),
    UnitFrame:new{
        xLoc = 0.595,
        yLoc = 0.03,
        width = consts.BAR_WIDTH * 2 / 4 + 0.026,
        forTarget = true,
        buffSize = consts.BUFF_ICON_SIZE,
    },
    UnitFrame:new{
        xLoc = 0.215,
        yLoc = 0.03,
        width = consts.BAR_WIDTH * 2 / 4 + 0.026,
        forTarget = false,
        buffSize = consts.BUFF_ICON_SIZE,
    },
    Backpack:new(),
    DpsMeter:new(),
}

for i=0,9,1 do
    local xloC = math.floor(i / 5) * (consts.BAR_WIDTH / 3 + 0.005)

    table.insert(UI_MODULES, UnitFrame:new{
        xLoc = xloC,
        yLoc = 0.5 - (consts.BAR_HEIGHT * 4 - consts.BUFF_ICON_SIZE / 2 + 0.005) * (i % 5),
        anchor = FRAMEPOINT_TOPLEFT,
        forTarget = false,
        forParty = i,
        showCastBar = false,
        width = consts.BAR_WIDTH / 3,
        height = consts.BAR_HEIGHT * 4 - consts.BUFF_ICON_SIZE / 2,
        buffSize = consts.BUFF_ICON_SIZE / 2,
    })
end

table.insert(UI_MODULES, Stats:new())
table.insert(UI_MODULES, Equipment:new())
table.insert(UI_MODULES, QuestLog:new())
table.insert(UI_MODULES, Vendor:new())
table.insert(UI_MODULES, LootRoll:new())
table.insert(UI_MODULES, Map:new())
table.insert(UI_MODULES, HeroSelect:new())
table.insert(UI_MODULES, Dialog:new())

function hideBlizzUI()
    BlzHideOriginFrames(true)

    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    local worldFrame = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)
    BlzFrameSetAllPoints(worldFrame, originFrame)

    local commandFrame = BlzGetOriginFrame(ORIGIN_FRAME_COMMAND_BUTTON, 1)
    local parentCommandFrame = BlzFrameGetParent(commandFrame)
    BlzFrameClearAllPoints(parentCommandFrame)
    BlzFrameSetAbsPoint(parentCommandFrame, FRAMEPOINT_TOPLEFT, -1, -1)

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
    BlzLoadTOCFile("war3mapimported\\Tooltip.toc")

    for _, mod in pairs(UI_MODULES) do
        mod:init()
    end
end

function updateCustomUI()
    local playerId = GetPlayerId(GetLocalPlayer())
    local heroUnit = hero.getHero(playerId)
    local targetUnit = target.getTarget(playerId)

    for _, mod in pairs(UI_MODULES) do
        mod.hero = heroUnit
        mod.target = targetUnit
        mod.playerId = playerId
        mod:update(playerId)
    end
end

function init()
    hideBlizzUI()
    initCustomUI()

    TimerStart(CreateTimer(), 0.03125, true, updateCustomUI)
end

return {
    init = init,
}
