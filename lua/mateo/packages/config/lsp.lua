-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Mappings.
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)

	-- Diagnostics mappings.
	vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
	vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, bufopts)
end

-- Setup mason
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "sumneko_lua", "julials", "bashls", "marksman", "pyright" },
})


-- Setup LSP servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()
for _, server in pairs({ "sumneko_lua", "julials", "bashls", "marksman", "pyright" }) do
	require('lspconfig')[server].setup({
		on_attach = on_attach,
		capabilities = capabilities
	})
end


require('lspconfig')["sumneko_lua"].setup({
	settings = { Lua = {
			diagnostics = {
				globals = { 'vim', 'use' }
			}
		}
	}
})
