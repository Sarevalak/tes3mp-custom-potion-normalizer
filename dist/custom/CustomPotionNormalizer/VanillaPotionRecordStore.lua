-- Lua Library inline imports
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

function __TS__ArrayMap(arr, callbackfn)
    local newArray = {}
    do
        local i = 0
        while i < #arr do
            newArray[i + 1] = callbackfn(_G, arr[i + 1], i, arr)
            i = i + 1
        end
    end
    return newArray
end

function __TS__ArrayFilter(arr, callbackfn)
    local result = {}
    do
        local i = 0
        while i < #arr do
            if callbackfn(_G, arr[i + 1], i, arr) then
                result[#result + 1] = arr[i + 1]
            end
            i = i + 1
        end
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

local ____exports = {}
____exports.VanillaPotionRecordStore = {}
local VanillaPotionRecordStore = ____exports.VanillaPotionRecordStore
VanillaPotionRecordStore.name = "VanillaPotionRecordStore"
VanillaPotionRecordStore.__index = VanillaPotionRecordStore
VanillaPotionRecordStore.prototype = {}
VanillaPotionRecordStore.prototype.__index = VanillaPotionRecordStore.prototype
VanillaPotionRecordStore.prototype.constructor = VanillaPotionRecordStore
function VanillaPotionRecordStore.new(...)
    local self = setmetatable({}, VanillaPotionRecordStore.prototype)
    self:____constructor(...)
    return self
end
function VanillaPotionRecordStore.prototype.____constructor(self)
    self.records = {}
    self.blackList = {}
    self.blackList = jsonInterface.load("custom/CustomPotionNormalizer/blackList.json")
    self:addAll(
        jsonInterface.load("custom/CustomPotionNormalizer/00ALCH.json")
    )
    self:addAll(
        jsonInterface.load("custom/CustomPotionNormalizer/01ALCH.json")
    )
    self:addAll(
        jsonInterface.load("custom/CustomPotionNormalizer/02ALCH.json")
    )
end
function VanillaPotionRecordStore.prototype.getRefs(self)
    return __TS__ObjectKeys(self.records)
end
function VanillaPotionRecordStore.prototype.getRefId(self, potion)
    return __TS__ArrayFind(
        __TS__ObjectKeys(self.records),
        function(____, k) return self.records[k] == potion end
    ) or nil
end
function VanillaPotionRecordStore.prototype.getRecord(self, key)
    return self.records[key]
end
function VanillaPotionRecordStore.prototype.getRecords(self)
    return self.records
end
function VanillaPotionRecordStore.prototype.addAll(self, potions)
    __TS__ArrayForEach(
        __TS__ArrayFilter(
            potions,
            function(____, potion) return not __TS__ArrayFind(
                self.blackList,
                function(____, refId) return refId == potion.refId end
            ) end
        ),
        function(____, potion)
            local effects = __TS__ArrayMap(
                potion.effects,
                function(____, effect)
                    return {area = effect.area, attribute = effect.attribute, duration = effect.duration, id = effect.effect, magnitudeMax = effect.magnitude_max, magnitudeMin = effect.magnitude_min, rangeType = effect.range, skill = effect.skill}
                end
            )
            self.records[potion.refId] = {autoCalc = potion.autocalc, effects = effects, icon = "", model = "", name = "", script = "", value = potion.value, weight = potion.weight}
        end
    )
end
return ____exports
