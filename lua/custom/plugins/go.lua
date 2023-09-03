return {
	"ray-x/go.nvim",
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		verbose = false, -- output loginf in messages

		-- true: will use go.nvim on_attach if true
		-- nil/false do nothing
		-- lsp_diag_hdlr = true, -- hook lsp diag handler
		dap_debug = true, -- set to true to enable dap
		dap_debug_keymap = false, -- set keymaps for debugger
		dap_debug_gui = true, -- set to true to enable dap gui, highly recommand
		dap_debug_vt = true, -- set to true to enable dap virtual text

		-- Disable everything for LSP
		lsp_cfg = false, -- true: apply go.nvim non-default gopls setup
		lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
		lsp_on_attach = false, -- if a on_attach function provided:  attach on_attach function to gopls
		gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile", "/var/log/gopls.log" }
	},
	config = function(_, opts)
		require("go").setup(opts)
	end,
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
