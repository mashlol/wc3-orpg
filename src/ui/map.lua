local utils = require('src/ui/utils.lua')
local zones = require('src/zones.lua')

-- mapToggles = {
--     [playerId] = true or nil
-- }
local mapToggles = {}

local PADDING = 0.015
local WIDTH = 0.6
local HEIGHT = 0.4

-- KEYS MUST MATCH ZONE NAMES IN `zones.lua`
local MAPS = {
    FREYDELL = {
        minX = -1364.1,
        minY = -841.7,
        maxX = 6866.4,
        maxY = 4941.7,
        mapFile = "mapfreydell.tga",
        mapAspectRatio = 1.4939655,
    },
    FOREST = {
        minX = -6638.4,
        minY = -2192.9,
        maxX = 3607.9,
        maxY = 9704.1,
        mapFile = "mapforest.tga",
        mapAspectRatio = 0.916491649,
    },
}

local Map = {
    toggle = function(playerId)
        mapToggles[playerId] = not mapToggles[playerId]
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

    self.frames = {
        origin = mapOrigin,
        mapFrame = mapFrame,
        yourPosFrame = yourPosFrame,
    }

    return self
end

function Map:update(playerId)
    local frames = self.frames

    local frameVisible = mapToggles[playerId] == true and self.hero ~= nil

    BlzFrameSetVisible(frames.origin, frameVisible)

    if not frameVisible then
        return
    end

    local zone = zones.getCurrentZone(playerId)
    if self.hero ~= nil and zone ~= nil then
        local mapToUse = MAPS[zone]

        local heroX = GetUnitX(self.hero)
        local heroY = GetUnitY(self.hero)

        if mapToUse ~= nil then
            BlzFrameSetTexture(frames.mapFrame, mapToUse.mapFile, 0, true)
            local width
            local height
            if mapToUse.mapAspectRatio > 1 then
                width = WIDTH
                height = WIDTH / mapToUse.mapAspectRatio

            else
                width = HEIGHT * mapToUse.mapAspectRatio
                height = HEIGHT
            end
            BlzFrameSetSize(frames.mapFrame, width, height)
            BlzFrameSetVisible(frames.yourPosFrame, true)

            local yourPosX = ((heroX - mapToUse.minX) / (mapToUse.maxX - mapToUse.minX)) * width
            local yourPosY = ((heroY - mapToUse.minY) / (mapToUse.maxY - mapToUse.minY)) * height
            BlzFrameSetPoint(
                frames.yourPosFrame,
                FRAMEPOINT_CENTER,
                frames.mapFrame,
                FRAMEPOINT_BOTTOMLEFT,
                yourPosX,
                yourPosY)
        else
            BlzFrameSetVisible(frames.yourPosFrame, false)
        end
    end

end

return Map
