local ____exports = {}
local dkjson = require("dkjson")
____exports.JSON = {
    parse = function(json)
        return dkjson:decode(json)
    end,
    stringify = function(obj, cd, i)
        if cd == nil then
            cd = nil
        end
        return dkjson:encode(obj, {indent = true, keyorder = nil})
    end
}
return ____exports
