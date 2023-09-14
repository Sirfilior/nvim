return {
	"jose-elias-alvarez/typescript.nvim",
	opts = function()
		return {
			disable_commands = false, -- prevent the plugin from creating Vim commands
			debug = false, -- enable debug logging for commands
			go_to_source_definition = {
				fallback = true, -- fall back to standard LSP definition on failure
			},
			server = { -- pass options to lspconfig's setup method
				on_attach = function(client, bufnr)
					require("custom.lsp").on_attach(client, bufnr)
					vim.lsp.buf.inlay_hint(bufnr, true)
				end,
				settings = {
					javascript = {
						inlayHints = {
							includeInlayEnumMemberValueHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
					typescript = {
						inlayHints = {
							includeInlayEnumMemberValueHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
				},
			},
		}
	end,
	config = function(_, opts)
		require("typescript").setup(opts)
	end,
	event = { "CmdlineEnter" },
	ft = {
		"typescript",
		"javascript",
		"vue",
		"svelte",
		"typescriptreact",
		"javascriptreact",
		"javascript.jsx",
		"typescript.tsx",
	},
}
