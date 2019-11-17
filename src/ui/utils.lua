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

function createCloseButton(origin, callback)
    local closeButton = BlzCreateFrame("RoundGrungeButtonTemplate", origin, 0, 0)
    BlzFrameSetSize(closeButton, 0.022, 0.022)
    BlzFrameSetPoint(
        closeButton,
        FRAMEPOINT_CENTER,
        origin,
        FRAMEPOINT_TOPRIGHT,
        -0.005,
        -0.005)

    local buttonIcon = BlzCreateFrameByType(
        "BACKDROP",
        "buttonIcon",
        closeButton,
        "",
        0)
    BlzFrameSetSize(buttonIcon, 0.0143, 0.0143)
    BlzFrameSetPoint(
        buttonIcon,
        FRAMEPOINT_CENTER,
        closeButton,
        FRAMEPOINT_CENTER,
        0,
        0)
    BlzFrameSetTexture(
        buttonIcon,
        "war3mapImported\\ui\\close_icon.blp",
        0,
        true)

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(trig, closeButton, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        callback(GetPlayerId(GetTriggerPlayer()))

        BlzFrameSetEnable(BlzGetTriggerFrame(), false)
        BlzFrameSetEnable(BlzGetTriggerFrame(), true)
    end)
end

return {
    createBorderFrame = createBorderFrame,
    createCloseButton = createCloseButton,
}