return {
	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
		opts = function()
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
			return {
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
			}
		end,
		config = function(_, opts)
			require("telescope").setup(opts)

			-- Enable telescope fzf native, if installed
			require("telescope").load_extension("fzf")
		end,
		keys = {
			{
				"<leader>?",
				function()
					require("telescope.builtin").oldfiles()
				end,
				desc = "[?] Find recently opened files",
			},
			{
				"<leader>/",
				function()
					-- You can pass additional configuration to telescope to change theme, layout, etc.
					require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end,
				desc = "[/] Fuzzily search in current buffer",
			},

			{
				"<C-p>",
				function()
					require("telescope.builtin").git_file()
				end,
				desc = "Search [G]it [F]iles",
			},
			{
				"<leader>sb",
				function()
					require("telescope.builtin").git_branches()
				end,
				desc = "[S]earch Git [B]ranches",
			},
			{
				"<leader>sf",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "[S]earch [F]iles",
			},
			{
				"<leader>sh",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "[S]earch [H]elp",
			},
			{
				"<leader>sw",
				function()
					require("telescope.builtin").grep_string()
				end,
				desc = "[S]earch current [W]ord",
			},
			{
				"<leader>sg",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "[S]earch by [G]rep",
			},
			{
				"<leader>sgh",
				function()
					require("telescope.builtin").live_grep({ additional_args = { "--hidden" } })
				end,
				desc = "[S]earch by [G]rep including [H]idden",
			},
			{
				"<leader>sgi",
				function()
					require("telescope.builtin").live_grep({ additional_args = { "--no-ignore" } })
				end,
				desc = "[S]earch by [G]rep including [I]gnored",
			},
			{
				"<leader>sd",
				function()
					require("telescope.builtin").diagnostics()
				end,
				desc = "[S]earch [D]iagnostics",
			},
		},
	},

	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},
}
