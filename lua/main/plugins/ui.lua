return {
  -- Useful plugin to show you pending keybinds.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gz"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    cond = function()
      local ok = pcall(require, "magick")
      return ok
    end,
    init = function()
      package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
      package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
    end,
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
      },
      max_width = 100, -- tweak to preference
      max_height = 12, -- ^
      max_height_window_percentage = math.huge, -- this is necessary for a good experience
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      kitty_method = "normal",
    },
  },
  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "moon",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        local blend = require("tokyonight.util").blend
        colors.git = {
          change = blend(colors.blue, colors.bg, "ee"),
          add = blend(colors.green, colors.bg, "ee"),
          delete = blend(colors.red, colors.bg, "dd"),
        }
        colors.gitSigns = {
          change = blend(colors.blue, colors.bg, "ee"),
          add = blend(colors.green, colors.bg, "ee"),
          delete = blend(colors.red, colors.bg, "ee"),
        }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    enabled = false,
    priority = 1000,
    opts = {
      compile = false, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = {
          wave = {},
          lotus = {},
          dragon = {},
          sakura = {},
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          Normal = { bg = "none" },
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
        }
      end,

      theme = "wave", -- Load "wave" theme when 'background' option is not set
      background = { -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
      },
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa")
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣤⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠲⠾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
=======================⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⢿⣿⣿⣿⣿⣿⣿⡇==================
=======================⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠙⣿⣿⣿⣿⣿⠁==================
=======================⠛⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢠⣿⣿⣿⣿⡏===================
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠏⠉⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢀⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡿⣀⣀⣤⣾⣿⣿⣿⣿⣿⠁⠈⣿⣿⣿⣿⣿⣿⣿⠇⣼⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡿⠁⣿⣿⣿⣿⣿⣿⣿⣿⣿⢀⣼⣿⣿⣿⣿⣿⠃⠈⢠⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⡇⢺⣿⣿⣿⣿⣿⣿⣦⠀⢸⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠙⠻⠿⢿⣿⣿⠿⠇⢸⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⡿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⡿⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ]]
      logo = string.rep("\n", 1) .. logo

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
            { action = function () require("util.telescope").multi_rg() end,       desc = " Search",          icon = " ", key = "s" },
            { action = "Neotree",                                                  desc = " Explorer",        icon = " ", key = "t" },
            { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
            { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
            { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
    priority = 1000,
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      transparent_background = true, -- disables setting the background color.
      color_overrides = {},
      custom_highlights = {},
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        mason = true,
        neotree = true,
        which_key = true,
        noice = true,
        notify = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        lsp_trouble = true,
        dap = {
          enabled = true,
          enable_ui = true, -- enable nvim-dap-ui
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-macchiato")
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
    end,
  },
}

--  ⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣆⠀⢀⣀⣀⣤⣤⣤⣦⣦⣤⣤⣄⣀⣀⠀⢠⣾⣿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⣿⠟⠀⠀⠀⠀⠀⣀⣤⣤⣤⡀⠀⠀⠀⠀⠀⢀⣤⣤⣤⣄⡀⠀⠀⠀⠀⠘⣿⡿⠿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡟⠀⠀⠀⠀⣠⣾⣿⣿⣟⣿⡇⠀⠀⠀⠀⠀⢸⣿⣿⣻⣿⣿⣦⠀⠀⠀⠀⠸⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠁⠀⠀⠀⠀⣿⣿⣿⣿⣿⡟⢠⣶⣾⣿⣿⣷⣤⢽⣿⣿⣿⣿⣿⡇⠀⠀⣀⣤⣿⣷⣴⣶⣦⣀⡀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣤⣠⣇⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⠀⠘⠻⣿⣿⣿⡿⠋⠀⢹⣿⣿⣿⣿⡇⠀⣿⣿⣿⡏⢹⣿⠉⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠹⣿⣿⠿⠋⠀⢤⣀⢀⣼⡄⠀⣠⠀⠈⠻⣿⣿⠟⠀⢸⣿⣇⣽⣿⠿⠿⠿⣿⣅⣽⣿⡇⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠁⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣟⠁⠀⠀⠀⠈⣿⣿⣿⡇⠀⠀⠀⠀⢀
-- ⠛⠛⠛⠛⠛⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛
-- ⠀⠀⠀⠀⠀⠀⠘⠛⠻⢿⣿⣿⣿⣿⣿⠟⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
