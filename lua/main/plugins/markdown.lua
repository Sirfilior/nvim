return {
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    lazy = true,
    init = function()
      local function load_then_exec(alias, cmd)
        return function()
          vim.cmd.delcommand(alias)
          require("lazy").load({ plugins = { "markdown-preview.nvim" } })
          vim.api.nvim_exec_autocmds("BufEnter", {}) -- commands appear only after BufEnter
          vim.cmd(cmd)
        end
      end
      local aliases = {
        MDP = "MarkdownPreview",
        MDPS = "MarkdownPreviewStop",
        MDPT = "MarkdownPreviewToggle",
      }
      for alias, cmd in pairs(aliases) do
        vim.api.nvim_create_user_command(alias, load_then_exec(alias, cmd), {})
      end
    end,
  },
}
