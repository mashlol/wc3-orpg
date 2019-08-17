local consts = require('src/ui/consts.lua')
local casttime = require('src/casttime.lua')

function init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local castBarFrameBackground = BlzCreateFrameByType(
        "BACKDROP",
        "castBarFrameBackground",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        castBarFrameBackground, consts.CAST_BAR_WIDTH, consts.CAST_BAR_HEIGHT)
    BlzFrameSetAbsPoint(
        castBarFrameBackground,
        FRAMEPOINT_CENTER,
        0.4,
        consts.ACTION_ITEM_SIZE + consts.BAR_HEIGHT * 10)
    BlzFrameSetTexture(
        castBarFrameBackground,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)

    local castBarFrameFilled = BlzCreateFrameByType(
        "BACKDROP",
        "castBarFrameFilled",
        castBarFrameBackground,
        "",
        0)
    BlzFrameSetSize(
        castBarFrameFilled, consts.CAST_BAR_WIDTH, consts.CAST_BAR_HEIGHT)
    BlzFrameSetPoint(
        castBarFrameFilled,
        FRAMEPOINT_LEFT,
        castBarFrameBackground,
        FRAMEPOINT_LEFT,
        0,
        0)
    BlzFrameSetTexture(
        castBarFrameFilled,
        "Replaceabletextures\\Teamcolor\\Teamcolor04.blp",
        0,
        true)

    return {
        castBar = castBarFrameFilled,
        origin = castBarFrameBackground,
    }
end

function update(frame, playerId)
    local castRemainder = casttime.getCastDurationRemaining(playerId)
    local castTotal = casttime.getCastDurationTotal(playerId)
    if castRemainder ~= nil and castTotal ~= nil then
        BlzFrameSetVisible(frame.origin, true)
        BlzFrameSetSize(
            frame.castBar,
            consts.CAST_BAR_WIDTH * (1 - castRemainder / castTotal),
            consts.CAST_BAR_HEIGHT)
    else
        BlzFrameSetVisible(frame.origin, false)
    end
end

return {
    init = init,
    update = update,
}
