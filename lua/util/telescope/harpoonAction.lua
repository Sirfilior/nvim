local action_state = require("telescope.actions.state")

local harpoonAction = function(_)
	local entry = action_state.get_selected_entry()

	if not entry then
		print("No entry found")
		return
	end

	if entry.filename then
		print("Harpoon: adding " .. entry.filename)
		require("harpoon.mark").add_file(entry.filename)
	else
		print("No file associated with this entry")
	end
end

return harpoonAction
