local Code = require('src/saveload/code.lua')
local backpack = require('src/items/backpack.lua')
local equipment = require('src/items/equipment.lua')
local hero = require('src/hero.lua')
local log = require('src/log.lua')

function onLoad()
    local fullStr = GetEventPlayerChatString()
    local code = string.sub(fullStr, 7)
    local playerId = GetPlayerId(GetTriggerPlayer())

    if hero.getHero(playerId) ~= nil then
        log.log(
            playerId,
            'You already have a hero. Type -repick and then try again.',
            log.TYPE.ERROR)
        return
    end

    local decoded = Code:fromStr(code)

    local level = decoded:getInt(73)
    local heroId = decoded:getInt(73)

    for i=0,35,1 do
        local itemId = decoded:getInt(73)
        backpack.addItemIdToBackpackPosition(playerId, i, itemId)
    end

    local nameEncoded = decoded:getInt(2500)
    if nameEncoded ~= string.byte(GetPlayerName(Player(playerId))) % 2500 then
        print("Code appears to be for another player, but allowing it during alpha anyway")
    end

    for i=1,9,1 do
        local itemId = decoded:getInt(73)
        equipment.equipItem(playerId, i, itemId)
    end

    local validCode = decoded:verify()

    if not validCode then
        print("Code wasnt valid but allowing through during alpha anyway")
    end

    hero.restorePickedHero(playerId, heroId, level)
end

function init()
    local saveTrigger = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        TriggerRegisterPlayerChatEvent(saveTrigger, Player(i), "-load", false)
    end
    TriggerAddAction(saveTrigger, onLoad)
end

return {
    init = init,
}