local playerParties = {}
local partyIdx = 0
local pendingInvites = {}

function addPlayerToParty(partyId, playerId)
    playerParties[playerId] = partyId
end

function removePlayerFromParty(playerId)
    playerPartyies[playerId] = nil
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
        print("That player is already in a party.")
        return
    end

    pendingInvites[invitedPlayerId] = inviterPlayerId
    print("Invite sent")
end

function onAcceptInvite()
    local invitedPlayerId = GetPlayerId(GetTriggerPlayer())
    if pendingInvites[invitedPlayerId] == nil then
        print("You have no pending invites.")
        return
    end
    local inviterPlayerId = pendingInvites[invitedPlayerId]
    local partyId = getPlayerParty(inviterPlayerId)
    if partyId == nil then
        partyId = createParty()
        addPlayerToParty(partyId, inviterPlayerId)
    end
    addPlayerToParty(partyId, invitedPlayerId)
    print("Joined the party.")
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
            print('Allying ', i, j)
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
