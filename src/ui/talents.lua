local consts = require('src/ui/consts.lua')
local utils = require('src/ui/utils.lua')
local hero = require('src/hero.lua')
local talents = require('src/talents.lua')
local tooltip = require('src/ui/tooltip.lua')
local uieventhandler = require('src/ui/uieventhandler.lua')

local EDGE_PADDING = 0.02

local NUM_COLS = 5
local NUM_ROWS = 5

-- talentToggles = {
--     [playerId] = true or nil
-- }
local talentToggles = {}

local Talents = {
    toggle = function(playerId)
        talentToggles[playerId] = not talentToggles[playerId]
    end
}

function Talents:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Talents:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local talentsOrigin = BlzCreateFrameByType(
        "FRAME",
        "talentsOrigin",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        talentsOrigin,
        consts.TALENTS_WIDTH,
        consts.TALENTS_HEIGHT)
    BlzFrameSetAbsPoint(
        talentsOrigin,
        FRAMEPOINT_CENTER,
        0.4,
        0.35)

    utils.createBorderFrame(talentsOrigin)

    local talentText = BlzCreateFrameByType(
        "TEXT",
        "talentText",
        talentsOrigin,
        "",
        0)
    BlzFrameSetSize(talentText, consts.TALENTS_WIDTH, 0.012)
    BlzFrameSetPoint(
        talentText,
        FRAMEPOINT_TOPLEFT,
        talentsOrigin,
        FRAMEPOINT_TOPLEFT,
        0.01,
        -0.01)
    BlzFrameSetText(talentText, "Talents")

    local widthWithoutPadding = consts.TALENTS_WIDTH - EDGE_PADDING * 2
    local talentIconSize = consts.TALENT_ICON_SIZE * NUM_COLS
    local remainingSize = widthWithoutPadding - talentIconSize
    local iconHorizontalPadding = remainingSize / (NUM_COLS - 1)

    local heightWithoutPadding = consts.TALENTS_HEIGHT - EDGE_PADDING * 2
    local talentIconHeight = consts.TALENT_ICON_SIZE * NUM_ROWS
    local remainingHeight = heightWithoutPadding - talentIconHeight
    local iconVerticalPadding = remainingHeight / (NUM_ROWS - 1)

    local talentIconFrames = {}
    for x=0,NUM_COLS-1,1 do
        talentIconFrames[x] = {}
        for y=0,NUM_ROWS-1,1 do
            local talentIcon = BlzCreateFrameByType(
                "BACKDROP",
                "talentIcon",
                talentsOrigin,
                "",
                0)
            BlzFrameSetSize(
                talentIcon,
                consts.TALENT_ICON_SIZE,
                consts.TALENT_ICON_SIZE)
            BlzFrameSetPoint(
                talentIcon,
                FRAMEPOINT_TOPLEFT,
                talentsOrigin,
                FRAMEPOINT_TOPLEFT,
                EDGE_PADDING + (iconHorizontalPadding + consts.TALENT_ICON_SIZE) * x,
                -EDGE_PADDING - (iconVerticalPadding + consts.TALENT_ICON_SIZE) * y)

            local backdropTint = BlzCreateFrameByType(
                "BACKDROP",
                "backdropTint",
                talentIcon,
                "",
                0)
            BlzFrameSetAllPoints(backdropTint, talentIcon)
            BlzFrameSetTexture(
                backdropTint,
                "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
                0,
                true)
            BlzFrameSetAlpha(backdropTint, 150)

            local numLearnedText = BlzCreateFrameByType(
                "TEXT",
                "numLearnedText",
                talentIcon,
                "",
                0)
            BlzFrameSetAllPoints(numLearnedText, talentIcon)
            BlzFrameSetTextAlignment(
                numLearnedText, TEXT_JUSTIFY_BOTTOM, TEXT_JUSTIFY_RIGHT)
            BlzFrameSetText(numLearnedText, "0")

            local hoverFrame = BlzCreateFrameByType(
                "GLUEBUTTON",
                "hoverFrame",
                talentIcon,
                "IconButtonTemplate",
                0)

            local tooltipFrame = tooltip.makeTooltipFrame(
                talentIcon, 0.16, 0.08, hoverFrame, true)

            uieventhandler.registerClickEvent(hoverFrame, function(playerId, button)
                talents.learnTalent(playerId, x, y)
            end)

            talentIconFrames[x][y] = {
                origin = talentIcon,
                icon = talentIcon,
                tooltip = tooltipFrame,
                numLearnedText = numLearnedText,
                backdropTint = backdropTint,
            }
        end
    end

    self.frames = {
        origin = talentsOrigin,
        talentIconFrames = talentIconFrames,
    }

    return self
end

function Talents:update(playerId)
    local frames = self.frames

    local heroUnit = hero.getHero(playerId)
    local heroTypeId = GetUnitTypeId(heroUnit)
    local availableTalents = talents.TALENTS[heroTypeId]

    local showFrame =
        talentToggles[playerId] == true and
        heroUnit ~= nil and
        availableTalents ~= nil
    BlzFrameSetVisible(frames.origin, showFrame)

    if not showFrame then
        return
    end

    local filledEntries = {}

    for x=0,NUM_COLS-1,1 do
        filledEntries[x] = {}
    end

    -- Loop through the talents available for the hero type that is selected
    for y, cols in pairs(availableTalents) do
        for x, talentInfo in pairs(cols) do
            local iconFrame = frames.talentIconFrames[x][y]
            local numPointsInTalent = talents.getNumPointsInTalent(
                playerId, x, y)
            BlzFrameSetVisible(iconFrame.origin, true)
            BlzFrameSetTexture(iconFrame.icon, talentInfo.icon, 0, true)
            BlzFrameSetText(
                iconFrame.numLearnedText,
                numPointsInTalent ..
                    '/' ..
                    talents.getTalentMaxLevel(playerId, x, y))

            if numPointsInTalent > 0 then
                BlzFrameSetAlpha(iconFrame.backdropTint, 55)
            elseif talents.canLearnTalent(playerId, x, y) then
                BlzFrameSetAlpha(iconFrame.backdropTint, 150)
            else
                BlzFrameSetAlpha(iconFrame.backdropTint, 235)
            end

            local tooltipText = "|cff1c85e8" .. talentInfo.name .. "|r|n|n" .. talentInfo.description
            BlzFrameSetText(iconFrame.tooltip.text, tooltipText)

            filledEntries[x][y] = true
        end
    end

    for x=0,NUM_COLS-1,1 do
        for y=0,NUM_ROWS-1,1 do
            if not filledEntries[x][y] then
                local iconFrame = frames.talentIconFrames[x][y]
                BlzFrameSetVisible(iconFrame.origin, false)
            end
        end
    end
end

return Talents
