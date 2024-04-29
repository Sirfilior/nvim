return {
  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      settings = {
        save_on_toggle = true,
      },
    },
    config = function(_, opts)
      local harpoon = require("harpoon")

      harpoon:setup(opts)

      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
      end)
      vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      vim.keymap.set("n", "<leader>1", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<leader>2", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<leader>3", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<leader>4", function()
        harpoon:list():select(4)
      end)
      vim.keymap.set("n", "<leader>5", function()
        harpoon:list():select(5)
      end)
    end,
  },
}
