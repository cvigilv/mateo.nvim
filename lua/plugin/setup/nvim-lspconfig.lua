local wk = require("which-key")

-- Diagnostics
wk.register({
  ['<leader>'] = {
    d = {
      name = "+diagnostics",
      f = { vim.diagnostic.open_float, "Extended diagnostic", noremap = true, silent = true },
      l = { vim.diagnostic.setloclist, "Open locations-list", noremap = true, silent = true },
      [']'] = { vim.diagnostic.goto_next, "Go to next diagnostic", noremap = true, silent = true },
      ['['] = { vim.diagnostic.goto_prev, "Go to previous diagnostic", noremap = true, silent = true },
    }
  },
})

-- Use an `on_attach` function to only map the following keys
-- after the language server attaches to the current buffer
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
  wk.register({
    ['<leader>'] = {
      l = {
        name = "+lsp",
        D = { vim.lsp.buf.declaration, "Go to declaration", noremap = true, silent = true, buffer = bufnr },
        d = { vim.lsp.buf.definition, "Go to definition", noremap = true, silent = true, buffer = bufnr },
        i = { vim.lsp.buf.implementation, "Go to implementarion", noremap = true, silent = true, buffer = bufnr },
        t = { vim.lsp.buf.type_definition, "Go to type definition", noremap = true, silent = true, buffer = bufnr },
        K = { vim.lsp.buf.hover, "Hover", noremap = true, silent = true, buffer = bufnr },
        r = { vim.lsp.buf.rename, "Rename", noremap = true, silent = true, buffer = bufnr },
        a = { vim.lsp.buf.code_action, "Code action", noremap = true, silent = true, buffer = bufnr },
        R = { vim.lsp.buf.references, "References", noremap = true, silent = true, buffer = bufnr },
        f = { vim.lsp.buf.formatting, "Format", noremap = true, silent = true, buffer = bufnr },
        s = { vim.lsp.buf.document_symbol, "Symbols", noremap = true, silent = true, buffer = bufnr },
      }
    }
  })
end

-- Server specific configuration
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Julia {{{
require 'lspconfig'.julials.setup{
    on_new_config = function(new_config, _)
        local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
        if require'lspconfig'.util.path.is_file(julia) then
            new_config.cmd[1] = julia
        end
    end,
    on_attach = on_attach,
    capabilities = capabilities,
}
-- }}}
-- Python {{{
require 'lspconfig'.pyright.setup(
  {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = false,
          useLibraryCodeForTypes = false,
          diagnosticMode = 'openFilesOnly',
        }
      }
    }
  }
)
-- }}}
-- Bash {{{
require 'lspconfig'.bashls.setup(
  {
    on_attach = on_attach,
    capabilities = capabilities,
  }
)
-- }}}
-- Lua {{{
require 'lspconfig'.sumneko_lua.setup(
  {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim', 'use' }
        }
      }
    }
  }
) -- }}}
-- Markdown {{{
require 'lspconfig'.marksman.setup(
  {
    on_attach = on_attach,
    capabilities = capabilities,
  }
)
-- }}}
