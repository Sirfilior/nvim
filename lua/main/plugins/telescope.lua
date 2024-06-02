local have_make = vim.fn.executable("make") == 1
local have_cmake = vim.fn.executable("cmake") == 1
local Util = require("util")
return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    version = false,
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
        build = have_make and "make"
          or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        enabled = have_make or have_cmake,
        config = function(plugin)
          Util.on_load("telescope.nvim", function()
            local ok, err = pcall(require("telescope").load_extension, "fzf")
            if not ok then
              local lib = plugin.dir .. "/build/libfzf." .. "so"
              if not vim.uv.fs_stat(lib) then
                Util.warn("`telescope-fzf-native.nvim` not built. Rebuilding...")
                require("lazy").build({ plugins = { plugin }, show = false }):wait(function()
                  Util.info("Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim.")
                end)
              else
                Util.error("Failed to load `telescope-fzf-native.nvim`:\n" .. err)
              end
            end
          end)
        end,
      },
    },
    opts = function()
      local actions = require("telescope.actions")
      local open_with_trouble = require("trouble.sources.telescope").open
      local harpoonAction = require("util.telescope.harpoonAction")
      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          preview = {
            filetype_hook = require("util.telescope.previewerHook"),
          },
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
              ["<C-a>"] = harpoonAction,
              ["<c-t>"] = open_with_trouble,
              ["<a-t>"] = open_with_trouble,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
            },
            n = {
              ["a"] = harpoonAction,
              ["<c-t>"] = open_with_trouble,
              ["q"] = actions.close,
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
          require("telescope.builtin").find_files()
        end,
        desc = "[S]earch [F]iles",
      },
      {
        "<leader>sF",
        function()
          require("telescope.builtin").find_files({ hidden = true, cwd = Util.root() })
        end,
        desc = "[S]earch [F]iles Root",
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
        "<leader>sgr",
        function()
          require("util.telescope").multi_rg({ cwd = Util.root({}) })
        end,
        desc = "[S]earch [G]rep Root",
      },
      {
        "<leader>sd",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "[S]earch [D]iagnostics",
      },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      {
        "<leader>sS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = require("util").ui.get_kind_filter(),
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
  },
}
