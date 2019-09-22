local log = require('src/log.lua')

local TIPS = {
    "You can press B to open your equipment and backpack views.",
    "You can press L to open the quest log.",
    "You can disband quests from the quest log (press L).",
    "You can invite players to your party with -party #.",
    "Quest progress is shared within a party",
    "Join us on discord! https://discord.gg/AbBsrM9",
    "Most spells are cast toward the location of your mouse.",
    "Report bugs or give suggestions on discord: https://discord.gg/AbBsrM9",
    "You can type -tips to toggle tips on or off.",
    "You can save your character with -save (and load with -load)",
    "Saves are written to a file, so you can just type -load to get it back",
}

local tipsForce

local showTip = function()
    DisplayTextToForce(
        GetPlayersAll(),
        "|cff1eafd4TIP:|r "..TIPS[GetRandomInt(1, #TIPS)])
end

local toggleTips = function()
    local player = GetTriggerPlayer()

    if IsPlayerInForce(player, tipsForce) then
        log.log(
            GetPlayerId(player),
            'You won\'t see any more tips. You can type -tips to re-enable them.',
            log.TYPE.INFO)
        ForceRemovePlayer(tipsForce, player)
    else
        log.log(
            GetPlayerId(player),
            'You\'ll start seeing tips again.',
            log.TYPE.INFO)
        ForceAddPlayer(tipsForce, player)
    end
end

local init = function()
    tipsForce = CreateForce()
    for i=0,bj_MAX_PLAYERS-1,1 do
        ForceAddPlayer(tipsForce, Player(i))
    end
    TimerStart(CreateTimer(), 30, true, showTip)

    local tipsTrigger = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        TriggerRegisterPlayerChatEvent(tipsTrigger, Player(i), "-tips", true)
    end
    TriggerAddAction(tipsTrigger, toggleTips)
end

return {
    init = init,
}
