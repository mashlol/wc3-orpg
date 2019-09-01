function createBorderFrame(origin)
    local borderFrame = BlzCreateFrame("Leaderboard", origin, 0,0)
    BlzFrameSetAllPoints(borderFrame, origin)
    return borderFrame
end

return {
    createBorderFrame = createBorderFrame,
}