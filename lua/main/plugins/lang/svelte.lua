local Util = require("util")
return {
  -- depends on the typescript extra
  { import = "main.plugins.lang.typescript" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "svelte" })
      end
    end,
  },

  -- LSP Servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        svelte = {},
      },
    },
  },

  -- Configure tsserver plugin
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      Util.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
        {
          name = "typescript-svelte-plugin",
          location = Util.get_pkg_path(
            "svelte-language-server",
            "/node_modules/typescript-svelte-plugin",
            { warn = false }
          ),
          enableForWorkspaceTypeScriptVersions = true,
        },
      })
    end,
  },
}
