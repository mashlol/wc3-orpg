local log = require('src/log.lua')
local Dialog = require('src/ui/dialog.lua')

local playerParties = {}
local partyIdx = 0
local pendingInvites = {}

function addPlayerToParty(partyId, playerId)
    playerParties[playerId] = partyId
end

function removePlayerFromParty(playerId)
    playerParties[playerId] = nil
end

function createParty()
    local partyId = partyIdx
    partyIdx = partyIdx + 1
    return partyId
end

function getPlayersInParty(expectedPartyId, excludePlayer)
    local players = {}
    for playerId,partyId in pairs(playerParties) do
        if partyId == expectedPartyId and playerId ~= excludePlayer then
            table.insert(players, playerId)
        end
    end
    return players
end

function getPlayerParty(playerId)
    return playerParties[playerId]
end

function onInviteSent()
    local inviterPlayerId = GetPlayerId(GetTriggerPlayer())
    local sentString = GetEventPlayerChatString()
    local invitedPlayerId = S2I(SubString(
        sentString, 7, StringLength(sentString))) - 1

    if getPlayerParty(invitedPlayerId) ~= nil then
        log.log(
            inviterPlayerId,
            "That player is already in a party.",
            log.TYPE.ERROR)
        return
    end

    pendingInvites[invitedPlayerId] = inviterPlayerId
    log.log(
        inviterPlayerId,
        "You invited "..
            GetPlayerName(Player(invitedPlayerId))..
            " to join your party.",
        log.TYPE.INFO)
    Dialog.show(
        invitedPlayerId, {
            text = GetPlayerName(Player(inviterPlayerId))..
                " invited you to join their party.",
            positiveButton = "Accept",
            negativeButton = "Decline",
            height = 0.1,
            onPositiveButtonClicked = function()
                acceptInvite(invitedPlayerId, inviterPlayerId)
            end,
        }
    )
end

function acceptInvite(invitedPlayerId, inviterPlayerId)
    local partyId = getPlayerParty(inviterPlayerId)
    if partyId == nil then
        partyId = createParty()
        addPlayerToParty(partyId, inviterPlayerId)
    end
    addPlayerToParty(partyId, invitedPlayerId)
    local playersInParty = getPlayersInParty(partyId)
    for idx, playerId in pairs(playersInParty) do
        log.log(
            playerId,
            GetPlayerName(Player(invitedPlayerId)).." joined the party.",
            log.TYPE.INFO)
    end
end

function onAcceptInvite()
    local invitedPlayerId = GetPlayerId(GetTriggerPlayer())
    if pendingInvites[invitedPlayerId] == nil then
        log.log(invitedPlayerId, "You have no invites pending.", log.TYPE.ERROR)
        return
    end
    local inviterPlayerId = pendingInvites[invitedPlayerId]
    local partyId = getPlayerParty(inviterPlayerId)
    if partyId == nil then
        partyId = createParty()
        addPlayerToParty(partyId, inviterPlayerId)
    end
    addPlayerToParty(partyId, invitedPlayerId)
    local playersInParty = getPlayersInParty(partyId)
    for idx, playerId in pairs(playersInParty) do
        log.log(
            playerId,
            GetPlayerName(Player(invitedPlayerId)).." joined the party.",
            log.TYPE.INFO)
    end
end

function init()
    local inviteTrig = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        TriggerRegisterPlayerChatEvent(inviteTrig, Player(i), "-party", false)
    end
    TriggerAddAction(inviteTrig, onInviteSent)

    local acceptTrig = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        TriggerRegisterPlayerChatEvent(acceptTrig, Player(i), "-accept", true)
    end
    TriggerAddAction(acceptTrig, onAcceptInvite)

    for i=0,bj_MAX_PLAYERS-1,1 do
        for j=0,bj_MAX_PLAYERS-1,1 do
            SetPlayerAllianceStateBJ(
                Player(i),
                Player(j),
                bj_ALLIANCE_ALLIED_VISION)
        end
    end
end


return {
    init = init,
    getPlayersInParty = getPlayersInParty,
    getPlayerParty = getPlayerParty,
}
