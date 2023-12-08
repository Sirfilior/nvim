return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    cmd = { "FzfLua" },
    opts = {
      winopts = { preview = { default = "bat" } },
      manpages = { previewer = "man_native" },
      helptags = { previewer = "help_native" },
      tags = { previewer = "bat" },
      btags = { previewer = "bat" },
    },
    keys = {
      {
        "<leader>fs",
        "<cmd>FzfLua<cr>",
        desc = "[F]zf [R]esume",
      },
      {
        "<leader>ff",
        function()
          require("fzf-lua").files()
        end,
        desc = "[F]zf [F]iles",
      },
      {
        "<leader>fG",
        function()
          require("fzf-lua").grep()
        end,
        desc = "[F]zf [G]rep",
      },
      {
        "<leader>fg",
        function()
          require("fzf-lua").live_grep()
        end,
        desc = "[F]zf Live[G]rep",
      },
      {
        "<leader>fr",
        function()
          require("fzf-lua").resume()
        end,
        desc = "[F]zf [R]esume",
      },
    },
  },
}
