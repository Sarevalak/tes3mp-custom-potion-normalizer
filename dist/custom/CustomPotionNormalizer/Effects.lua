-- Lua Library inline imports
function __TS__StringReplace(source, searchValue, replaceValue)
    searchValue = string.gsub(searchValue, "[%%%(%)%.%+%-%*%?%[%^%$]", "%%%1")
    if type(replaceValue) == "string" then
        replaceValue = string.gsub(replaceValue, "[%%%(%)%.%+%-%*%?%[%^%$]", "%%%1")
        local result = string.gsub(source, searchValue, replaceValue, 1)
        return result
    else
        local result = string.gsub(
            source,
            searchValue,
            function(match) return replaceValue(_G, match) end,
            1
        )
        return result
    end
end

function __TS__ObjectKeys(obj)
    local result = {}
    for key in pairs(obj) do
        result[#result + 1] = key
    end
    return result
end

function __TS__ArrayForEach(arr, callbackFn)
    do
        local i = 0
        while i < #arr do
            callbackFn(_G, arr[i + 1], i, arr)
            i = i + 1
        end
    end
end

function __TS__ArrayIndexOf(arr, searchElement, fromIndex)
    local len = #arr
    if len == 0 then
        return -1
    end
    local n = 0
    if fromIndex then
        n = fromIndex
    end
    if n >= len then
        return -1
    end
    local k
    if n >= 0 then
        k = n
    else
        k = len + n
        if k < 0 then
            k = 0
        end
    end
    do
        local i = k
        while i < len do
            if arr[i + 1] == searchElement then
                return i
            end
            i = i + 1
        end
    end
    return -1
end

local ____exports = {}
____exports.EffectsRegistry = {}
local EffectsRegistry = ____exports.EffectsRegistry
EffectsRegistry.name = "EffectsRegistry"
EffectsRegistry.__index = EffectsRegistry
EffectsRegistry.prototype = {}
EffectsRegistry.prototype.__index = EffectsRegistry.prototype
EffectsRegistry.prototype.constructor = EffectsRegistry
function EffectsRegistry.new(...)
    local self = setmetatable({}, EffectsRegistry.prototype)
    self:____constructor(...)
    return self
end
function EffectsRegistry.prototype.____constructor(self)
    self.names = {}
    self.negativeEffects = {}
    self.names[85] = "sEffectAbsorbAttribute"
    self.names[88] = "sEffectAbsorbFatigue"
    self.names[86] = "sEffectAbsorbHealth"
    self.names[87] = "sEffectAbsorbSpellPoints"
    self.names[89] = "sEffectAbsorbSkill"
    self.names[63] = "sEffectAlmsiviIntervention"
    self.names[47] = "sEffectBlind"
    self.names[123] = "sEffectBoundBattleAxe"
    self.names[129] = "sEffectBoundBoots"
    self.names[127] = "sEffectBoundCuirass"
    self.names[120] = "sEffectBoundDagger"
    self.names[131] = "sEffectBoundGloves"
    self.names[128] = "sEffectBoundHelm"
    self.names[125] = "sEffectBoundLongbow"
    self.names[126] = "sEffectExtraSpell"
    self.names[121] = "sEffectBoundLongsword"
    self.names[122] = "sEffectBoundMace"
    self.names[130] = "sEffectBoundShield"
    self.names[124] = "sEffectBoundSpear"
    self.names[7] = "sEffectBurden"
    self.names[50] = "sEffectCalmCreature"
    self.names[49] = "sEffectCalmHumanoid"
    self.names[40] = "sEffectChameleon"
    self.names[44] = "sEffectCharm"
    self.names[118] = "sEffectCommandCreatures"
    self.names[119] = "sEffectCommandHumanoids"
    self.names[132] = "sEffectCorpus"
    self.names[70] = "sEffectCureBlightDisease"
    self.names[69] = "sEffectCureCommonDisease"
    self.names[71] = "sEffectCureCorprusDisease"
    self.names[73] = "sEffectCureParalyzation"
    self.names[72] = "sEffectCurePoison"
    self.names[22] = "sEffectDamageAttribute"
    self.names[25] = "sEffectDamageFatigue"
    self.names[23] = "sEffectDamageHealth"
    self.names[24] = "sEffectDamageMagicka"
    self.names[26] = "sEffectDamageSkill"
    self.names[54] = "sEffectDemoralizeCreature"
    self.names[53] = "sEffectDemoralizeHumanoid"
    self.names[64] = "sEffectDetectAnimal"
    self.names[65] = "sEffectDetectEnchantment"
    self.names[66] = "sEffectDetectKey"
    self.names[38] = "sEffectDisintegrateArmor"
    self.names[37] = "sEffectDisintegrateWeapon"
    self.names[57] = "sEffectDispel"
    self.names[62] = "sEffectDivineIntervention"
    self.names[17] = "sEffectDrainAttribute"
    self.names[20] = "sEffectDrainFatigue"
    self.names[18] = "sEffectDrainHealth"
    self.names[19] = "sEffectDrainSpellpoints"
    self.names[21] = "sEffectDrainSkill"
    self.names[8] = "sEffectFeather"
    self.names[14] = "sEffectFireDamage"
    self.names[4] = "sEffectFireShield"
    self.names[117] = "sEffectFortifyAttackBonus"
    self.names[79] = "sEffectFortifyAttribute"
    self.names[82] = "sEffectFortifyFatigue"
    self.names[80] = "sEffectFortifyHealth"
    self.names[81] = "sEffectFortifySpellpoints"
    self.names[84] = "sEffectFortifyMagickaMultiplier"
    self.names[83] = "sEffectFortifySkill"
    self.names[52] = "sEffectFrenzyCreature"
    self.names[51] = "sEffectFrenzyHumanoid"
    self.names[16] = "sEffectFrostDamage"
    self.names[6] = "sEffectFrostShield"
    self.names[39] = "sEffectInvisibility"
    self.names[9] = "sEffectJump"
    self.names[10] = "sEffectLevitate"
    self.names[41] = "sEffectLight"
    self.names[5] = "sEffectLightningShield"
    self.names[12] = "sEffectLock"
    self.names[60] = "sEffectMark"
    self.names[43] = "sEffectNightEye"
    self.names[13] = "sEffectOpen"
    self.names[45] = "sEffectParalyze"
    self.names[27] = "sEffectPoison"
    self.names[56] = "sEffectRallyCreature"
    self.names[55] = "sEffectRallyHumanoid"
    self.names[61] = "sEffectRecall"
    self.names[68] = "sEffectReflect"
    self.names[100] = "sEffectRemoveCurse"
    self.names[95] = "sEffectResistBlightDisease"
    self.names[94] = "sEffectResistCommonDisease"
    self.names[96] = "sEffectResistCorprusDisease"
    self.names[90] = "sEffectResistFire"
    self.names[91] = "sEffectResistFrost"
    self.names[93] = "sEffectResistMagicka"
    self.names[98] = "sEffectResistNormalWeapons"
    self.names[99] = "sEffectResistParalysis"
    self.names[97] = "sEffectResistPoison"
    self.names[92] = "sEffectResistShock"
    self.names[74] = "sEffectRestoreAttribute"
    self.names[77] = "sEffectRestoreFatigue"
    self.names[75] = "sEffectRestoreHealth"
    self.names[76] = "sEffectRestoreSpellPoints"
    self.names[78] = "sEffectRestoreSkill"
    self.names[42] = "sEffectSanctuary"
    self.names[3] = "sEffectShield"
    self.names[15] = "sEffectShockDamage"
    self.names[46] = "sEffectSilence"
    self.names[11] = "sEffectSlowFall"
    self.names[58] = "sEffectSoultrap"
    self.names[48] = "sEffectSound"
    self.names[67] = "sEffectSpellAbsorption"
    self.names[136] = "sEffectStuntedMagicka"
    self.names[106] = "sEffectSummonAncestralGhost"
    self.names[110] = "sEffectSummonBonelord"
    self.names[108] = "sEffectSummonLeastBonewalker"
    self.names[134] = "sEffectSummonCenturionSphere"
    self.names[103] = "sEffectSummonClannfear"
    self.names[104] = "sEffectSummonDaedroth"
    self.names[105] = "sEffectSummonDremora"
    self.names[114] = "sEffectSummonFlameAtronach"
    self.names[115] = "sEffectSummonFrostAtronach"
    self.names[113] = "sEffectSummonGoldenSaint"
    self.names[109] = "sEffectSummonGreaterBonewalker"
    self.names[112] = "sEffectSummonHunger"
    self.names[102] = "sEffectSummonScamp"
    self.names[107] = "sEffectSummonSkeletalMinion"
    self.names[116] = "sEffectSummonStormAtronach"
    self.names[111] = "sEffectSummonWingedTwilight"
    self.names[135] = "sEffectSunDamage"
    self.names[1] = "sEffectSwiftSwim"
    self.names[59] = "sEffectTelekinesis"
    self.names[101] = "sEffectTurnUndead"
    self.names[133] = "sEffectVampirism"
    self.names[0] = "sEffectWaterBreathing"
    self.names[2] = "sEffectWaterWalking"
    self.names[33] = "sEffectWeaknesstoBlightDisease"
    self.names[32] = "sEffectWeaknesstoCommonDisease"
    self.names[34] = "sEffectWeaknesstoCorprusDisease"
    self.names[28] = "sEffectWeaknesstoFire"
    self.names[29] = "sEffectWeaknesstoFrost"
    self.names[31] = "sEffectWeaknesstoMagicka"
    self.names[36] = "sEffectWeaknesstoNormalWeapons"
    self.names[35] = "sEffectWeaknesstoPoison"
    self.names[30] = "sEffectWeaknesstoShock"
    self.names[138] = "sEffectSummonCreature01"
    self.names[139] = "sEffectSummonCreature02"
    self.names[140] = "sEffectSummonCreature03"
    self.names[141] = "sEffectSummonCreature04"
    self.names[142] = "sEffectSummonCreature05"
    self.names[137] = "sEffectSummonFabricant"
    self.negativeEffects = {85, 88, 86, 87, 89, 47, 7, 22, 25, 23, 24, 26, 38, 37, 62, 17, 20, 18, 19, 21, 14, 52, 51, 16, 45, 27, 15, 46, 58, 48, 33, 32, 34, 28, 29, 31, 36, 35, 30}
end
function EffectsRegistry.prototype.getEffectName(self, idx)
    return __TS__StringReplace((self.names[idx] or ""), "sEffect", "")
end
function EffectsRegistry.prototype.getEffectId(self, name)
    local res = nil
    __TS__ArrayForEach(
        __TS__ObjectKeys(self.names),
        function(____, id)
            if res == nil and string.lower(self.names[id]) == string.lower(name) or string.lower(self.names[id]) == string.lower(
                "sEffect" .. tostring(name)
            ) then
                res = id
            end
        end
    )
    return res
end
function EffectsRegistry.prototype.isNegative(self, idx)
    return __TS__ArrayIndexOf(self.negativeEffects, idx) ~= -1
end
return ____exports
