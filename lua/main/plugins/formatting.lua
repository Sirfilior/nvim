local Util = require("util")

local M = {}

---@type ConformOpts
local format_opts = {}

---@param opts ConformOpts
function M.setup(_, opts)
  for name, formatter in pairs(opts.formatters or {}) do
    if type(formatter) == "table" then
      ---@diagnostic disable-next-line: undefined-field
      if formatter.extra_args then
        ---@diagnostic disable-next-line: undefined-field
        formatter.prepend_args = formatter.extra_args
        Util.deprecate(("opts.formatters.%s.extra_args"):format(name), ("opts.formatters.%s.prepend_args"):format(name))
      end
    end
  end

  for _, key in ipairs({ "format_on_save", "format_after_save" }) do
    if opts[key] then
      Util.warn(
        ("Don't set `opts.%s` for `conform.nvim`.\n**LazyVim** will use the conform formatter automatically"):format(
          key
        )
      )
      ---@diagnostic disable-next-line: no-unknown
      opts[key] = nil
    end
  end
  require("conform").setup(opts)
end

return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      -- Install the conform formatter on VeryLazy
      require("util").on_very_lazy(function()
        require("util").format.register({
          name = "conform.nvim",
          priority = 100,
          primary = true,
          format = function(buf)
            local opts = Util.opts("conform.nvim")
            require("conform").format(Util.merge({}, opts.format, { bufnr = buf }))
          end,
          sources = function(buf)
            local ret = require("conform").list_formatters(buf)
            ---@param v conform.FormatterInfo
            return vim.tbl_map(function(v)
              return v.name
            end, ret)
          end,
        })
      end)
    end,
    opts = function()
      local plugin = require("lazy.core.config").plugins["conform.nvim"]
      if plugin.config ~= M.setup then
        Util.error({
          "Don't set `plugin.config` for `conform.nvim`.\n",
          "This will break **LazyVim** formatting.\n",
          "Please refer to the docs at https://www.lazyvim.org/plugins/formatting",
        }, { title = "LazyVim" })
      end
      ---@class ConformOpts
      local opts = {
        -- LazyVim will use these options when formatting with the conform.nvim formatter
        format = {
          timeout_ms = 3000,
          async = false, -- not recommended to change
          quiet = false, -- not recommended to change
          lsp_fallback = true, -- not recommended to change
        },
        formatters_by_ft = {
          lua = { "stylua" },
          sh = { "shfmt" },
          fish = { "fish_indent" },
        },
        -- LazyVim will merge the options you set here with builtin formatters.
        -- You can also define any custom formatters here.
        ---@type table<string,table>
        formatters = {
          injected = { options = { ignore_errors = true } },
          biome = {
            condition = function(ctx)
              return vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
            end,
          },
          dprint = {
            condition = function(ctx)
              return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
            end,
          },
        },
      }
      return opts
    end,
    config = M.setup,
  },
}
