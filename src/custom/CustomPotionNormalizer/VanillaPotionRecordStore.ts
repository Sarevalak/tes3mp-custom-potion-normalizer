export class VanillaPotionRecordStore {
    private records: { [refId: string]: PotionRecord; } = {};
    private blackList: string[] = [];

    constructor() {
        this.blackList = jsonInterface.load('custom/CustomPotionNormalizer/blackList.json');
        this.addAll(jsonInterface.load('custom/CustomPotionNormalizer/00ALCH.json'));
        this.addAll(jsonInterface.load('custom/CustomPotionNormalizer/01ALCH.json'));
        this.addAll(jsonInterface.load('custom/CustomPotionNormalizer/02ALCH.json'));
    }

    public getRefs(): string[] {
        return Object.keys(this.records);
    }

    public getRefId(potion: PotionRecord): string | null {
        return Object.keys(this.records).find((k) => this.records[k] === potion) || null;
    }

    public getRecord(key: string): PotionRecord {
        return this.records[key];
    }

    public getRecords(): { [refId: string]: PotionRecord; } {
        return this.records;
    }

    private addAll(potions: any[]) {
        potions.filter((potion) => !this.blackList.find((refId) => refId === potion.refId)).forEach((potion) => {
            const effects: PotionEffect[] = (potion.effects as any[]).map((effect) => {
                return {
                    area: effect.area,
                    attribute: effect.attribute,
                    duration: effect.duration,
                    id: effect.effect,
                    magnitudeMax: effect.magnitude_max,
                    magnitudeMin: effect.magnitude_min,
                    rangeType: effect.range,
                    skill: effect.skill,
                };
            });
            this.records[potion.refId] = {
                autoCalc: potion.autocalc,
                effects,
                icon: '',
                model: '',
                name: '',
                script: '',
                value: potion.value,
                weight: potion.weight,
            };
        });
    }
}
