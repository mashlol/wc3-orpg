local makeTooltipFrame = function(relativeFrame, width, height, hoverFrame, attachToBottom)
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local tooltipOrigin = BlzCreateFrameByType(
        "FRAME",
        "tooltipOrigin",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        tooltipOrigin,
        width,
        height)
    BlzFrameSetPoint(
        tooltipOrigin,
        attachToBottom and FRAMEPOINT_TOP or FRAMEPOINT_BOTTOM,
        relativeFrame,
        attachToBottom and FRAMEPOINT_BOTTOM or FRAMEPOINT_TOP,
        0,
        attachToBottom and -0.02 or 0.02)

    local tooltipBackdrop = BlzCreateFrameByType(
        "BACKDROP",
        "tooltipBackdrop",
        tooltipOrigin,
        "",
        0)
    BlzFrameSetAllPoints(tooltipBackdrop, tooltipOrigin)
    BlzFrameSetTexture(
        tooltipBackdrop,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)
    BlzFrameSetAlpha(tooltipBackdrop, 200)

    local tooltipText = BlzCreateFrameByType(
        "TEXT",
        "tooltipText",
        tooltipOrigin,
        "",
        0)

    BlzFrameSetSize(
        tooltipText,
        width - 0.01,
        height - 0.01)
    BlzFrameSetPoint(
        tooltipText,
        FRAMEPOINT_CENTER,
        tooltipOrigin,
        FRAMEPOINT_CENTER,
        0,
        0)

    if hoverFrame == nil then
        hoverFrame = BlzCreateFrameByType(
            "FRAME",
            "hoverFrame",
            relativeFrame,
            "",
            0)
    end
    BlzFrameSetAllPoints(hoverFrame, relativeFrame)
    BlzFrameSetTooltip(hoverFrame, tooltipOrigin)

    return {
        origin = tooltipOrigin,
        text = tooltipText,
    }
end

return {
    makeTooltipFrame = makeTooltipFrame,
}
