local spell = require("src/spell.lua")
local hero = require("src/hero.lua")
local Backpack = require("src/ui/backpack.lua")
local Equipment = require("src/ui/equipment.lua")
local Stats = require("src/ui/stats.lua")
local QuestLog = require("src/ui/questlog.lua")
local ItemBar = require("src/ui/itembar.lua")
local Map = require("src/ui/map.lua")
local itemmanager = require("src/items/itemmanager.lua")
local backpack = require("src/items/backpack.lua")

-- TODO let people customize keybindings
local KEY_MAPPING = {
    [OSKEY_Q] = 1,
    [OSKEY_W] = 2,
    [OSKEY_E] = 3,
    [OSKEY_R] = 4,
    [OSKEY_D] = 5,
    [OSKEY_F] = 6,
    -- [OSKEY_Z] = 9,
    -- [OSKEY_X] = 10,
    -- [OSKEY_C] = 11,
    -- [OSKEY_V] = 12,
}

local ITEMBAR_KEY_MAPPING = {
    [OSKEY_1] = 1,
    [OSKEY_2] = 2,
    [OSKEY_3] = 3,
    [OSKEY_4] = 4,
    [OSKEY_5] = 5,
    [OSKEY_6] = 6,
}

local SUPPORTED_KEYS = {
    OSKEY_Q,
    OSKEY_W,
    OSKEY_E,
    OSKEY_R,
    OSKEY_A,
    OSKEY_D,
    OSKEY_F,
    OSKEY_Z,
    OSKEY_X,
    OSKEY_C,
    OSKEY_V,
    OSKEY_B,
    OSKEY_O,
    OSKEY_U,
    OSKEY_L,
    OSKEY_M,
    OSKEY_1,
    OSKEY_2,
    OSKEY_3,
    OSKEY_4,
    OSKEY_5,
    OSKEY_6,
}

local keyPressed = function()
    local pressedKey = BlzGetTriggerPlayerKey()
    local playerId = GetPlayerId(GetTriggerPlayer())
    if KEY_MAPPING[pressedKey] then
        spell.castSpell(
            playerId,
            KEY_MAPPING[pressedKey])
        return
    end

    if ITEMBAR_KEY_MAPPING[pressedKey] then
        local itemId = ItemBar.getItemIdInSlot(
            playerId, ITEMBAR_KEY_MAPPING[pressedKey])
        local count = backpack.getItemCount(playerId, itemId)
        local itemInfo = itemmanager.getItemInfo(itemId)
        if itemInfo ~= nil and count > 0 then
            local spellKey = itemInfo.spell
            if spellKey ~= nil then
                local result = spell.castSpellByKey(playerId, spellKey)
                if result == true then
                    backpack.removeItemIdFromBackpack(playerId, itemId)
                end
            end
        end
    end

    -- TODO figure out key mappings
    if pressedKey == OSKEY_B then
        Backpack.toggle(playerId)
    elseif pressedKey == OSKEY_C then
        Equipment.toggle(playerId)
        Stats.toggle(playerId)
    elseif pressedKey == OSKEY_L then
        QuestLog.toggle(playerId)
    elseif pressedKey == OSKEY_M then
        -- Prevent move hotkey
        if GetPlayerId(GetLocalPlayer()) == playerId then
            ForceUICancel()
        end
        Map.toggle(playerId)
    end
end

local spaceDown = function()
    SetCameraTargetControllerNoZForPlayer(
        GetTriggerPlayer(),
        hero.getHero(GetPlayerId(GetTriggerPlayer())),
        0,
        0,
        false)
end

local spaceUp = function()
    if GetLocalPlayer() == GetTriggerPlayer() then
        ResetToGameCamera(0)
        CameraSetupApplyForceDuration(gg_cam_Camera_001, false, 0)
    end
end

local init = function()
    local trigger = CreateTrigger()

    -- TODO make for all players
    for i=0,bj_MAX_PLAYER_SLOTS-1,1 do
        for idx, key in pairs(SUPPORTED_KEYS) do
            BlzTriggerRegisterPlayerKeyEvent(trigger, Player(i), key, 0, true)
        end
    end

    TriggerAddAction(trigger, keyPressed)

    local spaceDownTrigger = CreateTrigger()

    for i=0,bj_MAX_PLAYER_SLOTS-1,1 do
        BlzTriggerRegisterPlayerKeyEvent(
            spaceDownTrigger, Player(i), OSKEY_SPACE, 0, true)
    end

    TriggerAddAction(spaceDownTrigger, spaceDown)

    local spaceUpTrigger = CreateTrigger()

    for i=0,bj_MAX_PLAYER_SLOTS-1,1 do
        BlzTriggerRegisterPlayerKeyEvent(
            spaceUpTrigger, Player(i), OSKEY_SPACE, 0, false)
    end

    TriggerAddAction(spaceUpTrigger, spaceUp)
end

return {
    init = init,
}
