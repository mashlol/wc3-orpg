local Code = require('src/saveload/code.lua')
local file = require('src/saveload/file.lua')
local backpack = require('src/items/backpack.lua')
local equipment = require('src/items/equipment.lua')
local hero = require('src/hero.lua')
local log = require('src/log.lua')
local quests = require('src/quests/main.lua')

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

    local exp = decoded:getInt(200000)
    local heroId = decoded:getInt(73)
    local gold = decoded:getInt(200000)
    local heroX = decoded:getInt(64000) - 32000
    local heroY = decoded:getInt(64000) - 32000

    local numQuests = decoded:getInt(5000)
    local progress = {}
    for i=0, math.floor(numQuests / 6), 1 do
        local questInfo = decoded:getInt(65)
        for j=6, 1, -1 do
            local res = questInfo & 1
            if res == 1 then
                progress[j + i * 6] = {
                    completed = true,
                    objectives = {},
                }
            end
            questInfo = questInfo >> 1
        end
    end

    local backpackItems = {}
    for i=1,36,1 do
        local itemId = decoded:getInt(73)
        local count = decoded:getInt(73)
        if itemId ~= 0 then
            backpackItems[i] = {itemId = itemId, count = count}
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

    quests.restoreProgress(playerId, progress)

    for idx,itemInfo in pairs(backpackItems) do
        if itemInfo.itemId ~= 0 and itemInfo.count ~= 0 then
            backpack.addItemIdToBackpackPosition(
                playerId, idx, itemInfo.itemId, itemInfo.count)
        end
    end
    for slot,itemId in pairs(equips) do
        equipment.equipItem(playerId, slot, itemId)
    end

    SetPlayerState(Player(playerId), PLAYER_STATE_RESOURCE_GOLD, gold)

    hero.restorePickedHero(playerId, heroId, exp, heroX, heroY)
end

function onDataSynced()
    loadChar(GetPlayerId(GetTriggerPlayer()), BlzGetTriggerSyncData())
end

function loadFromFile(playerId, fileIndex)
    if playerId == GetPlayerId(GetLocalPlayer()) then
        local fileInfo = file.readFile("tvtsave" .. fileIndex .. ".pld")
        local pipeCharLoc = string.find(fileInfo, '|', 0, true)
        local code
        if pipeCharLoc == nil then
            code = fileInfo
        else
            code = string.sub(fileInfo, 1, pipeCharLoc - 1)
        end
        BlzSendSyncData(SYNC_PREFIX, code)
    end
end

function init()
    local syncLoadTrigger = CreateTrigger()
    for i=0,bj_MAX_PLAYERS-1, 1 do
        BlzTriggerRegisterPlayerSyncEvent(
            syncLoadTrigger, Player(i), SYNC_PREFIX, false)
    end
    TriggerAddAction(syncLoadTrigger, onDataSynced)
end

return {
    init = init,
    loadFromFile = loadFromFile,
}