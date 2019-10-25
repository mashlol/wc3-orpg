local consts = require('src/ui/consts.lua')
local casttime = require('src/casttime.lua')

local CastBar = {}

function CastBar:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function CastBar:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local castBarFrameOrigin = BlzCreateFrameByType(
        "FRAME", "castBarFrameOrigin", originFrame, "", 0)
    BlzFrameSetSize(
        castBarFrameOrigin, consts.CAST_BAR_WIDTH, consts.CAST_BAR_HEIGHT)
    BlzFrameSetAbsPoint(
        castBarFrameOrigin,
        FRAMEPOINT_CENTER,
        0.4,
        consts.ACTION_ITEM_SIZE + consts.BAR_HEIGHT * 12)

    local castBarFrameBackdrop = BlzCreateFrameByType(
        "BACKDROP",
        "castBarFrameBackdrop",
        castBarFrameOrigin,
        "",
        0)
    BlzFrameSetSize(
        castBarFrameBackdrop,
        consts.CAST_BAR_WIDTH - 0.04,
        consts.CAST_BAR_HEIGHT - 0.012)
    BlzFrameSetPoint(
        castBarFrameBackdrop,
        FRAMEPOINT_LEFT,
        castBarFrameOrigin,
        FRAMEPOINT_LEFT,
        0.02,
        0)
    BlzFrameSetTexture(
        castBarFrameBackdrop,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)

    local castBarFrameFilled = BlzCreateFrameByType(
        "BACKDROP",
        "castBarFrameFilled",
        castBarFrameOrigin,
        "",
        0)
    BlzFrameSetSize(
        castBarFrameFilled,
        consts.CAST_BAR_WIDTH - 0.02,
        consts.CAST_BAR_HEIGHT - 0.01)
    BlzFrameSetPoint(
        castBarFrameFilled,
        FRAMEPOINT_LEFT,
        castBarFrameOrigin,
        FRAMEPOINT_LEFT,
        0.02,
        0)
    BlzFrameSetTexture(
        castBarFrameFilled,
        "Replaceabletextures\\Teamcolor\\Teamcolor09.blp",
        0,
        true)

    local castBarFrameBackground = BlzCreateFrameByType(
        "BACKDROP",
        "castBarFrameBackground",
        castBarFrameOrigin,
        "",
        0)
    BlzFrameSetSize(
        castBarFrameBackground, consts.CAST_BAR_WIDTH, consts.CAST_BAR_HEIGHT)
    BlzFrameSetPoint(
        castBarFrameBackground,
        FRAMEPOINT_LEFT,
        castBarFrameOrigin,
        FRAMEPOINT_LEFT,
        0,
        0)
    BlzFrameSetTexture(
        castBarFrameBackground,
        "ui\\glues\\battlenet\\progressbar\\bnetprogress-barborder.blp",
        0,
        true)

    self.frames = {
        castBar = castBarFrameFilled,
        origin = castBarFrameOrigin,
    }

    return self
end

function CastBar:update(playerId)
    local frame = self.frames

    local castRemainder = casttime.getCastDurationRemaining(playerId)
    local castTotal = casttime.getCastDurationTotal(playerId)
    if castRemainder ~= nil and castTotal ~= nil then
        BlzFrameSetVisible(frame.origin, true)
        BlzFrameSetSize(
            frame.castBar,
            (consts.CAST_BAR_WIDTH - 0.04) * (1 - castRemainder / castTotal),
            (consts.CAST_BAR_HEIGHT - 0.012))
    else
        BlzFrameSetVisible(frame.origin, false)
        BlzFrameSetSize(
            frame.castBar,
            0,
            consts.CAST_BAR_HEIGHT)
    end
end

return CastBar
