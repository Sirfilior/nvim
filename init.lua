require("config")

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  { import = "main.plugins" },

  { import = "main.setup" },

  { import = "main.plugins.dap.core" },

  { import = "main.plugins.lang.react" },
  { import = "main.plugins.lang.svelte" },
  { import = "main.plugins.lang.astro" },
  { import = "main.plugins.lang.tailwind" },
  { import = "main.plugins.lang.go" },
  { import = "main.plugins.lang.rust" },
  { import = "main.plugins.lang.typescript" },
  { import = "main.plugins.lang.python" },
  -- { import = "main.plugins.lang.ocaml" },
  { import = "main.plugins.lang.php" },
  { import = "main.plugins.lang.vue" },
  { import = "main.plugins.lang.docker" },
  { import = "main.plugins.lang.clangd" },
  { import = "main.plugins.lang.cmake" },
  { import = "main.plugins.lang.markdown" },
  { import = "main.plugins.lang.java" },
  { import = "main.plugins.lang.kotlin" },
  { import = "main.plugins.lang.omnisharp" },

  -- { import = "extra.plugins.fzf" },
  { import = "extra.plugins.vscode" },
  { import = "extra.plugins.eslint" },
  { import = "extra.plugins.prettier" },
  { import = "extra.plugins.kitty" },
  -- { import = "extra.plugins.stylelint" },

  { import = "scrap.plugins.experiments" },
  { import = "scrap.plugins.cellular" },
  { import = "scrap.plugins.typo3" },
}, {})

-- Setup after lazy, to get lazy utils
require("config.remap")
