-- Items
local healpot1 = require('src/spells/items/healpot1.lua')
local food1 = require('src/spells/items/food1.lua')
local hearthstone = require('src/spells/items/hearthstone.lua')

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
local gauntlet = require('src/spells/stormfist/gauntlet.lua')

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
local log = require('src/log.lua')
local cooldowns = require('src/spells/cooldowns.lua')
local casttime = require('src/casttime.lua')

local SPELL_MAP = {
    -- Items
    healpot1 = healpot1,
    food1 = food1,
    hearthstone = hearthstone,

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
    gauntlet = gauntlet,

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

local SKILL_LEVELS = {1, 2, 3, 5, 7, 10}

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

local castSpellByKey = function(playerId, spellKey)
    if casttime.isCasting(playerId) then
        return false
    end

    if IsUnitPaused(hero.getHero(playerId)) then
        return false
    end

    if GetUnitState(hero.getHero(playerId), UNIT_STATE_LIFE) <= 0 then
        return false
    end

    local spell = SPELL_MAP[spellKey]
    if spell ~= nil then
        return spell.cast(playerId)
    end
    return false
end

local castSpell = function(playerId, idx)
    local spellKey = getSpellKey(playerId, idx)
    castSpellByKey(playerId, spellKey)
end

local getCooldown = function(playerId, idx)
    local spell = getSpell(playerId, idx)
    if spell ~= nil then
        return cooldowns.getRemainingCooldown(playerId, spell.getSpellId())
    end
    return 0
end

local getCooldownPctBySpellKey = function(playerId, spellKey)
    local spell = SPELL_MAP[spellKey]
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

local getCooldownPct = function(playerId, idx)
    local spellKey = getSpellKey(playerId, idx)
    return getCooldownPctBySpellKey(playerId, spellKey)
end

local getIconBySpellKey = function(spellKey)
    local spell = SPELL_MAP[spellKey]
    if spell ~= nil then
        return spell.getIcon()
    end
    return nil
end

local getIcon = function(playerId, idx)
    local spellKey = getSpellKey(playerId, idx)
    return getIconBySpellKey(spellKey)
end

local getSpellTooltipBySpellKey = function(spellKey)
    if spellKey ~= nil then
        return TOOLTIPS[spellKey]
    end
    return ""
end

local getSpellTooltip = function(playerId, idx)
    return getSpellTooltipBySpellKey(getSpellKey(playerId, idx))
end

function checkNewSpellsOnLevel()
    local heroUnit = GetLevelingUnit()
    local playerId = GetPlayerId(GetOwningPlayer(heroUnit))
    local level = GetHeroLevel(heroUnit)
    for spellIdx, requiredLevel in pairs(SKILL_LEVELS) do
        if requiredLevel == level then
            local unlockedSpell = getSpell(playerId, spellIdx)
            if unlockedSpell ~= nil then
                log.log(
                    playerId,
                    "You learned |cff155ed4" ..
                        unlockedSpell.getSpellName() ..
                        ".|r",
                    log.TYPE.INFO)
            end
        end
    end
end

local init = function()
    for idx, spell in pairs(SPELL_MAP) do
        local spellName = spell.getSpellName()
        local spellCooldown = spell.getSpellCooldown()
        local spellCasttime = spell.getSpellCasttime()
        local spellTooltip = spell.getSpellTooltip()

        TOOLTIPS[idx] =
            "|cff155ed4"..spellName.."|r|n|n"..
            "|cffe0b412Cooldown: |r"..spellCooldown.."s|n"..
            "|cffe0b412Cast time: |r"..spellCasttime.."s|n"..
            "|n"..spellTooltip
    end

    local levelTrigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(levelTrigger, EVENT_PLAYER_HERO_LEVEL)
    TriggerAddAction(levelTrigger, checkNewSpellsOnLevel)
end

return {
    init = init,
    castSpell = castSpell,
    castSpellByKey = castSpellByKey,
    getCooldown = getCooldown,
    getCooldownPct = getCooldownPct,
    getCooldownPctBySpellKey = getCooldownPctBySpellKey,
    getIcon = getIcon,
    getIconBySpellKey = getIconBySpellKey,
    getSpellTooltipBySpellKey = getSpellTooltipBySpellKey,
    getSpellTooltip = getSpellTooltip,
}
