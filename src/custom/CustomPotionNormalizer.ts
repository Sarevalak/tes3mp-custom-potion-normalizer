import { EffectsRegistry } from './CustomPotionNormalizer/Effects';
import { PotionNormalizer } from './CustomPotionNormalizer/PotionNormalizer';
import { VanillaPotionRecordStore } from './CustomPotionNormalizer/VanillaPotionRecordStore';

// tslint:disable-next-line: no-var-requires
const tableHelper: any = require('tableHelper');

class CustomPotionNormalizer {
    get OnPlayerInventoryHandler(): (this: void, eventStatus: any, pid: any) => void {
        const self: CustomPotionNormalizer = this;
        return function(this: void, ...args) {
            return self.playerInventoryHandler.apply(self, args);
        };
    }

    private vanillaPotions: VanillaPotionRecordStore;
    private effects: EffectsRegistry;
    private vanillaPotionRefs: string[];
    private potionNormalizer = new PotionNormalizer(this.effects);
    private normalizedSuffix = '_normalized';

    constructor() {
       this.vanillaPotions = new VanillaPotionRecordStore();
       this.vanillaPotionRefs = this.vanillaPotions.getRefs();
       this.effects = new EffectsRegistry();
    }

    private playerInventoryHandler(eventStatus: any, pid: any) {
        if (eventStatus.validCustomHandlers !== false && eventStatus.validDefaultHandler !== false) {
            const removedItems: InventoryItem[] = [];
            const addedItems: InventoryItem[] = [];
            // tslint:disable-next-line: forin
            for (const itemIndex in Players[pid].data.inventory) {
                const item = Players[pid].data.inventory[itemIndex];
                if (item != null && this.isPotion(item.refId, true) &&
                        !item.refId.endsWith(this.normalizedSuffix) && item.count > 0) {
                    const newItemRef =  this.suggestPotion(item.refId, pid);
                    if (newItemRef != null) {
                        removedItems.push(item);
                        const newItem = Object.assign({}, item);
                        newItem.refId = newItemRef;
                        addedItems.push(newItem);
                    }
                }
            }
            if (removedItems.length > 0) {
                for (const item  of removedItems) {
                    const idx = inventoryHelper.getItemIndex(Players[pid].data.inventory, item.refId);
                    if (idx != null) {
                        Players[pid].data.inventory[idx] = null;
                    }
                }
                tableHelper.cleanNils(Players[pid].data.inventory);
                Players[pid].LoadItemChanges(removedItems, enumerations.inventory.REMOVE);
            }

            if (addedItems.length > 0) {
                for (const item  of addedItems) {
                    inventoryHelper.addItem(Players[pid].data.inventory,
                        item.refId, item.count, item.charge, item.enchantmentCharge, item.soul);
                }
                Players[pid].LoadItemChanges(addedItems, 1);
            }
        }
    }

    private potionEffectsMatch(ae: PotionEffect, be: PotionEffect): boolean {
        if (ae.id === be.id) {
            if (ae.skill === be.skill && ae.attribute === be.attribute) {
                return true;
            }
        }
        return false;
    }

