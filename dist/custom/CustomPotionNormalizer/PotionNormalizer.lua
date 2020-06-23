-- Lua Library inline imports
function __TS__ObjectAssign(to, ...)
    local sources = ({...})
    if to == nil then
        return to
    end
    for ____, source in ipairs(sources) do
        for key in pairs(source) do
            to[key] = source[key]
        end
    end
    return to
end

function __TS__ArrayPush(arr, ...)
    local items = ({...})
    for ____, item in ipairs(items) do
        arr[#arr + 1] = item
    end
    return #arr
end

function __TS__ObjectKeys(obj)
    local result = {}
    for key in pairs(obj) do
        result[#result + 1] = key
    end
    return result
end

function __TS__ArrayFind(arr, predicate)
    local len = #arr
    local k = 0
    while k < len do
        local elem = arr[k + 1]
        if predicate(_G, elem, k, arr) then
            return elem
        end
        k = k + 1
    end
    return nil
end

function __TS__ArrayReverse(arr)
    local i = 0
    local j = #arr - 1
    while i < j do
        local temp = arr[j + 1]
        arr[j + 1] = arr[i + 1]
        arr[i + 1] = temp
        i = i + 1
        j = j - 1
    end
    return arr
end

local ____exports = {}
local ____Effects = require("custom.CustomPotionNormalizer.Effects")
local EffectsRegistry = ____Effects.EffectsRegistry
____exports.PotionNormalizer = {}
local PotionNormalizer = ____exports.PotionNormalizer
PotionNormalizer.name = "PotionNormalizer"
PotionNormalizer.__index = PotionNormalizer
PotionNormalizer.prototype = {}
PotionNormalizer.prototype.__index = PotionNormalizer.prototype
PotionNormalizer.prototype.constructor = PotionNormalizer
function PotionNormalizer.new(...)
    local self = setmetatable({}, PotionNormalizer.prototype)
    self:____constructor(...)
    return self
end
function PotionNormalizer.prototype.____constructor(self, effects)
    if effects == nil then
        effects = EffectsRegistry.new()
    end
    self.effects = effects
    self.normalizers = {Burden = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, Feather = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, FireShield = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, FrostShield = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, Jump = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, Levitate = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, LightningShield = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, SlowFall = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 10, duration = 15, value = 35, weight = 1}, {magnitude = 15, duration = 30, value = 50, weight = 0.75}, {magnitude = 20, duration = 45, value = 75, weight = 0.5}, {magnitude = 25, duration = 60, value = 150, weight = 0.25}}, SwiftSwim = {{magnitude = 1, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 12, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, WaterBreathing = {{magnitude = 1, duration = 8, value = 5, weight = 1.5}, {magnitude = 1, duration = 15, value = 35, weight = 1}, {magnitude = 1, duration = 30, value = 50, weight = 0.75}, {magnitude = 1, duration = 45, value = 75, weight = 0.5}, {magnitude = 1, duration = 60, value = 150, weight = 0.25}}, WaterWalking = {{magnitude = 1, duration = 8, value = 5, weight = 1.5}, {magnitude = 1, duration = 15, value = 35, weight = 1}, {magnitude = 1, duration = 30, value = 50, weight = 0.75}, {magnitude = 1, duration = 45, value = 75, weight = 0.5}, {magnitude = 1, duration = 60, value = 150, weight = 0.25}}, Chameleon = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, Invisibility = {{magnitude = 1, duration = 8, value = 5, weight = 1.5}, {magnitude = 1, duration = 15, value = 15, weight = 1}, {magnitude = 1, duration = 30, value = 35, weight = 0.75}, {magnitude = 1, duration = 45, value = 80, weight = 0.5}, {magnitude = 1, duration = 60, value = 175, weight = 0.25}}, Light = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, NightEye = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, Paralyze = {{magnitude = 1, duration = 8, value = 5, weight = 1.5}, {magnitude = 1, duration = 15, value = 15, weight = 1}, {magnitude = 1, duration = 30, value = 35, weight = 0.75}, {magnitude = 1, duration = 45, value = 80, weight = 0.5}, {magnitude = 1, duration = 60, value = 175, weight = 0.25}}, Silence = {{magnitude = 1, duration = 8, value = 5, weight = 1.5}, {magnitude = 1, duration = 15, value = 15, weight = 1}, {magnitude = 1, duration = 30, value = 35, weight = 0.75}, {magnitude = 1, duration = 45, value = 80, weight = 0.5}, {magnitude = 1, duration = 60, value = 175, weight = 0.25}}, AlmsiviIntervention = {{magnitude = 1, duration = 1, value = 35, weight = 0.75}}, DetectAnimal = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 10, duration = 15, value = 35, weight = 1}, {magnitude = 15, duration = 20, value = 50, weight = 0.75}, {magnitude = 20, duration = 30, value = 75, weight = 0.5}, {magnitude = 25, duration = 45, value = 150, weight = 0.25}}, DetectEnchantment = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 10, duration = 15, value = 35, weight = 1}, {magnitude = 15, duration = 20, value = 50, weight = 0.75}, {magnitude = 20, duration = 30, value = 75, weight = 0.5}, {magnitude = 25, duration = 45, value = 150, weight = 0.25}}, DetectKey = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 10, duration = 15, value = 35, weight = 1}, {magnitude = 15, duration = 20, value = 50, weight = 0.75}, {magnitude = 20, duration = 30, value = 75, weight = 0.5}, {magnitude = 25, duration = 45, value = 150, weight = 0.25}}, Dispel = {{magnitude = 5, duration = 1, value = 5, weight = 1.5}, {magnitude = 10, duration = 1, value = 35, weight = 1}, {magnitude = 15, duration = 1, value = 50, weight = 0.75}, {magnitude = 20, duration = 1, value = 75, weight = 0.5}, {magnitude = 25, duration = 1, value = 150, weight = 0.25}}, Mark = {{magnitude = 1, duration = 1, value = 35, weight = 1}}, Recall = {{magnitude = 1, duration = 1, value = 35, weight = 1}}, Reflect = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, SpellAbsorption = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, Telekinesis = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 10, duration = 15, value = 35, weight = 1}, {magnitude = 15, duration = 20, value = 50, weight = 0.75}, {magnitude = 20, duration = 30, value = 75, weight = 0.5}, {magnitude = 25, duration = 45, value = 150, weight = 0.25}}, CureBlightDisease = {{magnitude = 1, duration = 1, value = 30, weight = 0.5}}, CureCommonDisease = {{magnitude = 1, duration = 1, value = 20, weight = 0.5}}, CureParalyzation = {{magnitude = 1, duration = 1, value = 20, weight = 0.5}}, CurePoison = {{magnitude = 1, duration = 1, value = 20, weight = 0.5}}, FortifyAttackBonus = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, FortifyAttribute = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, FortifyFatigue = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, FortifyHealth = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, FortifySpellpoints = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, ResistCommonDisease = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, ResistFire = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, ResistFrost = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, ResistMagicka = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, ResistPoison = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, ResistShock = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}, RestoreAttribute = {{magnitude = 5, duration = 0, value = 5, weight = 1.5}, {magnitude = 8, duration = 0, value = 15, weight = 1}, {magnitude = 10, duration = 0, value = 35, weight = 0.75}, {magnitude = 15, duration = 0, value = 80, weight = 0.5}, {magnitude = 20, duration = 0, value = 175, weight = 0.25}}, RestoreFatigue = {{magnitude = 5, duration = 5, value = 5, weight = 1.5}, {magnitude = 10, duration = 5, value = 15, weight = 1}, {magnitude = 20, duration = 5, value = 35, weight = 0.75}, {magnitude = 40, duration = 5, value = 80, weight = 0.5}, {magnitude = 80, duration = 5, value = 175, weight = 0.25}}, RestoreHealth = {{magnitude = 1, duration = 5, value = 5, weight = 1.5}, {magnitude = 2, duration = 5, value = 15, weight = 1}, {magnitude = 10, duration = 5, value = 35, weight = 0.75}, {magnitude = 20, duration = 5, value = 80, weight = 0.5}, {magnitude = 40, duration = 5, value = 175, weight = 0.25}}, RestoreSpellPoints = {{magnitude = 1, duration = 5, value = 5, weight = 1.5}, {magnitude = 2, duration = 5, value = 15, weight = 1}, {magnitude = 10, duration = 5, value = 35, weight = 0.75}, {magnitude = 20, duration = 5, value = 80, weight = 0.5}, {magnitude = 40, duration = 5, value = 175, weight = 0.25}}, fallback = {{magnitude = 5, duration = 8, value = 5, weight = 1.5}, {magnitude = 8, duration = 15, value = 15, weight = 1}, {magnitude = 10, duration = 30, value = 35, weight = 0.75}, {magnitude = 15, duration = 45, value = 80, weight = 0.5}, {magnitude = 20, duration = 60, value = 175, weight = 0.25}}}
