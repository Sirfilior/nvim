local M = {}

-- autoformat.lua
--
-- Use your language server to automatically format your code on save.
-- Adds additional commands as well to manage the behavior
M.lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

M.lsp_autoformat = function()
	-- Switch for controlling whether you want autoformatting.
	M.format_is_enabled = true
	vim.api.nvim_create_user_command("FormatToggle", function()
		M.format_is_enabled = not M.format_is_enabled
		print("Setting autoformatting to: " .. tostring(M.format_is_enabled))
	end, {})

	M.augroup = vim.api.nvim_create_augroup("LspFormatting", {})
end

M.lsp_format_attach = function(client, bufnr)
	-- Only attach to clients that support document formatting
	if not client.server_capabilities.documentFormattingProvider then
		return
	end

	-- Create an autocmd that will run *before* we save the buffer.
	--  Run the formatting command for the LSP that has just attached.
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = M.augroup,
		buffer = bufnr,
		callback = function()
			if not M.format_is_enabled then
				return
			end
			M.lsp_formatting(bufnr)
		end,
	})
end

return M
