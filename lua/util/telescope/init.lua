local custom = {}

local function require_on_exported_call(mod)
  return setmetatable({}, {
    __index = function(_, picker)
      return function(...)
        return require(mod)[picker](...)
      end
    end,
  })
end

custom.multi_rg = require_on_exported_call("util.telescope.__files").multi_rg

return custom
