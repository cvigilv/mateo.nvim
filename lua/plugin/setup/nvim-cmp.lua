local cmp = require('cmp')

-- Global setup.
cmp.setup({
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  }),
  sources = cmp.config.sources({
    { -- nvim Lua
      name = 'nvim_lua',
      max_item_count = 10,
      view = {
        entries = {
          name = 'custom',
          selection_order = 'near_cursor'
        }
      },
    },

    { -- LSP
      name = 'nvim_lsp',
      max_item_count = 25,
      view = {
        entries = {
          name = 'custom',
          selection_order = 'near_cursor'
        }
      },
    },

    { -- LSP signatures
      name = 'nvim_lsp_signature_help',
      max_item_count = 5,
      view = {
        entries = {
          name = 'custom',
          selection_order = 'near_cursor'
        }
      },
    },

    { -- Omnifunc
      name = 'omni',
      keyword_length = 3,
      max_item_count = 25,
      view = {
        entries = {
          name = 'custom',
          selection_order = 'near_cursor'
        }
      },
    },

    { -- Path
      name = 'path',
      max_item_count = 5,
      view = {
        entries = {
          name = 'custom',
          selection_order = 'near_cursor'
        }
      },
    },
  }),
})

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
})

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  sources = {
    { -- Command line
      name = 'cmdline',
      keyword_length = 5,
      max_item_count = 10,
    },
  }
})
