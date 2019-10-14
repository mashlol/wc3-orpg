local party = require('src/party.lua')
local hero = require('src/hero.lua')

local BASE_EXP = 10
local ELITE_BASE_EXP = 30

local PARTY_MULTIPLIER = {1, 0.9, 0.8, 0.7, 0.6}

function getExp(heroLevel, mobLevel, numShared, isElite)
    local delta = mobLevel - heroLevel

    -- No exp for anything 5 levels above or 5 levels below
    if delta < -5 then
        return 0
    end

    local baseExp = isElite and ELITE_BASE_EXP or BASE_EXP

    delta = math.min(delta, 5)
    numShared = math.min(numShared, 5)
    local multiplier = PARTY_MULTIPLIER[numShared]
    return R2I(math.max((baseExp + baseExp * delta / 5) * multiplier, 1))
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
            if IsUnitInRange(heroUnit, killingUnit, 5000) then
                local heroLevel = GetHeroLevel(heroUnit)
                AddHeroXP(
                    heroUnit,
                    getExp(heroLevel, dyingUnitLevel, partySize, isElite),
                    true)
            end
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