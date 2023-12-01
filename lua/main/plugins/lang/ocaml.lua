return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ocaml",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ocamllsp = {
          mason = false,
          settings = {
            codelens = { enable = true },
          },
          get_language_id = function(_, ftype)
            return ftype
          end,
        },
      },
    },
  },
  -- Ensure Go tools are installed
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "ocamlformat " },
      },
    },
  },
}
