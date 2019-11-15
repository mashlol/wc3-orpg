local hero = require('src/hero.lua')
local buff = require('src/buff.lua')

local TALENTS = {
    [FourCC("Hazr")] = {
        {
            name = "Impending Doom",
            icon = "ReplaceableTextures\\CommandButtons\\BTNSoulBurn.blp",
            buffName = "impendingdoom",
        },
    },
}

function getInfoFromIndex(playerId, talentIndex)
    local heroUnit = hero.getHero(playerId)
    local heroType = GetUnitTypeId(heroUnit)
    local talentList = TALENTS[heroType]
    return heroUnit, talentList[talentIndex]
end

function learnTalent(playerId, talentIndex)
    local heroUnit, talentInfo = getInfoFromIndex(playerId, talentIndex)
    local buffName = talentInfo.buffName
    local numStacks = getBuffStacks(heroUnit, buffName)
    numStacks = numStacks + 1
    if numStacks >= (buff.BUFF_INFO[buffName].maxStacks or 1) then
        return false
    end
    buff.addBuff(heroUnit, heroUnit, buffName)
    return true
end

function getNumPointsInTalent(playerId, talentIndex)
    local heroUnit, talentInfo = getInfoFromIndex(playerId, talentIndex)
    local buffName = talentInfo.buffName
    return getBuffStacks(heroUnit, buffName)
end

return {
    TALENTS = TALENTS,
    learnTalent = learnTalent,
    getNumPointsInTalent = getNumPointsInTalent,
}
