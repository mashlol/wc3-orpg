local TITLE_WIDTH = 0.2

function createBorderFrame(origin, title)
    local borderFrame = BlzCreateFrame(
        "WindowBackgroundTemplate",
        origin,
        0,
        0)
    local titleText
    if title then
        local titleBackdrop = BlzCreateFrameByType(
            "BACKDROP", "titleBackdrop", origin, "", 0)
        BlzFrameSetSize(titleBackdrop, TITLE_WIDTH, TITLE_WIDTH * 142 / 858)
        BlzFrameSetPoint(
            titleBackdrop, FRAMEPOINT_CENTER, origin, FRAMEPOINT_TOP, 0, -TITLE_WIDTH * 0.02)
        BlzFrameSetTexture(
            titleBackdrop, "war3mapImported\\ui\\header.blp", 0, true)

        titleText = BlzCreateFrameByType(
            "TEXT", "titleText", titleBackdrop, "", 0)
        BlzFrameSetAllPoints(titleText, titleBackdrop)
        BlzFrameSetTextAlignment(titleText, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)
        BlzFrameSetText(titleText, title)
    end

    BlzFrameSetAllPoints(borderFrame, origin)
    return {
        border = borderFrame,
        text = titleText,
    }
end

return {
    createBorderFrame = createBorderFrame,
}