local lsp = require("lsp-zero")

lsp.preset("recommended")

-- LSP servers to install
lsp.ensure_installed({
  "sumneko_lua",
  "julials",
  "bashls",
  "marksman",
  "pyright",
})

-- Better sign symbols
lsp.set_preferences({
  sign_icons = {
    error = 'x',
    warn = '!',
    hint = '*',
    info = '?'
  }
})

-- nvim-cmp configuration
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

lsp.setup_nvim_cmp({
  borders = {},
  mappings = {
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ['<C-w>'] = cmp.mapping.scroll_docs(-4),
    ['<C-s>'] = cmp.mapping.scroll_docs(4),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-c>'] = cmp.mapping.abort(),
  },
  sources = {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'buffer', keyword_length = 5 },
    { name = 'omni' },
    { name = 'path' },
    { name = 'git' },
  }
})

-- language specific customization
lsp.configure('pyright', {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = false,
        useLibraryCodeForTypes = false,
        diagnosticMode = 'openFilesOnly',
      }
    }
  }
})
lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'use' }
      }
    }
  }
})

lsp.setup()

-- Add LSP initialization symbol
require('fidget').setup({
  text = {
    spinner = { "◐", "◓", "◑", "◒" },
    done = "●",
    commenced = "Started",
    completed = "Done!",
  },
  timer = {
    spinner_rate = 50,
    fidget_decay = 1000,
    task_decay = 10000,
  },
  window = {
    relative = "win",
    blend = 0,
    zindex = nil,
  },
})