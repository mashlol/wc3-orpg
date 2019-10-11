local BUFF_LOOP_INTERVAL = 0.1 -- TODO get from buff module

local STATS = {
    -- -------------------------------------------------------------------------
    -- Loop effects
    -- -------------------------------------------------------------------------
    PERCENT_MOVE_SPEED = {
        getTooltip = function(info)
            return maybeAddPlus(round((info.amount - 1) * 100, 2)) .. '% move speed'
        end,
        effect = function(info, obj)
            obj.baseSpeed = obj.baseSpeed * info.amount
        end,
        priority = 2,
    },
    PERCENT_SCALE = {
        getTooltip = function(info)
            return maybeAddPlus(round((info.amount - 1) * 100, 2)) .. '% size'
        end,
        effect = function(info, obj)
            obj.scale = obj.scale * info.amount
        end,
        priority = 2,
    },
    STUN = {
        getTooltip = function()
            return 'Stunned'
        end,
        effect = function(info, obj)
            obj.isStunned = true
        end,
        priority = 3,
    },
    RAW_HIT_POINTS = {
        getTooltip = function(info)
            return maybeAddPlus(info.amount) .. ' HP'
        end,
        effect = function(info, obj)
            obj.baseHP = obj.baseHP + info.amount
        end,
        priority = 1,
    },
    ROOT = {
        getTooltip = function()
            return 'Rooted'
        end,
        effect = function(info, obj)
            obj.isRooted = true
        end,
        priority = 3,
    },
    HEALTH_REGEN = {
        getTooltip = function(info)
            return maybeAddPlus(info.amount) .. ' HP / s'
        end,
        effect = function(info, obj, tick)
            if tick ~= nil and tick % (1 / BUFF_LOOP_INTERVAL * info.tickrate) == 0 then
                obj.hpToHeal = obj.hpToHeal + info.amount
            end
        end,
        priority = 4,
    },
    DAMAGE_OVER_TIME = {
        getTooltip = function(info)
            return maybeAddPlus(-1 * info.amount) .. ' HP / s'
        end,
        effect = function(info, obj, tick)
            if tick ~= nil and tick % (1 / BUFF_LOOP_INTERVAL * info.tickrate) == 0 then
                obj.dmgToDeal = obj.dmgToDeal + info.amount
            end
        end,
        priority = 4,
    },

    -- -------------------------------------------------------------------------
    -- Static effects
    -- -------------------------------------------------------------------------
    RAW_DAMAGE = {
        getTooltip = function(info)
            return maybeAddPlus(info.amount) .. ' attack damage'
        end,
        effect = function(info, obj)
            obj.rawDamage = obj.rawDamage + info.amount
        end,
        priority = 1,
    },
    PERCENT_DAMAGE = {
        getTooltip = function(info)
            return maybeAddPlus(round((info.amount - 1) * 100, 2)) .. '% attack damage'
        end,
        effect = function(info, obj)
            obj.pctDamage = obj.pctDamage * info.amount
        end,
        priority = 2,
    },
    RAW_SPELL_DAMAGE = {
        getTooltip = function(info)
            return maybeAddPlus(info.amount) .. ' spell damage'
        end,
        effect = function(info, obj)
            obj.rawSpellDamage = obj.rawSpellDamage + info.amount
        end,
        priority = 1,
    },
    PERCENT_SPELL_DAMAGE = {
        getTooltip = function(info)
            return maybeAddPlus(round((info.amount - 1) * 100, 2)) .. '% spell damage'
        end,
        effect = function(info, obj)
            obj.pctSpellDamage = obj.pctSpellDamage * info.amount
        end,
        priority = 2,
    },
    RAW_HEALING = {
        getTooltip = function(info)
            return maybeAddPlus(info.amount) .. ' healing'
        end,
        effect = function(info, obj)
            obj.rawHealing = obj.rawHealing + info.amount
        end,
        priority = 1,
    },
    PERCENT_HEALING = {
        getTooltip = function(info)
            return maybeAddPlus(round((info.amount - 1) * 100, 2)) .. '% healing'
        end,
        effect = function(info, obj)
            obj.pctHealing = obj.pctHealing * info.amount
        end,
        priority = 2,
    },
    PERCENT_INCOMING_DAMAGE = {
        getTooltip = function(info)
            return maybeAddPlus(round((info.amount - 1) * 100, 2)) .. '% physical damage taken'
        end,
        effect = function(info, obj)
            obj.pctIncomingDamage = obj.pctIncomingDamage * info.amount
        end,
        priority = 2,
    },
    PERCENT_INCOMING_SPELL_DAMAGE = {
        getTooltip = function(info)
            return maybeAddPlus(round((info.amount - 1) * 100, 2)) .. '% spell damage taken'
        end,
        effect = function(info, obj)
            obj.pctIncomingSpellDamage = obj.pctIncomingSpellDamage * info.amount
        end,
        priority = 2,
    },
    PERCENT_INCOMING_HEALING = {
        getTooltip = function(info)
            return maybeAddPlus(round((info.amount - 1) * 100, 2)) .. '% healing received'
        end,
        effect = function(info, obj)
            obj.pctIncomingHealing = obj.pctIncomingHealing * info.amount
        end,
        priority = 2,
    },
    RAW_INCOMING_DAMAGE = {
        getTooltip = function(info)
            return maybeAddPlus(info.amount) .. ' physical damage taken'
        end,
        effect = function(info, obj)
            obj.rawIncomingDamage = obj.rawIncomingDamage + info.amount
        end,
        priority = 1,
    },
    RAW_INCOMING_SPELL_DAMAGE = {
        getTooltip = function(info)
            return maybeAddPlus(info.amount) .. ' spell damage taken'
        end,
        effect = function(info, obj)
            obj.rawIncomingSpellDamage = obj.rawIncomingSpellDamage + info.amount
        end,
        priority = 1,
    },
    RAW_INCOMING_HEALING = {
        getTooltip = function(info)
            return maybeAddPlus(info.amount) .. ' healing received'
        end,
        effect = function(info, obj)
            obj.rawIncomingHealing = obj.rawIncomingHealing + info.amount
        end,
        priority = 1,
    },

    PERCENT_COOLDOWN_REDUCTION = {
        getTooltip = function(info)
            return maybeAddPlus(round((1 - info.amount) * 100, 2)) .. '% cooldown reduction'
        end,
        effect = function(info, obj)
            obj.cooldownReduction = obj.cooldownReduction * info.amount
        end,
        priority = 2,
    },
    PERCENT_CAST_SPEED = {
        getTooltip = function(info)
            return maybeAddPlus(round((1 - info.amount) * 100, 2)) .. '% casting speed'
        end,
        effect = function(info, obj)
            obj.castSpeed = obj.castSpeed * info.amount
        end,
        priority = 2,
    },
    PERCENT_ATTACK_SPEED = {
        getTooltip = function(info)
            return maybeAddPlus(round((1 - info.amount) * 100, 2)) .. '% attack speed'
        end,
        effect = function(info, obj)
            obj.attackSpeed = obj.attackSpeed * info.amount
        end,
        priority = 2,
    },
    RAW_PERCENT_CRITICAL = {
        getTooltip = function(info)
            return maybeAddPlus(info.amount) .. '% crit chance'
        end,
        effect = function(info, obj)
            obj.critChance = obj.critChance + info.amount
        end,
        priority = 2,
    },
    RAW_CRITICAL_DAMAGE = {
        getTooltip = function(info)
            return maybeAddPlus(info.amount) .. ' crit damage'
        end,
        effect = function(info, obj)
            obj.rawCritDamage = obj.rawCritDamage + info.amount
        end,
        priority = 2,
    },
    PERCENT_CRITICAL_DAMAGE = {
        getTooltip = function(info)
            return maybeAddPlus(round((info.amount - 1) * 100, 2)) .. '% crit damage'
        end,
        effect = function(info, obj)
            obj.pctCritDamage = obj.pctCritDamage * info.amount
        end,
        priority = 2,
    },
}

function maybeAddPlus(num)
    if num >= 0 then
        return '+' .. num
    end
    return num
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

return STATS