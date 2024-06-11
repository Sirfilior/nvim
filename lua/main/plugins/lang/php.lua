return {

  -- add typescript to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "php", "twig", "typoscript" })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "php-cs-fixer",
        "phpcs",
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      ---@type table<string, conform.FiletypeFormatter>
      formatters_by_ft = {
        ["php"] = { "php_cs_fixer" },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.phpcsfixer)
      table.insert(opts.sources, nls.builtins.diagnostics.phpcs)
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        php = { "phpcs" },
      },
    },
  },
  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = { "gbprod/phpactor.nvim" },
    opts = {
      -- make sure mason installs the server
      servers = {
        phpactor = {},
        twiggy_language_server = {},
      },
      setup = {
        phpactor = function(_, opts)
          require("phpactor").setup({
            install = {
              bin = vim.fn.stdpath("data") .. "/mason/bin/phpactor",
            },
            lspconfig = {
              enabled = true,
              options = opts,
            },
          })
          return true
        end,
      },
    },
  },
}
