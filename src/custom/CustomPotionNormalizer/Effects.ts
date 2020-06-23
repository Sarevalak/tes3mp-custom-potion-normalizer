export class EffectsRegistry {
    private names: {[index: number]: string} = {};
    private negativeEffects: number[] = [];

    constructor() {
        this.names[85] = 'sEffectAbsorbAttribute';
        this.names[88] = 'sEffectAbsorbFatigue';
        this.names[86] = 'sEffectAbsorbHealth';
        this.names[87] = 'sEffectAbsorbSpellPoints';
        this.names[89] = 'sEffectAbsorbSkill';
        this.names[63] = 'sEffectAlmsiviIntervention';
        this.names[47] = 'sEffectBlind';
        this.names[123] = 'sEffectBoundBattleAxe';
        this.names[129] = 'sEffectBoundBoots';
        this.names[127] = 'sEffectBoundCuirass';
        this.names[120] = 'sEffectBoundDagger';
        this.names[131] = 'sEffectBoundGloves';
        this.names[128] = 'sEffectBoundHelm';
        this.names[125] = 'sEffectBoundLongbow';
        this.names[126] = 'sEffectExtraSpell';
        this.names[121] = 'sEffectBoundLongsword';
        this.names[122] = 'sEffectBoundMace';
        this.names[130] = 'sEffectBoundShield';
        this.names[124] = 'sEffectBoundSpear';
        this.names[7] = 'sEffectBurden';
        this.names[50] = 'sEffectCalmCreature';
        this.names[49] = 'sEffectCalmHumanoid';
        this.names[40] = 'sEffectChameleon';
        this.names[44] = 'sEffectCharm';
        this.names[118] = 'sEffectCommandCreatures';
        this.names[119] = 'sEffectCommandHumanoids';
        this.names[132] = 'sEffectCorpus'; // NB this typo. (bethesda made it)
        this.names[70] = 'sEffectCureBlightDisease';
        this.names[69] = 'sEffectCureCommonDisease';
        this.names[71] = 'sEffectCureCorprusDisease';
        this.names[73] = 'sEffectCureParalyzation';
        this.names[72] = 'sEffectCurePoison';
        this.names[22] = 'sEffectDamageAttribute';
        this.names[25] = 'sEffectDamageFatigue';
        this.names[23] = 'sEffectDamageHealth';
        this.names[24] = 'sEffectDamageMagicka';
        this.names[26] = 'sEffectDamageSkill';
        this.names[54] = 'sEffectDemoralizeCreature';
        this.names[53] = 'sEffectDemoralizeHumanoid';
        this.names[64] = 'sEffectDetectAnimal';
        this.names[65] = 'sEffectDetectEnchantment';
        this.names[66] = 'sEffectDetectKey';
        this.names[38] = 'sEffectDisintegrateArmor';
        this.names[37] = 'sEffectDisintegrateWeapon';
        this.names[57] = 'sEffectDispel';
        this.names[62] = 'sEffectDivineIntervention';
        this.names[17] = 'sEffectDrainAttribute';
        this.names[20] = 'sEffectDrainFatigue';
        this.names[18] = 'sEffectDrainHealth';
        this.names[19] = 'sEffectDrainSpellpoints';
        this.names[21] = 'sEffectDrainSkill';
        this.names[8] = 'sEffectFeather';
        this.names[14] = 'sEffectFireDamage';
        this.names[4] = 'sEffectFireShield';
        this.names[117] = 'sEffectFortifyAttackBonus';
        this.names[79] = 'sEffectFortifyAttribute';
        this.names[82] = 'sEffectFortifyFatigue';
        this.names[80] = 'sEffectFortifyHealth';
        this.names[81] = 'sEffectFortifySpellpoints';
        this.names[84] = 'sEffectFortifyMagickaMultiplier';
        this.names[83] = 'sEffectFortifySkill';
        this.names[52] = 'sEffectFrenzyCreature';
        this.names[51] = 'sEffectFrenzyHumanoid';
        this.names[16] = 'sEffectFrostDamage';
        this.names[6] = 'sEffectFrostShield';
        this.names[39] = 'sEffectInvisibility';
        this.names[9] = 'sEffectJump';
        this.names[10] = 'sEffectLevitate';
        this.names[41] = 'sEffectLight';
        this.names[5] = 'sEffectLightningShield';
        this.names[12] = 'sEffectLock';
        this.names[60] = 'sEffectMark';
        this.names[43] = 'sEffectNightEye';
        this.names[13] = 'sEffectOpen';
        this.names[45] = 'sEffectParalyze';
        this.names[27] = 'sEffectPoison';
        this.names[56] = 'sEffectRallyCreature';
        this.names[55] = 'sEffectRallyHumanoid';
        this.names[61] = 'sEffectRecall';
        this.names[68] = 'sEffectReflect';
        this.names[100] = 'sEffectRemoveCurse';
        this.names[95] = 'sEffectResistBlightDisease';
        this.names[94] = 'sEffectResistCommonDisease';
        this.names[96] = 'sEffectResistCorprusDisease';
        this.names[90] = 'sEffectResistFire';
        this.names[91] = 'sEffectResistFrost';
        this.names[93] = 'sEffectResistMagicka';
        this.names[98] = 'sEffectResistNormalWeapons';
        this.names[99] = 'sEffectResistParalysis';
        this.names[97] = 'sEffectResistPoison';
        this.names[92] = 'sEffectResistShock';
        this.names[74] = 'sEffectRestoreAttribute';
        this.names[77] = 'sEffectRestoreFatigue';
        this.names[75] = 'sEffectRestoreHealth';
        this.names[76] = 'sEffectRestoreSpellPoints';
        this.names[78] = 'sEffectRestoreSkill';
        this.names[42] = 'sEffectSanctuary';
        this.names[3] = 'sEffectShield';
        this.names[15] = 'sEffectShockDamage';
        this.names[46] = 'sEffectSilence';
        this.names[11] = 'sEffectSlowFall';
        this.names[58] = 'sEffectSoultrap';
        this.names[48] = 'sEffectSound';
        this.names[67] = 'sEffectSpellAbsorption';
        this.names[136] = 'sEffectStuntedMagicka';
        this.names[106] = 'sEffectSummonAncestralGhost';
        this.names[110] = 'sEffectSummonBonelord';
        this.names[108] = 'sEffectSummonLeastBonewalker';
        this.names[134] = 'sEffectSummonCenturionSphere';
        this.names[103] = 'sEffectSummonClannfear';
        this.names[104] = 'sEffectSummonDaedroth';
        this.names[105] = 'sEffectSummonDremora';
        this.names[114] = 'sEffectSummonFlameAtronach';
        this.names[115] = 'sEffectSummonFrostAtronach';
        this.names[113] = 'sEffectSummonGoldenSaint';
        this.names[109] = 'sEffectSummonGreaterBonewalker';
        this.names[112] = 'sEffectSummonHunger';
        this.names[102] = 'sEffectSummonScamp';
        this.names[107] = 'sEffectSummonSkeletalMinion';
        this.names[116] = 'sEffectSummonStormAtronach';
        this.names[111] = 'sEffectSummonWingedTwilight';
        this.names[135] = 'sEffectSunDamage';
        this.names[1] = 'sEffectSwiftSwim';
        this.names[59] = 'sEffectTelekinesis';
        this.names[101] = 'sEffectTurnUndead';
        this.names[133] = 'sEffectVampirism';
        this.names[0] = 'sEffectWaterBreathing';
        this.names[2] = 'sEffectWaterWalking';
        this.names[33] = 'sEffectWeaknesstoBlightDisease';
        this.names[32] = 'sEffectWeaknesstoCommonDisease';
        this.names[34] = 'sEffectWeaknesstoCorprusDisease';
        this.names[28] = 'sEffectWeaknesstoFire';
        this.names[29] = 'sEffectWeaknesstoFrost';
        this.names[31] = 'sEffectWeaknesstoMagicka';
        this.names[36] = 'sEffectWeaknesstoNormalWeapons';
        this.names[35] = 'sEffectWeaknesstoPoison';
        this.names[30] = 'sEffectWeaknesstoShock';

        // bloodmoon
        this.names[138] = 'sEffectSummonCreature01';
        this.names[139] = 'sEffectSummonCreature02';
        this.names[140] = 'sEffectSummonCreature03';
        this.names[141] = 'sEffectSummonCreature04';
        this.names[142] = 'sEffectSummonCreature05';

        // tribunal
        this.names[137] = 'sEffectSummonFabricant';

        this.negativeEffects = [
            85, 88, 86, 87, 89, 47, 7 , 22, 25, 23, 24,
            26, 38, 37, 62, 17, 20, 18, 19, 21, 14, 52,
            51, 16, 45, 27, 15, 46, 58, 48, 33, 32, 34,
            28, 29, 31, 36, 35, 30
        ];

    }

    public getEffectName(idx: number): string {
        return (this.names[idx] || '').replace('sEffect', '');
    }

    public getEffectId(name: string): number | null {
        let res: number | null = null;
        Object.keys(this.names).forEach((id: any) => {
            if (res == null && this.names[id].toLowerCase() === name.toLowerCase() ||
                    this.names[id].toLowerCase() === `sEffect${name}`.toLowerCase()) {
                res = id;
            }
        });
        return res;
    }

    public isNegative(idx: number): boolean {
        return this.negativeEffects.indexOf(idx) !== -1;
    }
}
