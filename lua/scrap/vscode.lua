if not vim.g.vscode then
	return {}
end

local disabled = {
	"catppuccin/nvim",
}

local Config = require("lazy.core.config")
local Plugin = require("lazy.core.plugin")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
	-- return not vim.tbl_contains(enabled, plugin.name)
	return false
end

-- Add some vscode specific keymaps
vim.api.nvim_create_autocmd("User", {
	pattern = "LazyVimKeymaps",
	callback = function()
		vim.keymap.set("n", "<leader><space>", "<cmd>Find<cr>")
		vim.keymap.set("n", "<leader>/", [[<cmd>call VSCodeNotify('workbench.action.findInFiles')<cr>]])
		vim.keymap.set("n", "<leader>ss", [[<cmd>call VSCodeNotify('workbench.action.gotoSymbol')<cr>]])
	end,
})

-- Override the plugins table with vscode specific settings
return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { highlight = { enable = false } },
	},
}
