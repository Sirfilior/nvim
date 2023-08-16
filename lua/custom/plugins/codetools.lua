return {
	-- Detect tabstop and shiftwidth automatically
	{ "tpope/vim-sleuth" },
	{ "tpope/vim-abolish" },
	{ "mbbill/undotree" },
	-- { 'github/copilot.vim' },
	{
		"nvim-pack/nvim-spectre",
		cmd = "Spectre",
		opts = { open_cmd = "noswapfile vnew" },
		-- stylua: ignore
		keys = {
			{ "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{ "<leader>to", "<cmd>TroubleToggle<cr>", desc = "(Trouble)" },
			{ "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			{ "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
			{ "<leader>tl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
			{ "<leader>tq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
			{ "<leader>tq", "<cmd>TroubleToggle lsp_references<cr>", desc = "LSP Ref List (Trouble)" },
		},
	},
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"gbprod/substitute.nvim",
		keys = {
			{
				"<leader>r",
				function()
					require("substitute").operator()
				end,
				noremap = true,
			},
			{
				"<leader>rs",
				function()
					require("substitute").line()
				end,
				noremap = true,
			},
			{
				"<leader>R",
				function()
					require("substitute").eol()
				end,
				noremap = true,
			},
			{
				"<leader>r",
				function()
					require("substitute").visual()
				end,
				"x",
				noremap = true,
			},
			{
				"<leader>s",
				function()
					require("substitute.range").opeartor()
				end,
				noremap = true,
			},
			{
				"<leader>s",
				function()
					require("substitute.range").visual()
				end,
				"x",
				noremap = true,
			},
			{
				"<leader>ss",
				function()
					require("substitute.range").word()
				end,
				noremap = true,
			},
		},
		config = function()
			require("substitute").setup({})
		end,
	},
	{
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		opts = {
			char = "┊",
			show_trailing_blankline_indent = false,
		},
	},

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },
}
