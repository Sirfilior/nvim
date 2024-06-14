local Util = require("util")
return {
  -- depends on the typescript extra
  { import = "main.plugins.lang.typescript" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "vue" })
      end
    end,
  },

  -- Add LSP servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {},
        vtsls = {
          before_init = function(params, config)
            local result = vim.system(
              { "npm", "query", "#vue" },
              { cwd = params.workspaceFolders[1].name, text = true }
            ):wait()
            if result.stdout ~= "[]" then
              local vuePluginConfig = {
                name = "@vue/typescript-plugin",
                location = require("mason-registry").get_package("vue-language-server"):get_install_path()
                    .. "/node_modules/@vue/language-server",
                languages = { "vue" },
                configNamespace = "typescript",
                enableForWorkspaceTypeScriptVersions = true,
              }
              table.insert(config.settings.vtsls.tsserver.globalPlugins, vuePluginConfig)
            end
          end,
        },
      },
    },
  },

  -- Configure tsserver plugin
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      table.insert(opts.servers.vtsls.filetypes, "vue")
    end,
  },
}
