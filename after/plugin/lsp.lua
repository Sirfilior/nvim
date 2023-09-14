if vim.g.vscode then
	return
end
-- [[ Configure LSP ]]
local null_ls = require("null-ls")
local icons = require("config.icons")
local autoformat = require("config.autoformat")
local lsp_custom = require("custom.lsp")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettierd,
		-- null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.djlint,
		null_ls.builtins.diagnostics.ruff,
		require("typescript.extensions.null-ls.code-actions"),
	},
	on_attach = function(client, bufnr)
		autoformat.lsp_format_attach(client, bufnr)
	end,
})

--  This function gets run when an LSP connects to a particular buffer.
-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
	rust_analyzer = {},
	svelte = {},
	html = {},
	jsonls = {},
	prismals = {},
	astro = {},
	eslint = {},
	intelephense = {},
	pyright = {},
	ruff_lsp = {},
	-- tailwindcss = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
	gopls = {
		settings = {
			gopls = {
				codelenses = { test = true },
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
		},

		flags = {
			debounce_text_changes = 200,
		},
	},
	volar = {},
	typst_lsp = {
		exportPdf = "never",
	},
}

local attachOverrides = {
	ruff_lsp = function(client, bufnr)
		-- Disable hover in favor of Pyright
		client.server_capabilities.hoverProvider = false

		lsp_custom.on_attach(client, bufnr)
	end,
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = attachOverrides[server_name] or lsp_custom.on_attach,
			settings = servers[server_name],
		})
	end,
})

-- diagnostics
for name, icon in pairs(icons.diagnostics) do
	name = "DiagnosticSign" .. name
	vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end
