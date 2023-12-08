-- measure startuptime
return {
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  { "jesseleite/nvim-macroni", cmd = { "YankMacro" } },

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },
}
