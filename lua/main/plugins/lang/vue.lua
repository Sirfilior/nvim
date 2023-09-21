local V = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "vue" })
      end
    end,
  },
}

local localLsps = require("neoconf").get("localLsps")
if localLsps and localLsps["volar"] then
  return vim.tbl_extend("force", V, {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          volar = {
            filetypes = { "vue", "typescript" },
          },
        },
      },
    },
  })
end

if localLsps and localLsps["vuels"] then
  return vim.tbl_extend("force", V, {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          vuels = {
            init_options = {
              config = {
                vetur = {
                  completion = {
                    autoImport = true,
                    tagCasing = "kebab",
                    useScaffoldSnippets = true,
                  },
                  useWorkspaceDependencies = true,
                  validation = {
                    script = true,
                    style = true,
                    template = true,
                  },
                },
              },
            },
          },
        },
      },
    },
  })
end

return V
