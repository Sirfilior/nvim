local Util = require("util")

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  cmd = "Neotree",
  keys = {
    {
      "<leader>fE",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
      end,
      desc = "[F]ile Tree [E]xplorer NeoTree (root)",
    },
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ toggle = true, reveal = true })
      end,
      desc = "[F]ile Tree [E]xplorer NeoTree (cwd)",
    },
    {
      "<leader>ge",
      function()
        require("neo-tree.command").execute({ source = "git_status", toggle = true })
      end,
      desc = "Git explorer",
    },
    {
      "<leader>be",
      function()
        require("neo-tree.command").execute({ source = "buffers", toggle = true })
      end,
      desc = "Buffer explorer",
    },
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  init = function()
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,
  opts = {
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
    window = {
      width = 50,
      position = "current",
    },
    default_component_configs = {
      icon = {
        folder_empty = "󰜌",
        folder_empty_open = "󰜌",
      },
      git_status = {
        symbols = {
          renamed = "󰁕",
          unstaged = "󰄱",
        },
      },
      file_size = {
        enabled = false,
      },
      type = {
        enabled = false,
      },
      last_modified = {
        enabled = false,
      },
    },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        hide_hidden = false,
        hide_dotfiles = false,
      },
      window = {
        mappings = {
          ["f"] = "noop",
          ["fs"] = "telescope_find",
          ["fg"] = "telescope_grep",
          ["o"] = "system_open",
        },
      },
      commands = {
        telescope_find = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require("telescope.builtin").find_files(require("util.telescope").getTelescopeOpts(state, path))
        end,
        telescope_grep = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require("telescope.builtin").live_grep(require("util.telescope").getTelescopeOpts(state, path))
        end,
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          path = vim.fn.shellescape(path, 1)
          -- macOs: open file in default application in the background.
          vim.api.nvim_command("silent !open -g " .. path)
          -- Linux: open file in default application
          vim.api.nvim_command("silent !xdg-open " .. path)
        end,
      },
    },
    document_symbols = {
      kinds = {
        File = { icon = "󰈙", hl = "Tag" },
        Namespace = { icon = "󰌗", hl = "Include" },
        Package = { icon = "󰏖", hl = "Label" },
        Class = { icon = "󰌗", hl = "Include" },
        Property = { icon = "󰆧", hl = "@property" },
        Enum = { icon = "󰒻", hl = "@number" },
        Function = { icon = "󰊕", hl = "Function" },
        String = { icon = "󰀬", hl = "String" },
        Number = { icon = "󰎠", hl = "Number" },
        Array = { icon = "󰅪", hl = "Type" },
        Object = { icon = "󰅩", hl = "Type" },
        Key = { icon = "󰌋", hl = "" },
        Struct = { icon = "󰌗", hl = "Type" },
        Operator = { icon = "󰆕", hl = "Operator" },
        TypeParameter = { icon = "󰊄", hl = "Type" },
        StaticMethod = { icon = "󰠄 ", hl = "Function" },
      },
    },
  },
  config = function(_, opts)
    local function on_move(data)
      Util.lsp.on_rename(data.source, data.destination)
    end

    local events = require("neo-tree.events")
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })

    require("neo-tree").setup(opts)
    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*lazygit",
      callback = function()
        if package.loaded["neo-tree.sources.git_status"] then
          require("neo-tree.sources.git_status").refresh()
        end
      end,
    })
  end,
}
