local utils = require('src/ui/utils.lua')
local zones = require('src/zones.lua')
local quests = require('src/quests/main.lua')
local uieventhandler = require('src/ui/uieventhandler.lua')

local PADDING = 0.015
local WIDTH = 0.6
local HEIGHT = 0.4

-- KEYS MUST MATCH ZONE NAMES IN `zones.lua`
local MAPS = {
    FREYDELL = {
        minX = -741.7,
        minY = -4912.8,
        maxX = 3474.6,
        maxY = -2272.2,
        mapFile = "war3mapImported\\freydell.blp",
        mapAspectRatio = 1.66919191919,
    },
}

local ENTIRE_MAP_INFO = {
    minX = -30208,
    minY = -21235,
    maxX = 31229,
    maxY = 24101,
    mapFile = "war3mapImported\\entire_map.blp",
    mapAspectRatio = 1.4210019267,
}

-- mapToggles = {
--     [playerId] = {
--         zoomedOut = false,
--     },
-- }
local mapToggles = {}

local Map = {
    toggle = function(playerId)
        if mapToggles[playerId] ~= nil then
            mapToggles[playerId] = nil
        else
            mapToggles[playerId] = {zoomedOut = false}
        end
    end,
}

function Map:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Map:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local mapOrigin = BlzCreateFrameByType(
        "FRAME", "mapOrigin", originFrame, "", 0)
    BlzFrameSetSize(mapOrigin, WIDTH + PADDING, HEIGHT + PADDING)
    BlzFrameSetPoint(
        mapOrigin, FRAMEPOINT_CENTER, originFrame, FRAMEPOINT_CENTER, 0, 0.07)
    utils.createBorderFrame(mapOrigin)

    local mapFrame = BlzCreateFrameByType("BACKDROP", "map", mapOrigin, "", 0)
    BlzFrameSetSize(mapFrame, WIDTH, HEIGHT)
    BlzFrameSetPoint(
        mapFrame, FRAMEPOINT_CENTER, mapOrigin, FRAMEPOINT_CENTER, 0, 0)

    local yourPosFrame = BlzCreateFrameByType("SPRITE", "pos", mapFrame, "", 0)
    BlzFrameSetSize(yourPosFrame, 0.01, 0.01)
    BlzFrameSetPoint(
        yourPosFrame, FRAMEPOINT_CENTER, mapFrame, FRAMEPOINT_BOTTOMLEFT, 0, 0)
    BlzFrameSetModel(yourPosFrame, "ui\\minimap\\minimap-ping.mdx", 0)
    BlzFrameSetVertexColor(yourPosFrame, 0xffff0000)

    local markFrames = {}
    for i=1,20,1 do
        local markFrame = BlzCreateFrameByType("TEXT", "mark", mapFrame, "", 0)
        BlzFrameSetSize(markFrame, 0.01, 0.01)
        BlzFrameSetPoint(
            markFrame, FRAMEPOINT_CENTER, mapFrame, FRAMEPOINT_BOTTOMLEFT, 0, 0)
        BlzFrameSetText(markFrame, "|cffffff00?|r")
        BlzFrameSetTextAlignment(markFrame, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)
        table.insert(markFrames, markFrame)
    end

    local hoverFrame = BlzCreateFrameByType(
            "GLUEBUTTON",
            "hoverFrame",
            mapFrame,
            "",
            0)
    BlzFrameSetAllPoints(hoverFrame, mapFrame)

    uieventhandler.registerClickEvent(hoverFrame, function(playerId, button)
        if button == MOUSE_BUTTON_TYPE_RIGHT then
            mapToggles[playerId].zoomedOut = true
        end
    end)

    utils.createCloseButton(mapOrigin, function(playerId)
        mapToggles[playerId] = nil
    end)

    self.frames = {
        origin = mapOrigin,
        mapFrame = mapFrame,
        yourPosFrame = yourPosFrame,
        markFrames = markFrames,
    }

    return self
end

function getRelativeUnitPoint(unit, mapToUse, width, height)
    local x = GetUnitX(unit)
    local y = GetUnitY(unit)

    local rX = ((x - mapToUse.minX) / (mapToUse.maxX - mapToUse.minX)) * width
    local rY = ((y - mapToUse.minY) / (mapToUse.maxY - mapToUse.minY)) * height

    return rX, rY
end

function isUnitInMap(unit, mapToUse)
    local x = GetUnitX(unit)
    local y = GetUnitY(unit)
    return x >= mapToUse.minX and
        x <= mapToUse.maxX and
        y >= mapToUse.minY and
        y <= mapToUse.maxY
end

function Map:update(playerId)
    local frames = self.frames

    local frameVisible = mapToggles[playerId] ~= nil and self.hero ~= nil

    BlzFrameSetVisible(frames.origin, frameVisible)

    if not frameVisible then
        return
    end

    local zone = zones.getCurrentZone(playerId)
    if self.hero ~= nil and (zone ~= nil or mapToggles[playerId].zoomedOut) then
        local mapToUse = mapToggles[playerId].zoomedOut and
            ENTIRE_MAP_INFO or
            MAPS[zone]

        if mapToUse ~= nil then
            local width
            local height
            if WIDTH / mapToUse.mapAspectRatio <= HEIGHT then
                width = WIDTH
                height = WIDTH / mapToUse.mapAspectRatio
            else
                width = HEIGHT * mapToUse.mapAspectRatio
                height = HEIGHT
            end

            local activeQuests = quests.getActiveQuests(playerId)
            local i = 1
            for _,activeQuestId in pairs(activeQuests) do
                local questReceiver = quests.getQuestInfo(activeQuestId).handQuestTo
                if
                    quests.questObjectivesCompleted(playerId, activeQuestId) and
                    isUnitInMap(questReceiver, mapToUse)
                then
                    local questX, questY = getRelativeUnitPoint(
                        questReceiver, mapToUse, width, height)

                    BlzFrameSetVisible(frames.markFrames[i], true)
                    BlzFrameSetPoint(
                        frames.markFrames[i],
                        FRAMEPOINT_CENTER,
                        frames.mapFrame,
                        FRAMEPOINT_BOTTOMLEFT,
                        questX,
                        questY)

                    i = i + 1
                end
            end

            for j=i,20,1 do
                BlzFrameSetVisible(frames.markFrames[j], false)
            end

            BlzFrameSetTexture(frames.mapFrame, mapToUse.mapFile, 0, true)

            BlzFrameSetSize(frames.mapFrame, width, height)
            BlzFrameSetVisible(frames.yourPosFrame, true)

            local yourPosX, yourPosY = getRelativeUnitPoint(
                self.hero, mapToUse, width, height)
            BlzFrameSetPoint(
                frames.yourPosFrame,
                FRAMEPOINT_CENTER,
                frames.mapFrame,
                FRAMEPOINT_BOTTOMLEFT,
                yourPosX + 0.005,
                yourPosY + 0.005)
        else
            BlzFrameSetVisible(frames.yourPosFrame, false)
        end
    end
end

return Map
