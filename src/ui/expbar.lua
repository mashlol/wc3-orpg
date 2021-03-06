local consts = require('src/ui/consts.lua')
local hero = require('src/hero.lua')

local ExpBar = {}

-- Generated with:
-- function getRequiredExp(level)
--     if level == 1 then
--         return 20
--     end
--     return getRequiredExp(level - 1) + (level + 1) * 10
-- end

-- for i=1,60,1 do
--     print(getRequiredExp(i)..',')
-- end
local EXP_REQUIRED = {
    0,
    20,
    50,
    90,
    140,
    200,
    270,
    350,
    440,
    540,
    650,
    770,
    900,
    1040,
    1190,
    1350,
    1520,
    1700,
    1890,
    2090,
    2300,
    2520,
    2750,
    2990,
    3240,
    3500,
    3770,
    4050,
    4340,
    4640,
    4950,
    5270,
    5600,
    5940,
    6290,
    6650,
    7020,
    7400,
    7790,
    8190,
    8600,
    9020,
    9450,
    9890,
    10340,
    10800,
    11270,
    11750,
    12240,
    12740,
    13250,
    13770,
    14300,
    14840,
    15390,
    15950,
    16520,
    17100,
    17690,
    18290,
    18900,
}

function ExpBar:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function ExpBar:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local expBarFrameBackground = BlzCreateFrameByType(
        "BACKDROP",
        "expBarFrameBackground",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        expBarFrameBackground, consts.EXP_BAR_WIDTH, consts.EXP_BAR_WIDTH * 75 / 1232)
    BlzFrameSetAbsPoint(
        expBarFrameBackground,
        FRAMEPOINT_BOTTOM,
        0.401,
        0)
    BlzFrameSetTexture(
        expBarFrameBackground,
        "war3mapImported\\ui\\loading_bar_empty.blp",
        0,
        true)

    local expBarFrameFilled = BlzCreateFrameByType(
        "BACKDROP",
        "expBarFrameFilled",
        expBarFrameBackground,
        "",
        0)
    BlzFrameSetSize(
        expBarFrameFilled, consts.EXP_BAR_WIDTH, consts.EXP_BAR_WIDTH * 46 / 1232)
    BlzFrameSetPoint(
        expBarFrameFilled,
        FRAMEPOINT_LEFT,
        expBarFrameBackground,
        FRAMEPOINT_LEFT,
        0,
        0)
    BlzFrameSetTexture(
        expBarFrameFilled,
        "war3mapImported\\ui\\loading_bar_fill.blp",
        0,
        true)

    local expBarStatusText = BlzCreateFrameByType(
        "TEXT",
        "expBarStatusText",
        expBarFrameBackground,
        "",
        0)
    BlzFrameSetAllPoints(expBarStatusText, expBarFrameBackground)
    BlzFrameSetTextAlignment(
        expBarStatusText, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)
    BlzFrameSetScale(expBarStatusText, 0.65)

    self.frames = {
        expBar = expBarFrameFilled,
        text = expBarStatusText,
        origin = expBarFrameBackground,
    }

    return self
end

function ExpBar:update()
    local frame = self.frames
    local hero = self.hero

    local isVisible = hero ~= nil
    BlzFrameSetVisible(frame.origin, isVisible)

    if not isVisible then
        return
    end

    if hero ~= nil then
        local curLevel = GetHeroLevel(hero)
        local curExperience = GetHeroXP(hero) - EXP_REQUIRED[curLevel]
        local requiredExperience = EXP_REQUIRED[curLevel + 1] - EXP_REQUIRED[curLevel]

        BlzFrameSetText(frame.text, 'XP: ' .. curExperience .. ' / ' .. requiredExperience)

        if curExperience == 0 then
            BlzFrameSetSize(
                frame.expBar,
                0.00001,
                consts.EXP_BAR_HEIGHT)
        else
            BlzFrameSetSize(
                frame.expBar,
                (curExperience / requiredExperience) * consts.EXP_BAR_WIDTH,
                consts.EXP_BAR_HEIGHT)
        end
    else
        BlzFrameSetSize(
            frame.expBar,
            0.00001,
            consts.EXP_BAR_HEIGHT)
    end
end

return ExpBar
