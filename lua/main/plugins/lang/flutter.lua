local Util = require("util")

return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    keys = {
      { "<leader>fc", "<Cmd>Telescope flutter commands<CR>", desc = "Flutter Commands" },
    },
    opts = function()
      Util.on_load("telescope.nvim", function()
        require("telescope").load_extension("flutter")
      end)
      return {
        lsp = {
          on_attach = function(client, buffer)
            require("main.plugins.lsp.keymaps").on_attach(client, buffer)
          end,
        },
      }
    end,
  },
}
