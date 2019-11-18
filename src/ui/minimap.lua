local utils = require('src/ui/utils.lua')

local MINIMAP_SIZE = 0.14
local FRAME_PADDING = 0.0065

local TOPRIGHT_OFFSET_X = 0.8 - FRAME_PADDING
local TOPRIGHT_OFFSET_Y = 0.6 - FRAME_PADDING

local MiniMap = {}

function MiniMap:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function MiniMap:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    local miniMapFrame = BlzGetOriginFrame(ORIGIN_FRAME_MINIMAP, 0)
    BlzFrameSetAbsPoint(
        miniMapFrame, FRAMEPOINT_TOPRIGHT, TOPRIGHT_OFFSET_X, TOPRIGHT_OFFSET_Y)
    BlzFrameSetAbsPoint(
        miniMapFrame,
        FRAMEPOINT_BOTTOMLEFT,
        TOPRIGHT_OFFSET_X - MINIMAP_SIZE,
        TOPRIGHT_OFFSET_Y - MINIMAP_SIZE)

    local borderInfo = utils.createBorderFrame(originFrame)
    BlzFrameClearAllPoints(borderInfo.border)
    BlzFrameSetSize(
        borderInfo.border,
        MINIMAP_SIZE + FRAME_PADDING * 2,
        MINIMAP_SIZE + FRAME_PADDING * 2)
    BlzFrameSetPoint(
        borderInfo.border,
        FRAMEPOINT_CENTER,
        miniMapFrame,
        FRAMEPOINT_CENTER,
        0,
        0)

    BlzFrameSetParent(miniMapFrame, borderInfo.border)
    BlzFrameSetVisible(miniMapFrame, true)

    self.frames = {
        origin = borderInfo.border,
    }

    return self
end

function MiniMap:update()
    local frames = self.frames
    BlzFrameSetVisible(frames.origin, self.hero ~= nil)
end

return MiniMap
