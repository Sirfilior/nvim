return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "vue" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {
          filetypes = { "vue", "typescript" },
        },
      },
    },
    setup = {
      volar = function(_, opts)
        if not require("neoconf").get("volar.enable") then
          return true
        end
      end,
    },
  },
}
