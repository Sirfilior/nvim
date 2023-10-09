return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = {
      {
        "debugloop/telescope-undo.nvim",
        keys = { { "<leader>U", "<cmd>Telescope undo<cr>" } },
        config = function()
          require("telescope").load_extension("undo")
        end,
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    opts = function()
      local trouble = require("trouble.providers.telescope")
      local harpoonAction = require("util.telescope.harpoonAction")
      return {
        defaults = {
          preview = {
            filetype_hook = require("util.telescope.previewerHook"),
          },
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
              ["<C-a>"] = harpoonAction,
              ["<c-t>"] = trouble.open_with_trouble,
            },
            n = {
              ["a"] = harpoonAction,
              ["<c-t>"] = trouble.open_with_trouble,
            },
          },
        },
        extensions = {
          fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
          },

          fzf_writer = {
            use_highlighter = false,
            minimum_grep_characters = 6,
          },
        },
      }
    end,
    keys = {
      {
        "<leader>?",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "[?] Find recently opened files",
      },
      {
        "<leader>/",
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = "[/] Fuzzily search in current buffer",
      },
      {
        "<C-p>",
        function()
          require("telescope.builtin").git_files()
        end,
        desc = "Search [G]it [F]iles",
      },
      {
        "<leader>sb",
        function()
          require("telescope.builtin").git_branches()
        end,
        desc = "[S]earch Git [B]ranches",
      },
      {
        "<leader>sf",
        function()
          require("telescope.builtin").find_files({ hidden = true })
        end,
        desc = "[S]earch [F]iles",
      },
      {
        "<leader>sh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "[S]earch [H]elp",
      },
      {
        "<leader>sw",
        function()
          require("telescope.builtin").grep_string()
        end,
        desc = "[S]earch current [W]ord",
      },
      {
        "<C-s>",
        function()
          require("util.telescope").multi_rg()
        end,
        desc = "[S]earch [G]rep",
      },
      {
        "<leader>ss",
        function()
          require("util.telescope").multi_rg()
        end,
        desc = "[S]earch [S]tring by [G]rep",
      },
      {
        "<leader>sgh",
        function()
          require("telescope.builtin").live_grep({ additional_args = { "--hidden" } })
        end,
        desc = "[S]earch by [G]rep including [H]idden",
      },
      {
        "<leader>sgi",
        function()
          require("telescope.builtin").live_grep({ additional_args = { "--no-ignore" } })
        end,
        desc = "[S]earch by [G]rep including [I]gnored",
      },
      {
        "<leader>sd",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "[S]earch [D]iagnostics",
      },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      -- {
      --   "<leader>fe",
      --   "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
      --   desc = "Telescope File Browser",
      -- },
    },
  },
}
