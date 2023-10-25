return {
  -- Detect tabstop and shiftwidth automatically
  { "tpope/vim-sleuth" },
  { "tpope/vim-abolish" },
  { "mbbill/undotree", keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
  } },
  -- { 'github/copilot.vim' },
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
		-- stylua: ignore
		keys = {
			{ "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
		},
  },
  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      { "<leader>tt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>tT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>to", "<cmd>TroubleToggle<cr>", desc = "(Trouble)" },
      { "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>tl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>tq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      { "<leader>tq", "<cmd>TroubleToggle lsp_references<cr>", desc = "LSP Ref List (Trouble)" },
    },
  },
  {
    "kylechui/nvim-surround",
  },
  {
    "gbprod/substitute.nvim",
    keys = {
      {
        "<leader>r",
        function()
          require("substitute").operator()
        end,
        noremap = true,
      },
      {
        "<leader>rs",
        function()
          require("substitute").line()
        end,
        noremap = true,
      },
      {
        "<leader>R",
        function()
          require("substitute").eol()
        end,
        noremap = true,
      },
      {
        "<leader>r",
        function()
          require("substitute").visual()
        end,
        mode = { "x" },
        noremap = true,
      },
      {
        "<leader>s",
        function()
          require("substitute.range").opeartor()
        end,
        noremap = true,
      },
      {
        "<leader>s",
        function()
          require("substitute.range").visual()
        end,
        mode = { "x" },
        noremap = true,
      },
    },
    config = function()
      require("substitute").setup({})
    end,
  },
  -- TOO SLOW FOR NOW
  -- {
  --   -- Add indentation guides even on blank lines
  --   "lukas-reineke/indent-blankline.nvim",
  --   main = "ibl",
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help indent_blankline.txt`
  --   opts = {
  --     indent = {
  --       char = "┊",
  --     },
  --   },
  -- },

  -- Automatically highlights other instances of the word under your cursor.
  -- This works with LSP, Treesitter, and regexp matching to find the other
  -- instances.
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },
}
