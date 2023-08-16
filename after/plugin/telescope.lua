-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local action_state = require("telescope.actions.state")
local trouble = require("trouble.providers.telescope")
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

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
				["<C-a>"] = harpoonAction,
				["<c-t>"] = trouble.open_with_trouble,
			},
			n = {
				["a"] = harpoonAction,
				["<c-t>"] = trouble.open_with_trouble,
			},
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<C-p>", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sb", require("telescope.builtin").git_branches, { desc = "[S]earch Git [B]ranches" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sgh", function()
	require("telescope.builtin").live_grep({ additional_args = { "--hidden" } })
end, { desc = "[S]earch by [G]rep including [H]idden" })
vim.keymap.set("n", "<leader>sgi", function()
	require("telescope.builtin").live_grep({ additional_args = { "--no-ignore" } })
end, { desc = "[S]earch by [G]rep including [I]gnored" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
