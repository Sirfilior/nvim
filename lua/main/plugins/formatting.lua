local Util = require("util")

local M = {}

---@type ConformOpts
local format_opts = {}

---@param opts ConformOpts
function M.setup(plugin, opts)
  local util = require("conform.util")
  opts.formatters = opts.formatters or {}
  for name, formatter in pairs(opts.formatters) do
    if type(formatter) == "table" then
      local ok, defaults = pcall(require, "conform.formatters." .. name)
      if ok and type(defaults) == "table" then
        opts.formatters[name] = vim.tbl_deep_extend("force", {}, defaults, formatter)
      end
      if opts.formatters[name].extra_args then
        opts.formatters[name].args =
          util.extend_args(opts.formatters[name].args or {}, opts.formatters[name].extra_args)
      end
    end
  end

  format_opts = opts.format
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
          require("conform").format({ formatters = { "injected" } })
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
            require("conform").format(Util.merge(format_opts, { bufnr = buf }))
          end,
          sources = function(buf)
            local ret = require("conform").list_formatters(buf)
            return vim.tbl_map(function(v)
              return v.name
            end, ret)
          end,
        })
      end)
    end,
    opts = function()
      ---@class ConformOpts
      local opts = {
        -- LazyVim will use these options when formatting with the conform.nvim formatter
        format = {
          timeout_ms = 3000,
          async = false,
          quiet = false,
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
          injected = { options = { ignore_errors = true } },
        },
      }
      return opts
    end,
    config = M.setup,
  },
}
