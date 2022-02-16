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
				max_item_count = 25,
			},

			{ -- LSP signatures
				name = 'nvim_lsp_signature_help',
				max_item_count = 5,
			},

			{ -- Omnifunc
				name = 'omni',
				priority = 10,
				keyword_length = 3,
				max_item_count = 25
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
	}
)
