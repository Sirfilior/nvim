local M = {}

-- autoformat.lua
--
-- Use your language server to automatically format your code on save.
-- Adds additional commands as well to manage the behavior
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls" or client.name == "gopls"
		end,
		bufnr = bufnr,
	})
end

local format_is_enabled = true
vim.api.nvim_create_user_command("FormatToggle", function()
	format_is_enabled = not format_is_enabled
	print("Setting autoformatting to: " .. tostring(format_is_enabled))
end, {})

M.augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.lsp_format_attach = function(client, bufnr)
	-- Only attach to clients that support document formatting
	if client.supports_method("textDocument/formatting") then
		-- Create an autocmd that will run *before* we save the buffer.
		--  Run the formatting command for the LSP that has just attached.
		vim.api.nvim_clear_autocmds({ group = M.augroup, buffer = bufnr })

		vim.api.nvim_create_autocmd("BufWritePre", {
			group = M.augroup,
			buffer = bufnr,
			callback = function()
				if not format_is_enabled then
					return
				end
				lsp_formatting(bufnr)
			end,
		})
	end
end

return M
