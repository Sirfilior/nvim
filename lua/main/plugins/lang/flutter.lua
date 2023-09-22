return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    opts = {
      lsp = {
        on_attach = function(client, buffer)
          require("main.plugins.lsp.keymaps").on_attach(client, buffer)
        end,
      },
    },
    config = function(_, opts)
      require("telescope").load_extension("flutter")
    end,
  },
  {
    {
      "nvim-telescope/telescope.nvim",
      event = "VeryLazy",
      config = function()
        require("telescope").load_extension("flutter")
      end,
      keys = {
        { "<leader>fc", "<Cmd>Telescope flutter commands<CR>", desc = "Flutter Commands" },
      },
    },
  },
}
