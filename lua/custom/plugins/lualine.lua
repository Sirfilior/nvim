return {
	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", opt = true },
		},
		opts = {
			options = {
				theme = "onedark",
				component_separators = "|",
				section_separators = "",
			},
		},
	},
}