    private suggestPotion(potionRefId: string, pid: any): string | null {
        const normalizedPotion = this.normalizePotion(potionRefId);
        const matchingPotions: PotionRecord[] = [];
        if (normalizedPotion != null) {
            for (const refId of this.vanillaPotionRefs) {
                const potion = this.vanillaPotions.getRecord(refId);
                let matching = potion.effects.length === normalizedPotion.effects.length;
                for (const ae of potion.effects) {
                    if (!matching) {
                        break;
                    }
                    for (const be of normalizedPotion.effects) {
                        if (!this.potionEffectsMatch(ae, be)) {
                            matching = false;
                            break;
                        }
                    }
                }
                if (matching) {
                    matchingPotions.push(potion);
                }
            }
            let minMetric: number | null = null;
            let matchedPotion: PotionRecord | null = null;
            for (const potion of matchingPotions) {
                let metric = 0;
                for (const ae of potion.effects) {
                    for (const be of normalizedPotion.effects) {
                        if (this.potionEffectsMatch(ae, be)) {
                            metric += (be.magnitudeMax * be.duration) / (ae.magnitudeMax * ae.duration * 2);
                            break;
                        }
                    }
                }
                metric = Math.abs(1 - metric / potion.effects.length);
                if (minMetric == null || minMetric > metric) {
                    minMetric = metric;
                    matchedPotion = potion;
                }
            }
            if (matchedPotion != null) {
                const matchedPorionRefId = this.vanillaPotions.getRefId(matchedPotion);
                if (matchedPorionRefId != null) {
                    return matchedPorionRefId;
                }
            }
        }
        const normalizedPotionRef = (normalizedPotion != null ?
            this.storeCustomPotion(normalizedPotion, pid) : potionRefId);
        return normalizedPotionRef;
    }

    private isPotion(itemRefId: string, excludeVanilla: boolean = false): boolean {
        let res = false;
        const recordStore = RecordStores.potion;
        // Check if the item used is a potion
        if (recordStore.data.generatedRecords[itemRefId] != null) {
            res = true;
        } else if (recordStore.data.permanentRecords[itemRefId] != null) {
            res = true;
        } else if (!excludeVanilla && this.vanillaPotions.getRecord(itemRefId) != null) {
            res = true;
        }
        return res;
    }

    private getPotion(itemRefId: string): PotionRecord | null {
        let res: PotionRecord | null = null;
        const recordStore = RecordStores.potion;
        res = recordStore.data.generatedRecords[itemRefId];
        if (res == null) {
            res = recordStore.data.permanentRecords[itemRefId];
        }
        if (res == null) {
            res = this.vanillaPotions.getRecord(itemRefId);
        }
        return res;
    }

    private findMatchingCustomPotion(potion: PotionRecord): string | null {
        const recordStore = RecordStores.potion;
        const refIds = Object.keys(recordStore.data.generatedRecords);
        for (const refId of refIds) {
            const customPotion = recordStore.data.generatedRecords[refId] as PotionRecord;
            if (customPotion.effects.length === 0) {
                continue;
            }
            if (customPotion.weight !== potion.weight && customPotion.value !== potion.value &&
                    customPotion.script !== potion.script) {
                continue;
            }
            let effectsMatching = true;
            for (const ae of potion.effects) {
                let effectMatching = false;
                for (const be of customPotion.effects) {
                    if (this.potionEffectsMatch(ae, be) && ae.duration === be.duration) {
                        effectMatching = true;
                        break;
                    }
                }
                if (!effectMatching) {
                    effectsMatching = false;
                    break;
                }
            }
            if (effectsMatching) {
                return refId;
            }
        }
        return null;
    }

    private storeCustomPotion(potion: PotionRecord, pid: any, suffix: string = this.normalizedSuffix): string {
        const recordStore = RecordStores.potion;
        let refId = this.findMatchingCustomPotion(potion);
        if (refId === null) {
            refId = `${recordStore.GenerateRecordId()}${suffix}`;
            recordStore.data.generatedRecords[refId] = potion;
            Players[pid].AddLinkToRecord('potion', refId);
            recordStore.QuicksaveToDrive();
        }

        recordStore.LoadGeneratedRecords(pid, recordStore.data.generatedRecords, [ refId ], false);

        return refId;
    }

    private normalizePotion(potionRefId: string): PotionRecord | null {
        if (potionRefId.endsWith(this.normalizedSuffix)) {
            return this.getPotion(potionRefId);
        }
        return this.potionNormalizer.normalizePotion(this.getPotion(potionRefId));
    }
}

const customPotionNormalizer = new CustomPotionNormalizer();

customEventHooks.registerHandler('OnPlayerInventory',
    customPotionNormalizer.OnPlayerInventoryHandler);
