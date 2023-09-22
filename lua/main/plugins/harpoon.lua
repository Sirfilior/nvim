return {
  {
    "theprimeagen/harpoon",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 20,
      },
    },
    keys = {
      {
        "<leader>a",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Add to marks",
      },
      {
        "<C-e>",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Harpoon quick menu",
      },
      {
        "<leader>1",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        desc = "Harpoon quick menu",
      },
      {
        "<leader>2",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        desc = "Harpoon quick menu",
      },
      {
        "<leader>3",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        desc = "Harpoon quick menu",
      },
      {
        "<leader>4",
        function()
          require("harpoon.ui").nav_file(4)
        end,
        desc = "Harpoon quick menu",
      },
    },
  },
}
