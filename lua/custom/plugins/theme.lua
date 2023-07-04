return {
	-- Useful plugin to show you pending keybinds.
	{ 'folke/which-key.nvim', opts = {} },

	{
		-- Theme inspired by Atom
		'navarasu/onedark.nvim',
		priority = 1000,
		config = function()
			vim.cmd.colorscheme 'onedark'
		end,
	},
}
