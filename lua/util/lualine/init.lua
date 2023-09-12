local M = {}

M.harpoon_component = function()
	local mark_idx = require("harpoon.mark").get_current_index()
	if mark_idx == nil then
		return ""
	end

	return string.format("󱡅 %d", mark_idx)
end

return M
