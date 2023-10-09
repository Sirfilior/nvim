-- Git related plugins
return {
  {
    "tpope/vim-fugitive",
    opts = {},
    event = { "CmdlineEnter" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git" },
      { "gh", "<cmd>diffget //2<CR>", desc = "Git diff 2" },
      { "gl", "<cmd>diffget //3<CR>", desc = "Git diff 3" },
    },
    config = function()
      local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

      local autocmd = vim.api.nvim_create_autocmd
      autocmd("BufWinEnter", {
        group = ThePrimeagen_Fugitive,
        pattern = "*",
        callback = function()
          if vim.bo.ft ~= "fugitive" then
            return
          end

          local bufnr = vim.api.nvim_get_current_buf()
          local opts = { buffer = bufnr, remap = false }
          vim.keymap.set("n", "<leader>p", function()
            vim.cmd.Git("push")
          end, opts)

          -- rebase always
          vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git({ "pull", "--rebase" })
          end, opts)

          -- NOTE: It allows me to easily set the branch i am pushing and any tracking
          -- needed if i did not set the branch up correctly
          vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
        end,
      })
    end,
  },
  "tpope/vim-rhubarb",
  -- Adds git releated signs to the gutter, as well as utilities for managing changes
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(bufnr)
        vim.keymap.set(
          "n",
          "<leader>gp",
          require("gitsigns").prev_hunk,
          { buffer = bufnr, desc = "[G]o to [P]revious Hunk" }
        )
        vim.keymap.set(
          "n",
          "<leader>gn",
          require("gitsigns").next_hunk,
          { buffer = bufnr, desc = "[G]o to [N]ext Hunk" }
        )
        vim.keymap.set(
          "n",
          "<leader>ph",
          require("gitsigns").preview_hunk,
          { buffer = bufnr, desc = "[P]review [H]unk" }
        )
      end,
    },
  },
  -- better diffing
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
  },
}
