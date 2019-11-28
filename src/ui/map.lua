local utils = require('src/ui/utils.lua')
local zones = require('src/zones.lua')
local quests = require('src/quests/main.lua')
local uieventhandler = require('src/ui/uieventhandler.lua')

local PADDING = 0.015
local WIDTH = 0.6
local HEIGHT = 0.4

-- KEYS MUST MATCH ZONE NAMES IN `zones.lua`
local MAPS = {
    FOREST = {
        minX = -9565.7,
        minY = -12496.5,
        maxX = 4999,
        maxY = 1860.9,
        mapFile = "war3mapImported\\forest.blp",
        mapAspectRatio = 1.0633579725,
        zIndex = 1,
    },
    FREYDELL = {
        minX = -741.7,
        minY = -4912.8,
        maxX = 3474.6,
        maxY = -2272.2,
        mapFile = "war3mapImported\\freydell.blp",
        mapAspectRatio = 1.66919191919,
        zIndex = 2,
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
    local mapsByZIndex = {}
    for _, mapInfo in pairs(MAPS) do
        table.insert(mapsByZIndex, mapInfo)
    end
    table.sort(mapsByZIndex, function(a, b) return a.zIndex < b.zIndex end)

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

    local zoomOutButton = BlzCreateFrameByType(
        "GLUEBUTTON",
        "zoomOutButton",
        mapFrame,
        "",
        0)
    BlzFrameSetAllPoints(zoomOutButton, mapFrame)

    uieventhandler.registerClickEvent(zoomOutButton, function(playerId, button)
        if button == MOUSE_BUTTON_TYPE_RIGHT then
            mapToggles[playerId].zoomedOut = true
        end
    end)

    local zoomInButtons = {}
    local fullMapWidth, fullMapHeight = getMapRelativeSize(ENTIRE_MAP_INFO)
    for _, mapInfo in pairs(mapsByZIndex) do
        local zoomInButton = BlzCreateFrameByType(
            "GLUEBUTTON",
            "zoomInButton",
            mapFrame,
            "",
            0)

        local relativeMaxX, relativeMaxY = getRelativePoint(
            mapInfo.maxX,
            mapInfo.maxY,
            ENTIRE_MAP_INFO,
            fullMapWidth,
            fullMapHeight)
        local relativeMinX, relativeMinY = getRelativePoint(
            mapInfo.minX,
            mapInfo.minY,
            ENTIRE_MAP_INFO,
            fullMapWidth,
            fullMapHeight)

        BlzFrameSetSize(
            zoomInButton,
            relativeMaxX - relativeMinX,
            relativeMaxY - relativeMinY)

        BlzFrameSetPoint(
            zoomInButton,
            FRAMEPOINT_BOTTOMLEFT,
            mapFrame,
            FRAMEPOINT_BOTTOMLEFT,
            relativeMinX,
            relativeMinY)

        uieventhandler.registerClickEvent(zoomInButton, function(playerId, button)
            if button == MOUSE_BUTTON_TYPE_LEFT then
                mapToggles[playerId].forceMap = mapInfo
                mapToggles[playerId].zoomedOut = false
            end
        end)

        table.insert(zoomInButtons, zoomInButton)
    end

    utils.createCloseButton(mapOrigin, function(playerId)
        mapToggles[playerId] = nil
    end)

    self.frames = {
        origin = mapOrigin,
        mapFrame = mapFrame,
        yourPosFrame = yourPosFrame,
        markFrames = markFrames,
        zoomOutButton = zoomOutButton,
        zoomInButtons = zoomInButtons,
    }

    return self
end

function getRelativePoint(x, y, mapToUse, width, height)
    local rX = ((x - mapToUse.minX) / (mapToUse.maxX - mapToUse.minX)) * width
    local rY = ((y - mapToUse.minY) / (mapToUse.maxY - mapToUse.minY)) * height

    return rX, rY
end

function getRelativeUnitPoint(unit, mapToUse, width, height)
    local x = GetUnitX(unit)
    local y = GetUnitY(unit)

    return getRelativePoint(x, y, mapToUse, width, height)
end

function getMapRelativeSize(mapInfo)
    local width
    local height
    if WIDTH / mapInfo.mapAspectRatio <= HEIGHT then
        width = WIDTH
        height = WIDTH / mapInfo.mapAspectRatio
    else
        width = HEIGHT * mapInfo.mapAspectRatio
        height = HEIGHT
    end

    return width, height
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

    for _, frame in pairs(frames.zoomInButtons) do
        BlzFrameSetVisible(frame, mapToggles[playerId].zoomedOut)
    end

    local zone = zones.getCurrentZone(playerId)
    local mapToUse = nil
    if mapToggles[playerId].zoomedOut then
        mapToUse = ENTIRE_MAP_INFO
    elseif mapToggles[playerId].forceMap ~= nil then
        mapToUse =  mapToggles[playerId].forceMap
    elseif zone ~= nil then
        mapToUse = MAPS[zone]
    end

    if mapToUse ~= nil then
        local width, height = getMapRelativeSize(mapToUse)

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

return Map
