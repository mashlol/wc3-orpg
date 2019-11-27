local utils = require('src/ui/utils.lua')
local uieventhandler = require('src/ui/uieventhandler.lua')

local WIDTH = 0.13
local HEIGHT = 0.15
local PADDING_Y = 0.007
local PADDING_X = 0.004

local ROW_WIDTH = WIDTH - PADDING_X * 2
local ROW_HEIGHT =  (HEIGHT - PADDING_Y * 2) / 10

local ATTACH_POINTS_MAP = {
    [FRAMEPOINT_TOP] = FRAMEPOINT_BOTTOM,
    [FRAMEPOINT_BOTTOM] = FRAMEPOINT_TOP,
    [FRAMEPOINT_LEFT] = FRAMEPOINT_RIGHT,
    [FRAMEPOINT_RIGHT] = FRAMEPOINT_LEFT,
    [FRAMEPOINT_BOTTOMLEFT] = FRAMEPOINT_TOPLEFT,
    [FRAMEPOINT_TOPLEFT] = FRAMEPOINT_BOTTOMLEFT,
    [FRAMEPOINT_TOPRIGHT] = FRAMEPOINT_BOTTOMRIGHT,
    [FRAMEPOINT_TOPLEFT] = FRAMEPOINT_BOTTOMLEFT,
}

-- contextMenuToggles = {
--     [playerId] = {
--         attachFrame = frame,
--         relative = FRAMEPOINT_TOP,
--         buttons = {
--             {
--                 text = "Invite to Party",
--                 onClick = function()
--                     print('Invited to party')
--                 end,
--             },
--         }
--     },
-- }
local contextMenuToggles = {}

local ContextMenu = {
    show = function(playerId, info)
        contextMenuToggles[playerId] = info
    end,
    hide = function(playerId)
        contextMenuToggles[playerId] = nil
    end,
}

function ContextMenu:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function ContextMenu:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local origin = BlzCreateFrameByType(
        "FRAME",
        "origin",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        origin, WIDTH, HEIGHT)
    BlzFrameSetAbsPoint(
        origin,
        FRAMEPOINT_BOTTOMRIGHT,
        0.65,
        0.1)

    utils.createBorderFrame(origin)

    local rows = {}
    for i=0,9,1 do
        local rowOrigin = BlzCreateFrameByType(
            "FRAME",
            "rowOrigin",
            origin,
            "",
            0)
        BlzFrameSetSize(rowOrigin, ROW_WIDTH, ROW_HEIGHT)
        BlzFrameSetPoint(
            rowOrigin,
            FRAMEPOINT_TOP,
            origin,
            FRAMEPOINT_TOP,
            0,
            -i * ROW_HEIGHT - PADDING_Y)

        if (i + 1) % 2 == 0 then
            local frameBackdrop = BlzCreateFrameByType(
                "BACKDROP",
                "frameBackdrop",
                rowOrigin,
                "",
                0)
            BlzFrameSetAllPoints(frameBackdrop, rowOrigin)
            BlzFrameSetTexture(
                frameBackdrop,
                "war3mapImported\\ui\\inner_container_2_full.blp",
                0,
                true)
            BlzFrameSetAlpha(frameBackdrop, 100)
        end

        local rowText = BlzCreateFrameByType(
            "TEXT",
            "rowText",
            rowOrigin,
            "",
            0)
        BlzFrameSetAllPoints(rowText, rowOrigin)
        BlzFrameSetText(rowText, "Invite")
        BlzFrameSetTextAlignment(rowText, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)

        local hoverFrame = BlzCreateFrameByType(
            "GLUEBUTTON",
            "hoverFrame",
            rowOrigin,
            "IconButtonTemplate",
            0)
        BlzFrameSetAllPoints(hoverFrame, rowOrigin)

        uieventhandler.registerClickEvent(hoverFrame, function(playerId, button)
            local btnIndex = i + 1

            if
                contextMenuToggles[playerId].buttons[btnIndex] ~= nil and
                contextMenuToggles[playerId].buttons[btnIndex].onClick
            then
                contextMenuToggles[playerId].buttons[btnIndex].onClick(
                    playerId, button)
            end

            ContextMenu.hide(playerId)
        end)

        table.insert(rows, {
            origin = rowOrigin,
            text = rowText,
            hoverFrame = hoverFrame,
        })
    end

    -- utils.createCloseButton(origin, function(playerId)
    --     contextMenuToggles[playerId] = nil
    -- end)

    self.frames = {
        origin = origin,
        rows = rows,
    }

    return self
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function ContextMenu:update(playerId)
    local frames = self.frames

    local isVisible = contextMenuToggles[playerId]
    BlzFrameSetVisible(frames.origin, isVisible)

    if not isVisible then
        return
    end

    local originFrame = frames.origin
    BlzFrameSetSize(
        originFrame,
        WIDTH,
        PADDING_Y * 2 + ROW_HEIGHT * #(contextMenuToggles[playerId].buttons))
    BlzFrameClearAllPoints(originFrame)

    local relative = contextMenuToggles[playerId].relative
    local relativeFrame = contextMenuToggles[playerId].attachFrame
    BlzFrameSetPoint(
        originFrame, ATTACH_POINTS_MAP[relative], relativeFrame, relative, 0, 0)

    for i=1,10,1 do
        local btnFrame = frames.rows[i]

        if contextMenuToggles[playerId].buttons[i] then
            BlzFrameSetVisible(btnFrame.origin, true)

            local text = contextMenuToggles[playerId].buttons[i].text
            BlzFrameSetText(btnFrame.text, text or "")
            BlzFrameSetVisible(btnFrame.hoverFrame, text)
        else
            BlzFrameSetVisible(btnFrame.origin, false)
        end
    end
end

return ContextMenu
