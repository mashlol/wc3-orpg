local Code = require('src/saveload/code.lua')
local file = require('src/saveload/file.lua')
local backpack = require('src/items/backpack.lua')
local equipment = require('src/items/equipment.lua')
local hero = require('src/hero.lua')
local log = require('src/log.lua')

local SYNC_PREFIX = "sync-load-code"

function loadChar(playerId, code)
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

    local backpackItems = {}
    for i=1,36,1 do
        local itemId = decoded:getInt(73)
        if itemId ~= 0 then
            backpackItems[i] = itemId
        end
    end

    local nameEncoded = decoded:getInt(2500)
    if nameEncoded ~= string.byte(GetPlayerName(Player(playerId))) % 2500 then
        log.log(
            playerId,
            'Invalid code',
            log.TYPE.ERROR)
        return
    end

    local equips = {}
    for i=1,9,1 do
        local itemId = decoded:getInt(73)
        if itemId ~= 0 then
            equips[i] = itemId
        end
    end

    local validCode = decoded:verify()

    if not validCode then
        log.log(
            playerId,
            'Invalid code',
            log.TYPE.ERROR)
        return
    end

    for idx,itemId in pairs(backpackItems) do
        backpack.addItemIdToBackpackPosition(playerId, idx, itemId)
    end
    for slot,itemId in pairs(equips) do
        equipment.equipItem(playerId, slot, itemId)
    end

    hero.restorePickedHero(playerId, heroId, level)
end

function onDataSynced()
    loadChar(GetPlayerId(GetTriggerPlayer()), BlzGetTriggerSyncData())
end

function onLoad()
    local fullStr = GetEventPlayerChatString()
    local code = string.sub(fullStr, 7)
    local playerId = GetPlayerId(GetTriggerPlayer())

    if code == "" then
        if playerId == GetPlayerId(GetLocalPlayer()) then
            BlzSendSyncData(SYNC_PREFIX, file.readFile("tvt/tvtsave1.pld"))
        end
        return
    end

    loadChar(playerId, code)
end

function init()
    local loadTrigger = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        TriggerRegisterPlayerChatEvent(loadTrigger, Player(i), "-load", false)
    end
    TriggerAddAction(loadTrigger, onLoad)

    local syncLoadTrigger = CreateTrigger()
    for i=0,bj_MAX_PLAYERS-1, 1 do
        BlzTriggerRegisterPlayerSyncEvent(syncLoadTrigger, Player(i), SYNC_PREFIX, false)
    end
    TriggerAddAction(syncLoadTrigger, onDataSynced)
end

return {
    init = init,
}