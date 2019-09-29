local makeTooltipFrame = function(relativeFrame, width, height, hoverFrame, attachToBottom, alignRight)
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local attachMain
    local attachRelative

    if attachToBottom and alignRight then
        attachMain = FRAMEPOINT_TOPLEFT
        attachRelative = FRAMEPOINT_BOTTOMLEFT
    elseif attachToBottom and not alignRight then
        attachMain = FRAMEPOINT_TOP
        attachRelative = FRAMEPOINT_BOTTOM
    elseif not attachToBottom and alignRight then
        attachMain = FRAMEPOINT_BOTTOMLEFT
        attachRelative = FRAMEPOINT_TOPLEFT
    elseif not attachToBottom and not alignRight then
        attachMain = FRAMEPOINT_BOTTOM
        attachRelative = FRAMEPOINT_TOP
    end

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
        attachMain,
        relativeFrame,
        attachRelative,
        0,
        attachToBottom and -0.02 or 0.02)

    local tooltipBackdrop = BlzCreateFrame(
        "BoxedTextBackgroundTemplate",
        tooltipOrigin,
        0,
        0)
    BlzFrameSetAllPoints(tooltipBackdrop, tooltipOrigin)

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
        backdrop = tooltipBackdrop,
    }
end

return {
    makeTooltipFrame = makeTooltipFrame,
}
