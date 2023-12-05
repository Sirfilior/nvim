return {
  { "tjdevries/ocaml.nvim", config = true },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ocaml",
        "rapper",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ocamllsp = {
          keys = {
            {
              "<leader>out",
              function()
                require("ocaml.actions").update_interface_type()
              end,
              desc = "[O]caml [U]pdate [T]ype",
            },
          },
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
}
