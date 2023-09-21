if not vim.g.vscode then
  return {}
end

local enabled = {
  "lazy.nvim",
  "substitute.nvim",
  "nvim-surround",
  "todo-comments.nvim",
  "nvim-treesitter",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",
}

local Config = require("lazy.core.config")
local Plugin = require("lazy.core.plugin")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name)
end

-- Add some vscode specific keymaps
vim.keymap.set("n", "<leader>sf", "<cmd>Find<cr>")
vim.keymap.set("n", "<leader>sg", [[<cmd>call VSCodeNotify('workbench.action.findInFiles')<cr>]])
vim.keymap.set(
  "n",
  "<leader>sw",
  [[<cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<cr>]]
)
vim.keymap.set("n", "<leader>ss", [[<cmd>call VSCodeNotify('workbench.action.gotoSymbol')<cr>]])
vim.keymap.set("n", "<leader>fe", [[<cmd>call VSCodeNotify('workbench.files.action.focusFilesExplorer')<cr>]])
vim.keymap.set("n", "<leader>ft", [[<cmd>call VSCodeNotify('terminal.focus')<cr>]])
vim.keymap.set("n", "<leader>ca", [[<cmd>call VSCodeNotify('editor.action.quickFix')<cr>]])

-- LSP Settings
-- editor.action.goToReferences
vim.keymap.set("n", "<leader>rn", [[<cmd>call VSCodeNotify('editor.action.goToReferences')<cr>]])

vim.api.nvim_set_keymap("x", "gc", "<Plug>VSCodeCommentary", {})
vim.api.nvim_set_keymap("n", "gc", "<Plug>VSCodeCommentary", {})
vim.api.nvim_set_keymap("o", "gc", "<Plug>VSCodeCommentary", {})
vim.api.nvim_set_keymap("n", "gcc", "<Plug>VSCodeCommentaryLine", {})

-- Override the plugins table with vscode specific settings
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
}
