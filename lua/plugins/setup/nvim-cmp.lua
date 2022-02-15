local cmp = require('cmp')

local function check_backspace()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end

local feedkeys = vim.fn.feedkeys
local replace_termcodes = vim.api.nvim_replace_termcodes
local backspace_keys = replace_termcodes('<tab>', true, true, true)

-- Global setup.
cmp.setup(
	{
		-- Completion menu rules
		completion = { completeopt = 'menuone,preview' },

		-- Snippet integration
		snippet = {},

		-- Items formatting
		formatting = {},

		-- Key mappings
		mapping = {
			-- ´nvim-cmp´ specific mappings
			['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
			['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
			['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
			['<C-e>'] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			['<CR>'] = cmp.mapping.confirm({ select = true }),
			['<C-y>'] = cmp.mapping.confirm({ select = true }),

			-- Tab completion mappings
			['<Tab>'] = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif check_backspace() then
					feedkeys(backspace_keys, 'n')
				else
					fallback()
				end
			end,
			['<S-Tab>'] = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end,
		},

		-- Autocompletion sources
		sources = {
			{ -- nvim Lua
				name = 'nvim_lua',
				max_item_count = 10,
			},

			{ -- LSP
				name = 'nvim_lsp',
				max_item_count = 20,
			},

			{ -- LSP signatures
				name = 'nvim_lsp_signature_help',
				max_item_count = 3,
			},

			{ -- Path
				name = 'path',
				max_item_count = 5,
			},

			{ -- Buffer
				name = 'buffer',
				keyword_length = 5,
				max_item_count = 10,
				option = {
					keyword_length = 3,
				},
			},
		},

		experimental = {
			ghost_text = true
		}
	}
)

-- `/` cmdline setup.
cmp.setup.cmdline('/', {
		sources = {
			{ -- Buffer
				name = 'buffer',
				keyword_length = 5,
				max_item_count = 10,
				option = {
					keyword_length = 3,
				},
			},
		},
	}
)

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
	sources = {
		{ -- Command line
			name = 'cmdline',
			keyword_length = 5,
			max_item_count = 10
		},
	}
})

-- `tex` setup.
cmp.setup.filetype({'tex', 'bib'}, {
		sources = {
			{ -- Omnifunc
				name = 'omni',
				priority = 10,
				keyword_length = 3,
				max_item_count = 10
			},
		}
	}
)

-- LSP settings
local lspconfig = require('lspconfig')
local on_attach = function(_, bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
	vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers with default setups
local servers = { 'clangd', 'julials', 'bashls', 'cmake'}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

-- Python
lspconfig['pyright'].setup(
	{
		on_attach = on_attach,
		capabilities = capabilities,
		-- settings = {
		-- 	python = {
		-- 		venvPath = "/home/carlos/documents/git/environments",
		-- 		venv = { "dataScience" },
		-- 	}
		-- }
	}
)

-- Lua
lspconfig['sumneko_lua'].setup(
	{
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { 'vim' }
				}
			}
		}
	}
)

vim.cmd("LspStart")
