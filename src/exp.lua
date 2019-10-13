local party = require('src/party.lua')
local hero = require('src/hero.lua')

local BASE_EXP = 10
local ELITE_BASE_EXP = 30

function getExp(heroLevel, mobLevel, numShared, isElite)
    local delta = mobLevel - heroLevel

    -- No exp for anything 5 levels above or 5 levels below
    if delta > 5 or delta < -5 then
        return 0
    end

    local baseExp = isElite and ELITE_BASE_EXP or BASE_EXP

    return R2I(math.max((baseExp + baseExp * delta / 5) / numShared, 1))
end

function distributeExp()
    local dyingUnit = GetDyingUnit()
    local killingUnit = GetKillingUnit()
    local killingPlayerId = GetPlayerId(GetOwningPlayer())

    local dyingUnitLevel = GetUnitLevel(dyingUnit)
    local isElite = not BlzGetUnitBooleanField(dyingUnit, UNIT_BF_DECAYABLE)

    local playerPartyId = party.getPlayerParty(killingPlayerId)

    if playerPartyId ~= nil then
        local playersInParty = party.getPlayersInParty(playerPartyId)
        local partySize = #playersInParty
        for _, playerId in pairs(playersInParty) do
            local heroUnit = hero.getHero(playerId)
            local heroLevel = GetHeroLevel(heroUnit)
            AddHeroXP(
                heroUnit,
                getExp(heroLevel, dyingUnitLevel, partySize, isElite),
                true)
        end
    else
        local heroLevel = GetHeroLevel(killingUnit)
        AddHeroXP(
            killingUnit, getExp(heroLevel, dyingUnitLevel, 1, isElite), true)
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