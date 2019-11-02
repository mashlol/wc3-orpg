local hero = require('src/hero.lua')
local keyboard = require('src/keyboard.lua')
local mouse = require('src/mouse.lua')
local projectile = require('src/projectile.lua')
local cleanup = require('src/cleanup.lua')
local uiMain = require('src/ui/main.lua')
local uieventhandler = require('src/ui/uieventhandler.lua')
local leaver = require('src/leaver.lua')
local casttime = require('src/casttime.lua')
local buffloop = require('src/buffloop.lua')
local target = require('src/target.lua')
local damage = require('src/damage.lua')
local party = require('src/party.lua')
local arena = require('src/arena.lua')
local threat = require('src/threat.lua')
local exp = require('src/exp.lua')
local camera = require('src/camera.lua')
local kill = require('src/kill.lua')
local zones = require('src/zones.lua')
local spawnpoint = require('src/spawnpoint.lua')
local spell = require('src/spell.lua')
local gc = require('src/gc.lua')
local tips = require('src/tips.lua')
local combat = require('src/combat.lua')
local respawncreeps = require('src/respawncreeps.lua')
local questMain = require('src/quests/main.lua')
local save = require('src/saveload/save.lua')
local load = require('src/saveload/load.lua')
local buffmanager = require('src/buffs/buffmanager.lua')
local cooldowns = require('src/spells/cooldowns.lua')
local drops = require('src/items/drops.lua')
local backpack = require('src/items/backpack.lua')
local equipment = require('src/items/equipment.lua')
local itemmanager = require('src/items/itemmanager.lua')
local vendor = require('src/items/vendor.lua')
local bossmanager = require('src/bosses/bossmanager.lua')
local dungeonmanager = require('src/dungeons/dungeonmanager.lua')

local debug = require('src/debug.lua')

local mainInit = function()
    hero.init()
    keyboard.init()
    mouse.init()
    projectile.init()
    cleanup.init()
    uiMain.init()
    uieventhandler.init()
    leaver.init()
    casttime.init()
    buffloop.init()
    target.init()
    damage.init()
    party.init()
    arena.init()
    threat.init()
    exp.init()
    camera.init()
    kill.init()
    zones.init()
    spell.init()
    gc.init()
    tips.init()
    combat.init()
    questMain.init()
    save.init()
    load.init()
    buffmanager.init()
    cooldowns.init()
    drops.init()
    backpack.init()
    equipment.init()
    itemmanager.init()
    vendor.init()
    bossmanager.init()
    dungeonmanager.init()

    -- Intentionally after bossmanager to record boss locations
    spawnpoint.init()
    respawncreeps.init()

    if __DEBUG__ == true then
        print('Running in debug mode.')
        debug.init()
    end

    -- TODO maybe move to a door module
    ModifyGateBJ(bj_GATEOPERATION_OPEN, gg_dest_LTe1_1457)
    ModifyGateBJ(bj_GATEOPERATION_OPEN, gg_dest_LTe1_1422)
end

local realTimerStart = TimerStart
TimerStart = function(timer, duration, repeating, callback)
    local pcallback = function()
        if callback == nil then return end
        local status, err = pcall(callback)
        if not status then
            print(err)
        end
    end
    realTimerStart(timer, duration, repeating, pcallback)
end

local realTriggerAddAction = TriggerAddAction
TriggerAddAction = function(trig, callback)
    local pcallback = function()
        local status, err = pcall(callback)
        if not status then
            print(err)
        end
    end
    realTriggerAddAction(trig, pcallback)
end

TimerStart(CreateTimer(), 0.0, false, mainInit)

collectgarbage("stop")

return {
    mainInit = mainInit,
}
