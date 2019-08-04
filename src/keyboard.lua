local spell = require("src/spell.lua")
local hero = require("src/hero.lua")

-- TODO let people customize keybindings
local KEY_MAPPING = {
    [OSKEY_Q] = 1,
    [OSKEY_W] = 2,
    [OSKEY_E] = 3,
    [OSKEY_R] = 4,
    [OSKEY_F] = 8,
}

local keyPressed = function()
    spell.castSpell(
        GetPlayerId(GetTriggerPlayer()),
        KEY_MAPPING[BlzGetTriggerPlayerKey()])
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
    ResetToGameCameraForPlayer(GetTriggerPlayer(), 0)
end

local init = function()
    local trigger = CreateTrigger()

    -- TODO make for all players
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(0), OSKEY_Q, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(1), OSKEY_Q, 0, true)

    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(0), OSKEY_W, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(1), OSKEY_W, 0, true)

    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(0), OSKEY_E, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(1), OSKEY_E, 0, true)

    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(0), OSKEY_R, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(1), OSKEY_R, 0, true)

    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(0), OSKEY_F, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(1), OSKEY_F, 0, true)

    TriggerAddAction(trigger, keyPressed)

    local spaceDownTrigger = CreateTrigger()

    BlzTriggerRegisterPlayerKeyEvent(
        spaceDownTrigger, Player(0), OSKEY_SPACE, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(
        spaceDownTrigger, Player(1), OSKEY_SPACE, 0, true)

    TriggerAddAction(spaceDownTrigger, spaceDown)

    local spaceUpTrigger = CreateTrigger()

    BlzTriggerRegisterPlayerKeyEvent(
        spaceUpTrigger, Player(0), OSKEY_SPACE, 0, false)
    BlzTriggerRegisterPlayerKeyEvent(
        spaceUpTrigger, Player(1), OSKEY_SPACE, 0, false)

    TriggerAddAction(spaceUpTrigger, spaceUp)
end

return {
    init = init,
}
