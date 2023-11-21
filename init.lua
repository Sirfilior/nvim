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
  { import = "main.plugins.lang.php" },
  { import = "main.plugins.lang.vue" },
  -- { import = "main.plugins.lang.flutter" },
  { import = "main.plugins.lang.docker" },
  { import = "main.plugins.lang.clangd" },
  { import = "main.plugins.lang.cmake" },
  { import = "main.plugins.lang.markdown" },

  { import = "extra.plugins.vscode" },
  { import = "extra.plugins.eslint" },
  { import = "extra.plugins.prettier" },
  -- { import = "extra.plugins.stylelint" },

  { import = "scrap.plugins.cellular" },
  { import = "scrap.plugins.typo3" },
  { import = "scrap.plugins.bigfile" },
}, {})
