import { EffectsRegistry } from './Effects';

// tslint:disable-next-line: interface-name
interface NormalizedEffect {
    magnitude: number;
    duration: number;
    value: number;
    weight: number;
}

// tslint:disable-next-line: interface-name
interface ExtendedPotionEffect {
    id: number;
    attribute: number;
    skill: number;
    rangeType: number;
    area: number;
    duration: number;
    magnitudeMax: number;
    magnitudeMin: number;
    value: number;
    weight: number;
}

export class PotionNormalizer {
    private normalizers: {[key: string]: NormalizedEffect[]} = {
        // Alteration
        // tslint:disable-next-line: object-literal-key-quotes
        'Burden': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'Feather': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'FireShield': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'FrostShield': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25}, // Original duration 30 sec
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'Jump': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'Levitate': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'LightningShield': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'SlowFall': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5}, // Non standart
            {magnitude: 10, duration: 15, value: 35, weight: 1.0}, // Original potion
            {magnitude: 15, duration: 30, value: 50, weight: 0.75}, // Non standart
            {magnitude: 20, duration: 45, value: 75, weight: 0.5}, // Non standart
            {magnitude: 25, duration: 60, value: 150, weight: 0.25}, // Non standart
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'SwiftSwim': [
            {magnitude: 1, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 12, duration: 30, value: 35, weight: 0.75}, // Non standart
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'WaterBreathing': [
            {magnitude: 1, duration: 8, value: 5, weight: 1.5}, // Non standart
            {magnitude: 1, duration: 15, value: 35, weight: 1.0}, // Original potion
            {magnitude: 1, duration: 30, value: 50, weight: 0.75}, // Non standart
            {magnitude: 1, duration: 45, value: 75, weight: 0.5}, // Non standart
            {magnitude: 1, duration: 60, value: 150, weight: 0.25}, // Non standart
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'WaterWalking': [
            {magnitude: 1, duration: 8, value: 5, weight: 1.5}, // Non standart
            {magnitude: 1, duration: 15, value: 35, weight: 1.0}, // Original potion
            {magnitude: 1, duration: 30, value: 50, weight: 0.75}, // Non standart
            {magnitude: 1, duration: 45, value: 75, weight: 0.5}, // Non standart
            {magnitude: 1, duration: 60, value: 150, weight: 0.25}, // Non standart
        ],

        // Illusion
        // tslint:disable-next-line: object-literal-key-quotes
        'Chameleon': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'Invisibility': [
            {magnitude: 1, duration: 8, value: 5, weight: 1.5},
            {magnitude: 1, duration: 15, value: 15, weight: 1.0},
            {magnitude: 1, duration: 30, value: 35, weight: 0.75},
            {magnitude: 1, duration: 45, value: 80, weight: 0.5},
            {magnitude: 1, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'Light': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'NightEye': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'Paralyze': [
            {magnitude: 1, duration: 8, value: 5, weight: 1.5},
            {magnitude: 1, duration: 15, value: 15, weight: 1.0},
            {magnitude: 1, duration: 30, value: 35, weight: 0.75},
            {magnitude: 1, duration: 45, value: 80, weight: 0.5},
            {magnitude: 1, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'Silence': [
            {magnitude: 1, duration: 8, value: 5, weight: 1.5},
            {magnitude: 1, duration: 15, value: 15, weight: 1.0},
            {magnitude: 1, duration: 30, value: 35, weight: 0.75},
            {magnitude: 1, duration: 45, value: 80, weight: 0.5},
            {magnitude: 1, duration: 60, value: 175, weight: 0.25},
        ],

        // Mysticism
        // tslint:disable-next-line: object-literal-key-quotes
        'AlmsiviIntervention': [
            {magnitude: 1, duration: 1, value: 35, weight: 0.75},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'DetectAnimal': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5}, // Non standart
            {magnitude: 10, duration: 15, value: 35, weight: 1.0}, // Original potion
            {magnitude: 15, duration: 20, value: 50, weight: 0.75}, // Non standart
            {magnitude: 20, duration: 30, value: 75, weight: 0.5}, // Non standart
            {magnitude: 25, duration: 45, value: 150, weight: 0.25}, // Non standart
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'DetectEnchantment': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5}, // Non standart
            {magnitude: 10, duration: 15, value: 35, weight: 1.0}, // Original potion
            {magnitude: 15, duration: 20, value: 50, weight: 0.75}, // Non standart
            {magnitude: 20, duration: 30, value: 75, weight: 0.5}, // Non standart
            {magnitude: 25, duration: 45, value: 150, weight: 0.25}, // Non standart
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'DetectKey': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5}, // Non standart
            {magnitude: 10, duration: 15, value: 35, weight: 1.0}, // Original potion
            {magnitude: 15, duration: 20, value: 50, weight: 0.75}, // Non standart
            {magnitude: 20, duration: 30, value: 75, weight: 0.5}, // Non standart
            {magnitude: 25, duration: 45, value: 150, weight: 0.25}, // Non standart
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'Dispel': [
            {magnitude: 5, duration: 1, value: 5, weight: 1.5}, // Non standart
            {magnitude: 10, duration: 1, value: 35, weight: 1.0}, // Original potion
            {magnitude: 15, duration: 1, value: 50, weight: 0.75}, // Non standart
            {magnitude: 20, duration: 1, value: 75, weight: 0.5}, // Non standart
            {magnitude: 25, duration: 1, value: 150, weight: 0.25}, // Non standart
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'Mark': [
            {magnitude: 1, duration: 1, value: 35, weight: 1.0},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'Recall': [
            {magnitude: 1, duration: 1, value: 35, weight: 1.0},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'Reflect': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'SpellAbsorption': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'Telekinesis': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5}, // Non standart
            {magnitude: 10, duration: 15, value: 35, weight: 1.0}, // Original potion
            {magnitude: 15, duration: 20, value: 50, weight: 0.75}, // Non standart
            {magnitude: 20, duration: 30, value: 75, weight: 0.5}, // Non standart
            {magnitude: 25, duration: 45, value: 150, weight: 0.25}, // Non standart
        ],

        // Restoration
        // tslint:disable-next-line: object-literal-key-quotes
        'CureBlightDisease': [
            {magnitude: 1, duration: 1, value: 30, weight: 0.5},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'CureCommonDisease': [
            {magnitude: 1, duration: 1, value: 20, weight: 0.5},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'CureParalyzation': [
            {magnitude: 1, duration: 1, value: 20, weight: 0.5},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'CurePoison': [
            {magnitude: 1, duration: 1, value: 20, weight: 0.5},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'FortifyAttackBonus': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5}, // Non standart
            {magnitude: 8, duration: 15, value: 15, weight: 1.0}, // Non standart
            {magnitude: 10, duration: 30, value: 35, weight: 0.75}, // Non standart
            {magnitude: 15, duration: 45, value: 80, weight: 0.5}, // Non standart
            {magnitude: 20, duration: 60, value: 175, weight: 0.25}, // Original potion
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'FortifyAttribute': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'FortifyFatigue': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'FortifyHealth': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'FortifySpellpoints': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'ResistCommonDisease': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'ResistFire': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'ResistFrost': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'ResistMagicka': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'ResistPoison': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'ResistShock': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'RestoreAttribute': [
            {magnitude: 5, duration: 0, value: 5, weight: 1.5},
            {magnitude: 8, duration: 0, value: 15, weight: 1.0},
            {magnitude: 10, duration: 0, value: 35, weight: 0.75},
            {magnitude: 15, duration: 0, value: 80, weight: 0.5},
            {magnitude: 20, duration: 0, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'RestoreFatigue': [
            {magnitude: 5, duration: 5, value: 5, weight: 1.5},
            {magnitude: 10, duration: 5, value: 15, weight: 1.0},
            {magnitude: 20, duration: 5, value: 35, weight: 0.75},
            {magnitude: 40, duration: 5, value: 80, weight: 0.5},
            {magnitude: 80, duration: 5, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'RestoreHealth': [
            {magnitude: 1, duration: 5, value: 5, weight: 1.5},
            {magnitude: 2, duration: 5, value: 15, weight: 1.0},
            {magnitude: 10, duration: 5, value: 35, weight: 0.75},
            {magnitude: 20, duration: 5, value: 80, weight: 0.5},
            {magnitude: 40, duration: 5, value: 175, weight: 0.25},
        ],
        // tslint:disable-next-line: object-literal-key-quotes
        'RestoreSpellPoints': [
            {magnitude: 1, duration: 5, value: 5, weight: 1.5},
            {magnitude: 2, duration: 5, value: 15, weight: 1.0},
            {magnitude: 10, duration: 5, value: 35, weight: 0.75},
            {magnitude: 20, duration: 5, value: 80, weight: 0.5},
            {magnitude: 40, duration: 5, value: 175, weight: 0.25},
        ],

        // tslint:disable-next-line: object-literal-key-quotes
        'fallback': [
            {magnitude: 5, duration: 8, value: 5, weight: 1.5},
            {magnitude: 8, duration: 15, value: 15, weight: 1.0},
            {magnitude: 10, duration: 30, value: 35, weight: 0.75},
            {magnitude: 15, duration: 45, value: 80, weight: 0.5},
            {magnitude: 20, duration: 60, value: 175, weight: 0.25},
        ],
    };

    constructor(private effects: EffectsRegistry = new EffectsRegistry()) {
    }

    public normalizePotion(potion: PotionRecord | null): PotionRecord | null {
        if (potion != null) {
            let value = 0;
            let weight = 0;
            const newPotion = Object.assign({}, potion);
            newPotion.effects = [];
            for (const effect of potion.effects) {
                const normalizedEffect = this.normalizeEffect(effect);
                if (normalizedEffect.value > value) {
                    value = normalizedEffect.value;
                }
                if (normalizedEffect.weight > weight) {
                    weight = normalizedEffect.weight;
                }
                newPotion.effects.push(normalizedEffect);
            }
            newPotion.weight = weight > 0 ? weight : newPotion.weight;
            newPotion.value = value > 0 ? value : newPotion.value;
            return newPotion;
        } else {
            return null;
        }
    }

    private calcEffectPower(effect: any, maxDuration?: number): number {
        const mag = effect.magnitude || effect.magnitudeMax;
        const duration = maxDuration ? Math.min(effect.duration, maxDuration) : effect.duration;
        return mag * duration;
    }

    private calcDistance(effect: any, normefect: any): number {
        return Math.abs(1 - (this.calcEffectPower(effect, normefect.duration * 2) / this.calcEffectPower(normefect)));
    }

    private normalizeEffect(effect: PotionEffect): ExtendedPotionEffect {
        const normalizedEffect: ExtendedPotionEffect = Object.assign({weight: 1, value: 10}, effect);
        const effectName: string =
            Object.keys(this.normalizers).find((e) => effect.id === this.effects.getEffectId(e)) || 'fallback';
        const normalizer: NormalizedEffect[] = this.normalizers[effectName];
        let normEffect = null;
        const maxEffect = normalizer[normalizer.length - 1];
        const minEffect = normalizer[0];
        let minD: number | null = null;
        for (const neffect of normalizer.reverse()) {
            const d = this.calcDistance(effect, neffect);
            if (minD == null || minD > d) {
                minD = d;
                normEffect = neffect;
            }
        }
        if (normEffect == null) {
            if (effect.magnitudeMax > maxEffect.magnitude) {
                normEffect = Object.assign({}, maxEffect);
            } else if (effect.magnitudeMax <= minEffect.magnitude) {
                normEffect = Object.assign({}, minEffect);
            }
        }
        if (normEffect != null) {
            normalizedEffect.magnitudeMax = normEffect.magnitude;
            normalizedEffect.magnitudeMin = normEffect.magnitude;
            if (effect.duration * effect.magnitudeMax > normEffect.duration * normEffect.magnitude) {
                normalizedEffect.duration = Math.max(
                    (normEffect.duration * normEffect.magnitude) / normalizedEffect.magnitudeMax,
                    normEffect.duration * 2);
            }
            normalizedEffect.weight = normEffect.weight;
            normalizedEffect.value = normEffect.value;
        }
        return normalizedEffect;
    }
}