end
function PotionNormalizer.prototype.normalizePotion(self, potion)
    if potion ~= nil then
        local value = 0
        local weight = 0
        local newPotion = __TS__ObjectAssign({}, potion)
        newPotion.effects = {}
        for ____, effect in ipairs(potion.effects) do
            local normalizedEffect = self:normalizeEffect(effect)
            if normalizedEffect.value > value then
                value = normalizedEffect.value
            end
            if normalizedEffect.weight > weight then
                weight = normalizedEffect.weight
            end
            __TS__ArrayPush(newPotion.effects, normalizedEffect)
        end
        newPotion.weight = (weight > 0) and weight or newPotion.weight
        newPotion.value = (value > 0) and value or newPotion.value
        return newPotion
    else
        return nil
    end
end
function PotionNormalizer.prototype.calcEffectPower(self, effect, maxDuration)
    local mag = effect.magnitude or effect.magnitudeMax
    local duration = maxDuration and math.min(effect.duration, maxDuration) or effect.duration
    return mag * duration
end
function PotionNormalizer.prototype.calcDistance(self, effect, normefect)
    return math.abs(
        1 - (self:calcEffectPower(effect, normefect.duration * 2) / self:calcEffectPower(normefect))
    )
end
function PotionNormalizer.prototype.normalizeEffect(self, effect)
    local normalizedEffect = __TS__ObjectAssign({weight = 1, value = 10}, effect)
    local effectName = __TS__ArrayFind(
        __TS__ObjectKeys(self.normalizers),
        function(____, e) return effect.id == self.effects:getEffectId(e) end
    ) or "fallback"
    local normalizer = self.normalizers[effectName]
    local normEffect = nil
    local maxEffect = normalizer[#normalizer]
    local minEffect = normalizer[1]
    local minD = nil
    for ____, neffect in ipairs(
        __TS__ArrayReverse(normalizer)
    ) do
        local d = self:calcDistance(effect, neffect)
        if minD == nil or minD > d then
            minD = d
            normEffect = neffect
        end
    end
    if normEffect == nil then
        if effect.magnitudeMax > maxEffect.magnitude then
            normEffect = __TS__ObjectAssign({}, maxEffect)
        elseif effect.magnitudeMax <= minEffect.magnitude then
            normEffect = __TS__ObjectAssign({}, minEffect)
        end
    end
    if normEffect ~= nil then
        normalizedEffect.magnitudeMax = normEffect.magnitude
        normalizedEffect.magnitudeMin = normEffect.magnitude
        if effect.duration * effect.magnitudeMax > normEffect.duration * normEffect.magnitude then
            normalizedEffect.duration = math.max((normEffect.duration * normEffect.magnitude) / normalizedEffect.magnitudeMax, normEffect.duration * 2)
        end
        normalizedEffect.weight = normEffect.weight
        normalizedEffect.value = normEffect.value
    end
    return normalizedEffect
end
return ____exports
