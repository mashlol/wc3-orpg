local Code = require('src/saveload/code.lua')
local file = require('src/saveload/file.lua')
local backpack = require('src/items/backpack.lua')
local equipment = require('src/items/equipment.lua')
local hero = require('src/hero.lua')
local log = require('src/log.lua')

function onSave()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local heroUnit = hero.getHero(playerId)
    local pickedHeroId = hero.getPickedHero(playerId).storedId

    local code = Code:new()
        :addInt(GetHeroXP(heroUnit), 200000)
        :addInt(pickedHeroId, 73)
        :addInt(math.floor(GetUnitX(heroUnit) + 32000), 64000)
        :addInt(math.floor(GetUnitY(heroUnit) + 32000), 64000)

    for i=1,36,1 do
        code:addInt(backpack.getItemIdAtPosition(playerId, i) or 0, 73)
    end

    code:addInt(string.byte(GetPlayerName(Player(playerId))) % 2500, 2500)

    for i=1,9,1 do
        code:addInt(equipment.getItemInSlot(playerId, i) or 0, 73)
    end

    code = code:build()

    log.log(playerId, 'Your code is: '..code, log.TYPE.NORMAL)
    file.writeFile("tvt/tvtsave1.pld", code)
    log.log(
        playerId,
        'It\'s been saved to a local file too, but you might want to still '..
        'screenshot it just in case.',
        log.TYPE.WARNING)
    log.log(
        playerId,
        'NOTE THIS IS AN ALPHA AND THE CODE MAY NOT WORK IN FUTURE VERSIONS',
        log.TYPE.WARNING)
end

function init()
    local saveTrigger = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        TriggerRegisterPlayerChatEvent(saveTrigger, Player(i), "-save", true)
    end
    TriggerAddAction(saveTrigger, onSave)
end

return {
    init = init,
}