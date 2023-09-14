return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
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
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)

      -- Enable telescope fzf native, if installed
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("notify")
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
          require("telescope.builtin").git_file()
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
          require("telescope.builtin").find_files()
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
        "<leader>sg",
        function()
          require("util.telescope").multi_rg()
        end,
        desc = "[S]earch by [G]rep",
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
    },
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },
}
