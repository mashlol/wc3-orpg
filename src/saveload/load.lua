local Code = require('src/saveload/code.lua')
local backpack = require('src/items/backpack.lua')
local equipment = require('src/items/equipment.lua')
local hero = require('src/hero.lua')
local log = require('src/log.lua')

function onLoad()
    local fullStr = GetEventPlayerChatString()
    local code = string.sub(fullStr, 7)
    local playerId = GetPlayerId(GetTriggerPlayer())

    -- TODO make sure they dont already have a hero

    local decoded = Code:fromStr(code)

    local level = decoded:getInt(74)
    local heroId = decoded:getInt(74)

    print('level is ', level)

    -- for i=0,35,1 do
    --     local itemId = decoded:getInt(74)
    --     backpack.addItemIdToBackpackPosition(playerId, i, itemId)
    -- end

    -- for i=1,9,1 do
    --     local itemId = decoded:getInt(74)
    --     equipment.equipItem(playerId, i, itemId)
    -- end

    -- TODO verify properly
    print("Valid code?: ", decoded:verify())

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