-- Generic
local heal = require('src/spells/generic/heal.lua')
local attack = require('src/spells/generic/attack.lua')
local stop = require('src/spells/generic/stop.lua')

-- Azora
local fireball = require('src/spells/azora/fireball.lua')
local frostnova = require('src/spells/azora/frostnova.lua')
local frostorb = require('src/spells/azora/frostorb.lua')
local blink = require('src/spells/azora/blink.lua')
local meteor = require('src/spells/azora/meteor.lua')
local firelance = require('src/spells/azora/firelance.lua')
local phoenix = require('src/spells/azora/phoenix.lua')
local fireshell = require('src/spells/azora/fireshell.lua')
local icicle = require('src/spells/azora/icicle.lua')
local firestorm = require('src/spells/azora/firestorm.lua')
local frostballs = require('src/spells/azora/frostballs.lua')

-- Yuji
local slash = require('src/spells/yuji/slash.lua')
local dash = require('src/spells/yuji/dash.lua')
local throwingstar = require('src/spells/yuji/throwingstar.lua')
local slashult = require('src/spells/yuji/slashult.lua')
local focus = require('src/spells/yuji/focus.lua')
local jab = require('src/spells/yuji/jab.lua')
local stun = require('src/spells/yuji/stun.lua')
local blind = require('src/spells/yuji/blind.lua')

-- Stormfist
local punch = require('src/spells/stormfist/punch.lua')

-- Tarcza
local whirlwind = require('src/spells/tarcza/whirlwind.lua')
local curshout = require('src/spells/tarcza/curshout.lua')
local shieldcharge = require('src/spells/tarcza/shieldcharge.lua')
local stalwartshell = require('src/spells/tarcza/stalwartshell.lua')
local boomerang = require('src/spells/tarcza/boomerang.lua')
local bulwark = require('src/spells/tarcza/bulwark.lua')
local blitz = require('src/spells/tarcza/blitz.lua')
local challenge = require('src/spells/tarcza/challenge.lua')
local flag = require('src/spells/tarcza/flag.lua')

-- Ivanov
local rejuvpot = require('src/spells/ivanov/rejuvpot.lua')
local armorpot = require('src/spells/ivanov/armorpot.lua')
local molecregen = require('src/spells/ivanov/molecregen.lua')
local corrosiveblast = require('src/spells/ivanov/corrosiveblast.lua')
local accmist = require('src/spells/ivanov/accmist.lua')
local cleansingpot = require('src/spells/ivanov/cleansingpot.lua')
local hulkingpot = require('src/spells/ivanov/hulkingpot.lua')
local dampenpot = require('src/spells/ivanov/dampenpot.lua')
local pocketgoo = require('src/spells/ivanov/pocketgoo.lua')

local hero = require('src/hero.lua')
local cooldowns = require('src/spells/cooldowns.lua')

local SPELL_MAP = {
    -- Generic
    heal = heal,
    attack = attack,
    stop = stop,

    -- Azora
    fireball = fireball,
    frostnova = frostnova,
    frostorb = frostorb,
    blink = blink,
    meteor = meteor,
    firelance = firelance,
    phoenix = phoenix,
    fireshell = fireshell,
    icicle = icicle,
    firestorm = firestorm,
    frostballs = frostballs,

    -- Yuji
    slash = slash,
    dash = dash,
    throwingstar = throwingstar,
    slashult = slashult,
    focus = focus,
    jab = jab,
    stun = stun,
    blind = blind,

    -- Stormfist
    punch = punch,

    -- Tarcza
    whirlwind = whirlwind,
    curshout = curshout,
    shieldcharge = shieldcharge,
    stalwartshell = stalwartshell,
    boomerang = boomerang,
    bulwark = bulwark,
    blitz = blitz,
    challenge = challenge,
    flag = flag,

    -- Ivanov
    rejuvpot = rejuvpot,
    armorpot = armorpot,
    molecregen = molecregen,
    corrosiveblast = corrosiveblast,
    accmist = accmist,
    cleansingpot = cleansingpot,
    hulkingpot = hulkingpot,
    dampenpot = dampenpot,
    pocketgoo = pocketgoo,
}

local SKILL_LEVELS = {1, 2, 3, 5, 1, 1, 7, 10, 15, 20, 30, 50}
local SKILL_LEVELS = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}

local TOOLTIPS = {}

local getSpellKey = function(playerId, idx)
    local pickedHero = hero.getPickedHero(playerId)
    if pickedHero == nil then
        return nil
    end
    local heroLevel = GetHeroLevel(hero.getHero(playerId))
    if heroLevel < SKILL_LEVELS[idx] then
        return nil
    end
    return pickedHero.spells[idx]
end

local getSpell = function(playerId, idx)
    local spellKey = getSpellKey(playerId, idx)
    if spellKey == nil then
        return nil
    end
    return SPELL_MAP[spellKey]
end

local castSpell = function(playerId, idx)
    if IsUnitPaused(hero.getHero(playerId)) then
        return
    end

    if GetUnitState(hero.getHero(playerId), UNIT_STATE_LIFE) <= 0 then
        return
    end

    local spell = getSpell(playerId, idx)
    if spell ~= nil then
        spell.cast(playerId)
    end
end

local getCooldown = function(playerId, idx)
    local spell = getSpell(playerId, idx)
    if spell ~= nil then
        return cooldowns.getRemainingCooldown(playerId, spell.getSpellId())
    end
    return 0
end

local getCooldownPct = function(playerId, idx)
    local spell = getSpell(playerId, idx)
    if spell ~= nil then
        local spellId = spell.getSpellId()
        local totalCd = cooldowns.getTotalCooldown(playerId, spellId)
        local remainingCd = cooldowns.getRemainingCooldown(playerId, spellId)
        if totalCd ~= 0 then
            return remainingCd / totalCd
        end
    end
    return 1
end

local getIcon = function(playerId, idx)
    local spell = getSpell(playerId, idx)
    if spell ~= nil then
        return spell.getIcon()
    end
    return ""
end

local getSpellTooltip = function(playerId, idx)
    local spellKey = getSpellKey(playerId, idx)
    if spellKey ~= nil then
        return TOOLTIPS[spellKey]
    end
    return ""
end

local init = function()
    for idx, spell in pairs(SPELL_MAP) do
        local spellName = spell.getSpellName()
        local spellCooldown = spell.getSpellCooldown()
        local spellCasttime = spell.getSpellCasttime()
        local spellTooltip = spell.getSpellTooltip()

        TOOLTIPS[idx] =
            "|cff155ed4"..spellName.."|r|n|n"..
            "Cooldown: "..spellCooldown.."s|n"..
            "Cast time: "..spellCasttime.."s|n"..
            "|n"..spellTooltip
    end
end

return {
    init = init,
    castSpell = castSpell,
    getCooldown = getCooldown,
    getCooldownPct = getCooldownPct,
    getIcon = getIcon,
    getSpellTooltip = getSpellTooltip,
}
