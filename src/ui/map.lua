local utils = require('src/ui/utils.lua')

-- mapToggles = {
--     [playerId] = true or nil
-- }
local mapToggles = {}

local PADDING = 0.015
local WIDTH = 0.59758620
local HEIGHT = 0.4

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
    BlzFrameSetTexture(mapFrame, "map1.tga", 0, true)

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

    if self.hero ~= nil then
        local heroX = GetUnitX(self.hero)
        local heroY = GetUnitY(self.hero)

        if heroX >= -1364.1 and heroX <= 6866.4 and heroY >= -841.7 and heroY <= 4941.7 then
            local yourPosX = ((heroX + 1364.1) / (6866.4 + 1364.1)) * WIDTH
            local yourPosY = ((heroY + 841.7) / (4941.7 + 841.7)) * HEIGHT

            BlzFrameSetVisible(frames.yourPosFrame, true)
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
