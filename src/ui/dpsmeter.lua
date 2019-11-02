local damage = require('src/damage.lua')
local party = require('src/party.lua')

local DpsMeter = {}

function DpsMeter:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function DpsMeter:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local origin = BlzCreateFrameByType(
        "FRAME",
        "origin",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        origin, 0.13, 0.15)
    BlzFrameSetAbsPoint(
        origin,
        FRAMEPOINT_BOTTOMRIGHT,
        0.8,
        0.01)

    local backdrop = BlzCreateFrameByType(
        "BACKDROP",
        "backdrop",
        origin,
        "",
        0)
    BlzFrameSetAllPoints(backdrop, origin)
    BlzFrameSetTexture(
        backdrop,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)
    BlzFrameSetAlpha(backdrop, 150)

    local rows = {}
    for i=0,9,1 do
        local rowOrigin = BlzCreateFrameByType(
            "FRAME",
            "rowOrigin",
            origin,
            "",
            0)
        BlzFrameSetSize(rowOrigin, 0.13, 0.015)
        BlzFrameSetPoint(
            rowOrigin,
            FRAMEPOINT_TOP,
            origin,
            FRAMEPOINT_TOP,
            0,
            i * -0.015)

        local rowBackdropUnfilled = BlzCreateFrameByType(
            "BACKDROP",
            "rowBackdropUnfilled",
            rowOrigin,
            "",
            0)
        BlzFrameSetAllPoints(rowBackdropUnfilled, rowOrigin)
        BlzFrameSetTexture(
            rowBackdropUnfilled,
            "Replaceabletextures\\Teamcolor\\Teamcolor21.blp",
            0,
            true)
        BlzFrameSetAlpha(rowBackdropUnfilled, i % 2 * 50)

        local rowBackdrop = BlzCreateFrameByType(
            "BACKDROP",
            "rowBackdrop",
            rowOrigin,
            "",
            0)
        BlzFrameSetSize(rowBackdrop, 0.07, 0.015)
        BlzFrameSetPoint(
            rowBackdrop,
            FRAMEPOINT_LEFT,
            rowOrigin,
            FRAMEPOINT_LEFT,
            0,
            0)
        BlzFrameSetTexture(
            rowBackdrop,
            "Replaceabletextures\\Teamcolor\\Teamcolor0" .. i .. ".blp",
            0,
            true)
        BlzFrameSetAlpha(rowBackdrop, 220)

        local rowNameTextFrame = BlzCreateFrameByType(
            "TEXT",
            "rowNameTextFrame",
            rowOrigin,
            "",
            0)
        BlzFrameSetAllPoints(rowNameTextFrame, rowOrigin)
        BlzFrameSetText(rowNameTextFrame, "mashlol")
        BlzFrameSetTextAlignment(rowNameTextFrame, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_LEFT)

        local rowDpsTextFrame = BlzCreateFrameByType(
            "TEXT",
            "rowDpsTextFrame",
            rowOrigin,
            "",
            0)
        BlzFrameSetAllPoints(rowDpsTextFrame, rowOrigin)
        BlzFrameSetText(rowDpsTextFrame, "25.23")
        BlzFrameSetTextAlignment(rowDpsTextFrame, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_RIGHT)

        table.insert(rows, {
            origin = rowOrigin,
            dpsText = rowDpsTextFrame,
            backdrop = rowBackdrop,
            nameText = rowNameTextFrame,
        })
    end

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

function DpsMeter:update(playerId)
    local frames = self.frames

    local isVisible = self.hero ~= nil
    BlzFrameSetVisible(frames.origin, isVisible)

    if not isVisible then
        return
    end

    local partyMembers = {}
    local partyId = party.getPlayerParty(playerId)
    if partyId ~= nil then
        partyMembers = party.getPlayersInParty(partyId, playerId)
    end
    local myDps = damage.getCurrentDps(playerId)
    local dpsMeters = {}
    if myDps ~= nil then
        table.insert(dpsMeters, {
            playerId = playerId,
            dps = myDps,
        })
    end
    local totalDps = myDps or 0
    for _, partyPlayerId in pairs(partyMembers) do
        local curDps = damage.getCurrentDps(partyPlayerId)
        if curDps ~= nil then
            table.insert(dpsMeters, {
                playerId = partyPlayerId,
                dps = curDps,
            })
            totalDps = totalDps + curDps
        end
    end

    for _, dpsInfo in pairs(dpsMeters) do
        dpsInfo.pctDps = dpsInfo.dps / totalDps
    end

    table.sort(dpsMeters, function(a, b)
        return a.dps > b.dps
    end)

    for idx, rowFrames in pairs(frames.rows) do
        if dpsMeters[idx] ~= nil then
            BlzFrameSetVisible(rowFrames.origin, true)
            BlzFrameSetText(rowFrames.dpsText, round(dpsMeters[idx].dps, 2))
            BlzFrameSetText(rowFrames.nameText, GetPlayerName(Player(dpsMeters[idx].playerId)))
            BlzFrameSetSize(rowFrames.backdrop, 0.13 * dpsMeters[idx].pctDps, 0.015)
        else
            BlzFrameSetVisible(rowFrames.origin, false)
        end
    end
end

return DpsMeter
