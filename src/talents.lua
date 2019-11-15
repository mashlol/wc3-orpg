local hero = require('src/hero.lua')
local buff = require('src/buff.lua')

local TALENTS = {
    [FourCC("Hazr")] = {
        [0] = {
            [2] = {
                name = "Impending Doom",
                description = "Each point gives an extra orb on Fire Orbs.",
                icon = "ReplaceableTextures\\CommandButtons\\BTNSoulBurn.blp",
                buffName = "impendingdoom",
                numRequiredPoints = 0,
            },
        },
        [1] = {
            [2] = {
                name = "Far Blinking",
                description = "Increases the distance you can blink by 50 each point.",
                icon = "ReplaceableTextures\\CommandButtons\\BTNBlink.blp",
                buffName = "farblinking",
                numRequiredPoints = 5,
            }
        },
    },
}

function getInfoFromIndex(playerId, x, y)
    local heroUnit = hero.getHero(playerId)
    local heroType = GetUnitTypeId(heroUnit)
    local talentList = TALENTS[heroType]
    return heroUnit, talentList[y][x]
end

function getTotalPointsSpent(playerId)
    local heroUnit = hero.getHero(playerId)
    local heroType = GetUnitTypeId(heroUnit)
    local talentList = TALENTS[heroType]
    local total = 0
    for y, cols in pairs(talentList) do
        for x, talentInfo in pairs(cols) do
            total = total + getBuffStacks(heroUnit, talentInfo.buffName)
        end
    end
    return total
end

function canLearnTalent(playerId, x, y)
    local heroUnit, talentInfo = getInfoFromIndex(playerId, x, y)
    local buffName = talentInfo.buffName
    local numStacks = getBuffStacks(heroUnit, buffName)
    numStacks = numStacks + 1
    if numStacks > getTalentMaxLevel(playerId, x, y) then
        return false
    end
    local totalPointsSpent = getTotalPointsSpent(playerId)
    if totalPointsSpent < talentInfo.numRequiredPoints then
        return false
    end
    return true
end

function learnTalent(playerId, x, y)
    local heroUnit, talentInfo = getInfoFromIndex(playerId, x, y)
    local buffName = talentInfo.buffName
    if not canLearnTalent(playerId, x, y) then
        return false
    end
    buff.addBuff(heroUnit, heroUnit, buffName)
    return true
end

function getTalentMaxLevel(playerId, x, y)
    local _, talentInfo = getInfoFromIndex(playerId, x, y)
    return buff.BUFF_INFO[talentInfo.buffName].maxStacks or 1
end

function getNumPointsInTalent(playerId, x, y)
    local heroUnit, talentInfo = getInfoFromIndex(playerId, x, y)
    local buffName = talentInfo.buffName
    return getBuffStacks(heroUnit, buffName)
end

return {
    TALENTS = TALENTS,
    learnTalent = learnTalent,
    getNumPointsInTalent = getNumPointsInTalent,
    getTalentMaxLevel = getTalentMaxLevel,
    canLearnTalent = canLearnTalent,
}
