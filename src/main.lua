local hero = require('src/hero.lua')
local keyboard = require('src/keyboard.lua')
local mouse = require('src/mouse.lua')
local projectile = require('src/projectile.lua')
local cleanup = require('src/cleanup.lua')
local uiMain = require('src/ui/main.lua')
local leaver = require('src/leaver.lua')
local casttime = require('src/casttime.lua')
local buffloop = require('src/buffloop.lua')
local target = require('src/target.lua')
local damage = require('src/damage.lua')
local cooldowns = require('src/spells/cooldowns.lua')

local unitmap = require('src/unitmap.lua')

-- TODO create a boss manager
local turtle = require('src/bosses/turtle.lua')

local debug = require('src/debug.lua')

local mainInit = function()
    BlzEnableTargetIndicator(true)
    BlzEnableSelections(false, false)

    hero.init()
    keyboard.init()
    mouse.init()
    projectile.init()
    cleanup.init()
    uiMain.init()
    leaver.init()
    casttime.init()
    buffloop.init()
    target.init()
    damage.init()
    cooldowns.init()

    turtle.init()

    -- TODO remove for release
    debug.init()
end

-- This is a special top-level function which we will use to replace
-- Instances of CreateUnit from the original lua script in the map.
function CreateTargetableUnit(player, unit, x, y, facing)
    return unitmap.createTargetableUnit(player, unit, x, y, facing)
end

TimerStart(CreateTimer(), 0.0, false, mainInit)
