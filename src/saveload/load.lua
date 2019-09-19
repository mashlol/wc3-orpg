local Code = require('src/saveload/code.lua')
local backpack = require('src/items/backpack.lua')
local equipment = require('src/items/equipment.lua')
local hero = require('src/hero.lua')
local log = require('src/log.lua')

function onLoad()
    print('onload')
    local fullStr = GetEventPlayerChatString()
    local code = string.sub(fullStr, 7)
    local playerId = GetPlayerId(GetTriggerPlayer())

    -- TODO make sure they dont already have a hero

    local decoded = Code:fromStr(code)

    local level = decoded:getInt(74)
    local heroId = decoded:getInt(74)
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