local action_state = require("telescope.actions.state")

local harpoonAction = function(_)
  local entry = action_state.get_selected_entry()

  if not entry then
    print("No entry found")
    return
  end

  if entry.filename then
    local item = {
      value = entry.filename,
      context = {
        row = 1,
        col = 0,
      },
    }
    print("Harpoon: adding " .. entry.filename)
    require("harpoon"):list():append(item)
  else
    print("No file associated with this entry")
  end
end

return harpoonAction
