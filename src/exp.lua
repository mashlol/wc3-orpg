local party = require('src/party.lua')
local hero = require('src/hero.lua')

local BASE_EXP = 10
local ELITE_BASE_EXP = 30

function getExp(heroLevel, mobLevel, numShared)
    local delta = mobLevel - heroLevel

    -- No exp for anything 5 levels above or 5 levels below
    if delta > 5 or delta < -5 then
        return 0
    end

    -- TODO determine if the unit is "elite" and give more exp

    return math.max((BASE_EXP + BASE_EXP * delta / 5) / numShared, 1)
end

function distributeExp()
    local dyingUnit = GetDyingUnit()
    local killingUnit = GetKillingUnit()
    local killingPlayerId = GetPlayerId(GetOwningPlayer())

    local dyingUnitLevel = GetUnitLevel(dyingUnit)

    local playerPartyId = party.getPlayerParty(killingPlayerId)

    if playerPartyId ~= nil then
        local playersInParty = party.getPlayersInParty(playerPartyId)
        local partySize = #playersInParty
        for _, playerId in pairs(playersInParty) do
            local heroLevel = GetHeroLevel(hero.getHero(playerId))
            AddHeroXP(
                killingUnit,
                getExp(heroLevel, dyingUnitLevel, partySize),
                true)
        end
    else
        local heroLevel = GetHeroLevel(killingUnit)
        -- No party, give full exp
        AddHeroXP(killingUnit, getExp(heroLevel, dyingUnitLevel, 1), true)
    end
end

function init()
    local killTrigger = CreateTrigger()
    TriggerRegisterPlayerUnitEvent(
        killTrigger,
        Player(PLAYER_NEUTRAL_AGGRESSIVE),
        EVENT_PLAYER_UNIT_DEATH,
        nil)
    TriggerAddAction(killTrigger, distributeExp)
end

return {
    init = init,
}