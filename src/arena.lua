local log = require('src/log.lua')
local hero = require('src/hero.lua')
local Dialog = require('src/ui/dialog.lua')

-- List of players in the duel
-- duelingPlayers = {
--     [1] = {[playerId1], [playerId2]},
--     [2] = {[playerId2], [playerId3]},
-- }
local duelingPlayers = {}

-- originalLocations = {
--     [playerId] = {x = 1, y = 1}
-- }
local originalLocations = {}
local onDeathTrig

function inInArena(playerId)
    -- TODO support parties
    return duelingPlayers[1][1] == playerId or duelingPlayers[2][1] == playerId
end

function sendChallenge(challengerPlayerId, challengedPlayerId)
    if challengedPlayerId == challengerPlayerId then
        log.log(
            challengerPlayerId,
            "You can't duel yourself.",
            log.TYPE.ERROR)
        return
    end

    if inInArena(challengedPlayerId) then
        log.log(
            challengerPlayerId,
            "That player is already in the arena.",
            log.TYPE.ERROR)
        return
    end

    log.log(
        challengerPlayerId,
        "You challenged "..
            GetPlayerName(Player(challengedPlayerId))..
            " to a duel.",
        log.TYPE.INFO)
    Dialog.show(
        challengedPlayerId, {
            text = GetPlayerName(Player(challengerPlayerId))..
                " challenged you to a duel.",
            positiveButton = "Accept",
            negativeButton = "Decline",
            height = 0.1,
            onPositiveButtonClicked = function()
                acceptDuel(challengedPlayerId, challengerPlayerId)
            end,
        }
    )
end

function onChallengeSent()
    local challengerPlayerId = GetPlayerId(GetTriggerPlayer())
    local sentString = GetEventPlayerChatString()
    local challengedPlayerId = SubString(
        sentString, 6, StringLength(sentString))

    sendChallenge(challengerPlayerId, S2I(challengedPlayerId) - 1)
end

function maybeEndArenaMatch()
    -- TODO support more than just 1v1
    local deadPlayerId = GetPlayerId(GetOwningPlayer(GetDyingUnit()))

    -- TP all alive heroes back to home
    local winnerPlayerId
    if duelingPlayers[1][1] == deadPlayerId then
        winnerPlayerId = duelingPlayers[2][1]
    else
        winnerPlayerId = duelingPlayers[1][1]
    end

    local winnerHero = hero.getHero(winnerPlayerId)

    log.log(
        winnerPlayerId,
        "You won the duel.",
        log.TYPE.INFO)
    log.log(
        deadPlayerId,
        "You lost the duel.",
        log.TYPE.INFO)

    PauseUnit(winnerHero, true)

    TriggerSleepAction(3)

    PauseUnit(winnerHero, false)

    SetUnitPosition(
        winnerHero,
        originalLocations[winnerPlayerId].x,
        originalLocations[winnerPlayerId].y)

    if winnerPlayerId == GetPlayerId(GetLocalPlayer()) then
        PanCameraToTimed(GetUnitX(winnerHero), GetUnitY(winnerHero), 0)
    end

    SetPlayerAllianceStateBJ(
        Player(deadPlayerId),
        Player(winnerPlayerId),
        bj_ALLIANCE_ALLIED_VISION)
    SetPlayerAllianceStateBJ(
        Player(winnerPlayerId),
        Player(deadPlayerId),
        bj_ALLIANCE_ALLIED_VISION)

    DestroyTrigger(onDeathTrig)

    duelingPlayers[1] = {}
    duelingPlayers[2] = {}
end

function acceptDuel(challengedPlayerId, challengerPlayerId)
    -- TODO make it work for parties too

    local challengedHero = hero.getHero(challengedPlayerId)
    local challengerHero = hero.getHero(challengerPlayerId)

    duelingPlayers[1][1] = challengedPlayerId
    duelingPlayers[2][1] = challengerPlayerId

    originalLocations[challengedPlayerId] = {
        x = GetUnitX(challengedHero), y = GetUnitY(challengedHero)
    }
    originalLocations[challengerPlayerId] = {
        x = GetUnitX(challengerHero), y = GetUnitY(challengerHero)
    }

    SetUnitPosition(challengedHero, -27557, 25088)
    SetUnitPosition(challengerHero, -24142, 25072)

    if challengedPlayerId == GetPlayerId(GetLocalPlayer()) then
        PanCameraToTimed(GetUnitX(challengedHero), GetUnitY(challengedHero), 0)
    elseif challengerPlayerId == GetPlayerId(GetLocalPlayer()) then
        PanCameraToTimed(GetUnitX(challengerHero), GetUnitY(challengerHero), 0)
    end

    -- Make enemies
    SetPlayerAllianceStateBJ(
        Player(challengedPlayerId),
        Player(challengerPlayerId),
        bj_ALLIANCE_UNALLIED)
    SetPlayerAllianceStateBJ(
        Player(challengerPlayerId),
        Player(challengedPlayerId),
        bj_ALLIANCE_UNALLIED)

    -- Close PVP gates
    ModifyGateBJ(bj_GATEOPERATION_CLOSE, gg_dest_YTce_2973)
    ModifyGateBJ(bj_GATEOPERATION_CLOSE, gg_dest_YTce_2974)

    -- Wait 10 sec
    TriggerSleepAction(7)

    for i=3,1,-1 do
        log.log(
            challengedPlayerId,
            "Starting in " .. i .. "...",
            log.TYPE.INFO)
        log.log(
            challengerPlayerId,
            "Starting in " .. i .. "...",
            log.TYPE.INFO)
        TriggerSleepAction(1)
    end

    log.log(
        challengedPlayerId,
        "The match has begun!",
        log.TYPE.INFO)
    log.log(
        challengerPlayerId,
        "The match has begun!",
        log.TYPE.INFO)

    -- Open PVP gates
    ModifyGateBJ(bj_GATEOPERATION_OPEN, gg_dest_YTce_2973)
    ModifyGateBJ(bj_GATEOPERATION_OPEN, gg_dest_YTce_2974)

    -- Add death triggers
    onDeathTrig = CreateTrigger()
    TriggerRegisterUnitEvent(onDeathTrig, challengedHero, EVENT_UNIT_DEATH)
    TriggerRegisterUnitEvent(onDeathTrig, challengerHero, EVENT_UNIT_DEATH)
    TriggerAddAction(onDeathTrig, maybeEndArenaMatch)
end

function init()
    local challengeTrig = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        TriggerRegisterPlayerChatEvent(challengeTrig, Player(i), "-duel", false)
    end
    TriggerAddAction(challengeTrig, onChallengeSent)

    duelingPlayers[1] = {}
    duelingPlayers[2] = {}
end

return {
    init = init,
    getPlayersInParty = getPlayersInParty,
    getPlayerParty = getPlayerParty,
}
