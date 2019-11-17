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

    utils.createBorderFrame(talentsOrigin, "TALENTS")

    local unspentPointsText = BlzCreateFrameByType(
        "TEXT",
        "unspentPointsText",
        talentsOrigin,
        "",
        0)
    BlzFrameSetSize(unspentPointsText, consts.TALENTS_WIDTH, 0.012)
    BlzFrameSetPoint(
        unspentPointsText,
        FRAMEPOINT_BOTTOM,
        talentsOrigin,
        FRAMEPOINT_BOTTOM,
        -0.01,
        0.01)
    BlzFrameSetTextAlignment(
        unspentPointsText, TEXT_JUSTIFY_BOTTOM, TEXT_JUSTIFY_RIGHT)
    BlzFrameSetText(unspentPointsText, "0 Unspent Talent Points")

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
            local talentIconOrigin = BlzCreateFrameByType(
                "FRAME",
                "talentIcon",
                talentsOrigin,
                "",
                0)
            BlzFrameSetSize(
                talentIconOrigin,
                consts.TALENT_ICON_SIZE,
                consts.TALENT_ICON_SIZE)
            BlzFrameSetPoint(
                talentIconOrigin,
                FRAMEPOINT_TOPLEFT,
                talentsOrigin,
                FRAMEPOINT_TOPLEFT,
                EDGE_PADDING + (iconHorizontalPadding + consts.TALENT_ICON_SIZE) * x,
                -EDGE_PADDING - (iconVerticalPadding + consts.TALENT_ICON_SIZE) * y)

            local talentDependencyLine = BlzCreateFrameByType(
                "BACKDROP",
                "talentDependencyLine",
                talentIconOrigin,
                "",
                0)
            BlzFrameSetSize(
                talentDependencyLine,
                consts.TALENT_ICON_SIZE / 5,
                consts.TALENT_ICON_SIZE + iconVerticalPadding)
            BlzFrameSetPoint(
                talentDependencyLine,
                FRAMEPOINT_TOP,
                talentIconOrigin,
                FRAMEPOINT_TOP,
                0,
                0)
            BlzFrameSetTexture(
                talentDependencyLine,
                "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
                0,
                true)

            local talentIcon = BlzCreateFrameByType(
                "BACKDROP",
                "talentIcon",
                talentIconOrigin,
                "",
                0)
            BlzFrameSetAllPoints(talentIcon, talentIconOrigin)

            local backdropTint = BlzCreateFrameByType(
                "BACKDROP",
                "backdropTint",
                talentIconOrigin,
                "",
                0)
            BlzFrameSetAllPoints(backdropTint, talentIconOrigin)
            BlzFrameSetTexture(
                backdropTint,
                "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
                0,
                true)
            BlzFrameSetAlpha(backdropTint, 150)

            local numLearnedText = BlzCreateFrameByType(
                "TEXT",
                "numLearnedText",
                talentIconOrigin,
                "",
                0)
            BlzFrameSetAllPoints(numLearnedText, talentIconOrigin)
            BlzFrameSetTextAlignment(
                numLearnedText, TEXT_JUSTIFY_BOTTOM, TEXT_JUSTIFY_RIGHT)
            BlzFrameSetText(numLearnedText, "0")

            local hoverFrame = BlzCreateFrameByType(
                "GLUEBUTTON",
                "hoverFrame",
                talentIconOrigin,
                "IconButtonTemplate",
                0)

            local tooltipFrame = tooltip.makeTooltipFrame(
                talentIconOrigin, 0.16, 0.08, hoverFrame, true)

            uieventhandler.registerClickEvent(hoverFrame, function(playerId)
                talents.learnTalent(playerId, x, y)
            end)

            talentIconFrames[x][y] = {
                origin = talentIconOrigin,
                icon = talentIcon,
                tooltip = tooltipFrame,
                numLearnedText = numLearnedText,
                backdropTint = backdropTint,
                talentDependencyLine = talentDependencyLine,
                hoverFrame = hoverFrame,
            }
        end
    end

    utils.createCloseButton(talentsOrigin, function(playerId)
        talentToggles[playerId] = nil
    end)

    self.frames = {
        origin = talentsOrigin,
        talentIconFrames = talentIconFrames,
        unspentPointsText = unspentPointsText,
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

    local unspentPoints = talents.getUnspentTalentPoints(playerId)
    BlzFrameSetText(
        frames.unspentPointsText, unspentPoints .. " Unspent Talent Points")

    local filledEntries = {}
    local entriesForPrereq = {}

    for x=0,NUM_COLS-1,1 do
        filledEntries[x] = {}
        entriesForPrereq[x] = {}
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

            if talentInfo.prerequisite ~= nil then
                local prereqRow = talentInfo.prerequisite.row
                local prereqCol = talentInfo.prerequisite.col

                for row = y-1, prereqRow, -1 do
                    entriesForPrereq[prereqCol][row] = true
                end
            end

            filledEntries[x][y] = true
        end
    end

    for x=0,NUM_COLS-1,1 do
        for y=0,NUM_ROWS-1,1 do
            if not filledEntries[x][y] and not entriesForPrereq[x][y] then
                local iconFrame = frames.talentIconFrames[x][y]
                BlzFrameSetVisible(iconFrame.origin, false)
            elseif entriesForPrereq[x][y] then
                local iconFrame = frames.talentIconFrames[x][y]
                BlzFrameSetVisible(iconFrame.origin, true)
                BlzFrameSetVisible(iconFrame.talentDependencyLine, true)
                if availableTalents[y] ~= nil and availableTalents[y][x] ~= nil then
                    BlzFrameSetVisible(iconFrame.backdropTint, true)
                    BlzFrameSetVisible(iconFrame.numLearnedText, true)
                    BlzFrameSetVisible(iconFrame.hoverFrame, true)
                    BlzFrameSetVisible(iconFrame.icon, true)
                else
                    BlzFrameSetVisible(iconFrame.backdropTint, false)
                    BlzFrameSetVisible(iconFrame.numLearnedText, false)
                    BlzFrameSetVisible(iconFrame.hoverFrame, false)
                    BlzFrameSetVisible(iconFrame.icon, false)
                end
            else
                local iconFrame = frames.talentIconFrames[x][y]
                BlzFrameSetVisible(iconFrame.talentDependencyLine, false)
            end
        end
    end
end

return Talents
