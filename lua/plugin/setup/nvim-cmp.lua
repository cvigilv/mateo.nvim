local cmp = require('cmp')

local view = {
  entries = {
    name = 'custom',
    selection_order = 'near_cursor'
  }
}

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
    documentation = true,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-w>'] = cmp.mapping.scroll_docs(-4),
    ['<C-s>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { -- Neovim Lua
      name = 'nvim_lua',
      max_item_count = 10,
      view = view,
    },

    { -- Snips
      name = 'vsnip',
      max_item_count = 5,
      view = view,
    },

    { -- LSP
      name = 'nvim_lsp',
      keyword_length = 1,
      max_item_count = 25,
      view = view,
    },

    { -- LSP signatures
      name = 'nvim_lsp_signature_help',
      max_item_count = 5,
      view = view,
    },

    { -- Omnifunc
      name = 'omni',
      keyword_length = 3,
      max_item_count = 25,
      view = view,
    },

    { -- Path
      name = 'path',
      max_item_count = 5,
      view = view,
    },
  }),
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { -- Buffer
      name = 'buffer',
      view = view

    }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { -- Path
      name = 'path',
      view = view
    },

    { -- Command-line
      name = 'cmdline',
      view = view
    }
  })
})
