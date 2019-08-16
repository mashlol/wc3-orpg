local hero = require('src/hero.lua')
local keyboard = require('src/keyboard.lua')
local mouse = require('src/mouse.lua')
local projectile = require('src/projectile.lua')
local cleanup = require('src/cleanup.lua')
local effect = require('src/effect.lua')
local ui = require('src/ui.lua')
local leaver = require('src/leaver.lua')
local casttime = require('src/casttime.lua')
local buff = require('src/buff.lua')
local target = require('src/target.lua')
local damage = require('src/damage.lua')

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
    effect.init()
    ui.init()
    leaver.init()
    casttime.init()
    buff.init()
    target.init()
    damage.init()

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
