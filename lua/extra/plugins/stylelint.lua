local util = require("conform.util")

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "stylelint")
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        stylelint = {
          cwd = util.root_file({
            -- https://prettier.io/docs/en/configuration.html
            ".stylelintrc",
            ".stylelintrc.json",
            ".stylelintrc.yml",
            ".stylelintrc.yaml",
            ".stylelintrc.json5",
            ".stylelintrc.js",
            ".stylelintrc.cjs",
            ".stylelintrc.toml",
            "stylelint.config.js",
            "stylelint.config.cjs",
            "package.json",
          }),
        },
      },
      formatters_by_ft = {
        ["scss"] = { { "prettierd", "prettier" }, "stylelint" },
        ["less"] = { { "prettierd", "prettier" }, "stylelint" },
      },
    },
  },
}
