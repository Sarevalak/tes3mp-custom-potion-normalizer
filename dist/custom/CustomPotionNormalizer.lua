-- Lua Library inline imports
function __TS__Index(classProto)
    return function(tbl, key)
        local proto = classProto
        while true do
            local val = rawget(proto, key)
            if val ~= nil then
                return val
            end
            local getters = rawget(proto, "____getters")
            if getters then
                local getter
                getter = getters[key]
                if getter then
                    return getter(tbl)
                end
            end
            local base = rawget(
                rawget(proto, "constructor"),
                "____super"
            )
            if not base then
                break
            end
            proto = rawget(base, "prototype")
        end
    end
end

function __TS__FunctionApply(fn, thisArg, args)
    if args then
        return fn(
            thisArg,
            (unpack or table.unpack)(args)
        )
    else
        return fn(thisArg)
    end
end

function __TS__StringEndsWith(self, searchString, endPosition)
    if endPosition == nil or endPosition > #self then
        endPosition = #self
    end
    return string.sub(self, endPosition - #searchString + 1, endPosition) == searchString
end

function __TS__ArrayPush(arr, ...)
    local items = ({...})
    for ____, item in ipairs(items) do
        arr[#arr + 1] = item
    end
    return #arr
end

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

function __TS__ObjectKeys(obj)
    local result = {}
    for key in pairs(obj) do
        result[#result + 1] = key
    end
    return result
end

local ____Effects = require("custom.CustomPotionNormalizer.Effects")
local EffectsRegistry = ____Effects.EffectsRegistry
local ____PotionNormalizer = require("custom.CustomPotionNormalizer.PotionNormalizer")
local PotionNormalizer = ____PotionNormalizer.PotionNormalizer
local ____VanillaPotionRecordStore = require("custom.CustomPotionNormalizer.VanillaPotionRecordStore")
local VanillaPotionRecordStore = ____VanillaPotionRecordStore.VanillaPotionRecordStore
local tableHelper = require("tableHelper")
CustomPotionNormalizer = {}
CustomPotionNormalizer.name = "CustomPotionNormalizer"
CustomPotionNormalizer.__index = CustomPotionNormalizer
CustomPotionNormalizer.prototype = {}
CustomPotionNormalizer.prototype.____getters = {}
CustomPotionNormalizer.prototype.__index = __TS__Index(CustomPotionNormalizer.prototype)
CustomPotionNormalizer.prototype.constructor = CustomPotionNormalizer
function CustomPotionNormalizer.new(...)
    local self = setmetatable({}, CustomPotionNormalizer.prototype)
    self:____constructor(...)
    return self
end
function CustomPotionNormalizer.prototype.____constructor(self)
    self.potionNormalizer = PotionNormalizer.new(self.effects)
    self.normalizedSuffix = "_normalized"
    self.vanillaPotions = VanillaPotionRecordStore.new()
    self.vanillaPotionRefs = self.vanillaPotions:getRefs()
    self.effects = EffectsRegistry.new()
end
function CustomPotionNormalizer.prototype.____getters.OnPlayerInventoryHandler(self)
    local ____self = self
    return function(...)
        local args = ({...})
        return __TS__FunctionApply(____self.playerInventoryHandler, ____self, args)
    end
end
function CustomPotionNormalizer.prototype.playerInventoryHandler(self, eventStatus, pid)
    if eventStatus.validCustomHandlers ~= false and eventStatus.validDefaultHandler ~= false then
        local removedItems = {}
        local addedItems = {}
        for itemIndex in pairs(Players[pid].data.inventory) do
            local item = Players[pid].data.inventory[itemIndex]
            if item ~= nil and self:isPotion(item.refId, true) and not __TS__StringEndsWith(item.refId, self.normalizedSuffix) and item.count > 0 then
                local newItemRef = self:suggestPotion(item.refId, pid)
                if newItemRef ~= nil then
                    __TS__ArrayPush(removedItems, item)
                    local newItem = __TS__ObjectAssign({}, item)
                    newItem.refId = newItemRef
                    __TS__ArrayPush(addedItems, newItem)
                end
            end
        end
        if #removedItems > 0 then
            for ____, item in ipairs(removedItems) do
                local idx = inventoryHelper.getItemIndex(Players[pid].data.inventory, item.refId)
                if idx ~= nil then
                    Players[pid].data.inventory[idx] = nil
                end
            end
            tableHelper:cleanNils(Players[pid].data.inventory)
            Players[pid]:LoadItemChanges(removedItems, enumerations.inventory.REMOVE)
        end
        if #addedItems > 0 then
            for ____, item in ipairs(addedItems) do
                inventoryHelper.addItem(Players[pid].data.inventory, item.refId, item.count, item.charge, item.enchantmentCharge, item.soul)
            end
            Players[pid]:LoadItemChanges(addedItems, 1)
        end
    end
end
function CustomPotionNormalizer.prototype.potionEffectsMatch(self, ae, be)
    if ae.id == be.id then
        if ae.skill == be.skill and ae.attribute == be.attribute then
            return true
        end
    end
    return false
end
function CustomPotionNormalizer.prototype.suggestPotion(self, potionRefId, pid)
    local normalizedPotion = self:normalizePotion(potionRefId)
    local matchingPotions = {}
    if normalizedPotion ~= nil then
        for ____, refId in ipairs(self.vanillaPotionRefs) do
            local potion = self.vanillaPotions:getRecord(refId)
            local matching = #potion.effects == #normalizedPotion.effects
            for ____, ae in ipairs(potion.effects) do
                if not matching then
                    break
                end
                for ____, be in ipairs(normalizedPotion.effects) do
                    if not self:potionEffectsMatch(ae, be) then
                        matching = false
                        break
                    end
                end
            end
            if matching then
                __TS__ArrayPush(matchingPotions, potion)
            end
        end
        local minMetric = nil
        local matchedPotion = nil
        for ____, potion in ipairs(matchingPotions) do
            local metric = 0
            for ____, ae in ipairs(potion.effects) do
                for ____, be in ipairs(normalizedPotion.effects) do
                    if self:potionEffectsMatch(ae, be) then
                        metric = metric + (be.magnitudeMax * be.duration) / (ae.magnitudeMax * ae.duration * 2)
                        break
                    end
                end
            end
            metric = math.abs(1 - metric / #potion.effects)
            if minMetric == nil or minMetric > metric then
                minMetric = metric
                matchedPotion = potion
            end
        end
        if matchedPotion ~= nil then
            local matchedPorionRefId = self.vanillaPotions:getRefId(matchedPotion)
            if matchedPorionRefId ~= nil then
                return matchedPorionRefId
            end
        end
    end
    local normalizedPotionRef = ((normalizedPotion ~= nil) and self:storeCustomPotion(normalizedPotion, pid) or potionRefId)
    return normalizedPotionRef
end
function CustomPotionNormalizer.prototype.isPotion(self, itemRefId, excludeVanilla)
    if excludeVanilla == nil then
        excludeVanilla = false
    end
    local res = false
    local recordStore = RecordStores.potion
    if recordStore.data.generatedRecords[itemRefId] ~= nil then
        res = true
    elseif recordStore.data.permanentRecords[itemRefId] ~= nil then
        res = true
    elseif not excludeVanilla and self.vanillaPotions:getRecord(itemRefId) ~= nil then
        res = true
    end
    return res
end
function CustomPotionNormalizer.prototype.getPotion(self, itemRefId)
    local res = nil
    local recordStore = RecordStores.potion
    res = recordStore.data.generatedRecords[itemRefId]
    if res == nil then
        res = recordStore.data.permanentRecords[itemRefId]
    end
    if res == nil then
        res = self.vanillaPotions:getRecord(itemRefId)
    end
    return res
end
function CustomPotionNormalizer.prototype.findMatchingCustomPotion(self, potion)
    local recordStore = RecordStores.potion
    local refIds = __TS__ObjectKeys(recordStore.data.generatedRecords)
    for ____, refId in ipairs(refIds) do
        do
            local customPotion = recordStore.data.generatedRecords[refId]
            if #customPotion.effects == 0 then
                goto __continue40
            end
            if customPotion.weight ~= potion.weight and customPotion.value ~= potion.value and customPotion.script ~= potion.script then
                goto __continue40
            end
            local effectsMatching = true
            for ____, ae in ipairs(potion.effects) do
                local effectMatching = false
                for ____, be in ipairs(customPotion.effects) do
                    if self:potionEffectsMatch(ae, be) and ae.duration == be.duration then
                        effectMatching = true
                        break
                    end
                end
                if not effectMatching then
                    effectsMatching = false
                    break
                end
            end
            if effectsMatching then
                return refId
            end
        end
        ::__continue40::
    end
    return nil
end
function CustomPotionNormalizer.prototype.storeCustomPotion(self, potion, pid, suffix)
    if suffix == nil then
        suffix = self.normalizedSuffix
    end
    local recordStore = RecordStores.potion
    local refId = self:findMatchingCustomPotion(potion)
    if refId == nil then
        refId = tostring(
            recordStore:GenerateRecordId()
        ) .. tostring(suffix)
        recordStore.data.generatedRecords[refId] = potion
        Players[pid]:AddLinkToRecord("potion", refId)
        recordStore:QuicksaveToDrive()
    end
    recordStore:LoadGeneratedRecords(pid, recordStore.data.generatedRecords, {refId}, false)
    return refId
end
function CustomPotionNormalizer.prototype.normalizePotion(self, potionRefId)
    if __TS__StringEndsWith(potionRefId, self.normalizedSuffix) then
        return self:getPotion(potionRefId)
    end
    return self.potionNormalizer:normalizePotion(
        self:getPotion(potionRefId)
    )
end
local customPotionNormalizer = CustomPotionNormalizer.new()
customEventHooks.registerHandler("OnPlayerInventory", customPotionNormalizer.OnPlayerInventoryHandler)
