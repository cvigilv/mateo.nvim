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
      }
    }
  })
end

-- Server specific configuration
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Julia {{{
-- CREATE SYS IMAGE FOR JULIA LSP {{{
-- require('lspconfig').julials.setup({
--       on_new_config  = function(new_config,new_root_dir)
--         server_path = "/home/carlos/.julia/packages/LanguageServer/0vsx2/src/"
--         cmd = {
--           "julia",
--           "--project="..server_path,
--           "--startup-file=no",
--           "--history-file=no",
--           "--trace-compile=/home/carlos/tracecompilelsp.jl",
--           "-e", [[
--             using Pkg;
--             Pkg.instantiate()
--             using LanguageServer; using SymbolServer;
--             depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
--             project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))
--             # Make sure that we only load packages from this environment specifically.
--             @info "Running language server" env=Base.load_path()[1] pwd() project_path depot_path
--             server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path);
--             server.runlinter = true;
--             run(server);
--           ]]
--       };
--       new_config.cmd = cmd
--     end,
--     on_attach = on_attach,
--     flags = lsp_flags,
--     capabilities = capabilities,
-- }) }}}

require('lspconfig').julials.setup({
  ---@diagnostic disable-next-line: unused-local
  on_new_config = function(new_config, new_root_dir)
    local server_path = "/home/carlos/.julia/packages/LanguageServer/0vsx2/src/"
    local cmd = {
      "julia",
      "--project=" .. server_path,
      "--startup-file=no",
      "--history-file=no",
      "--sysimage=/home/carlos/.config/nvim//misc/julials.so",
      "--sysimage-native-code=yes",
      "-e", [[
        using Pkg;
        Pkg.instantiate()
        using LanguageServer; using SymbolServer;
        depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
        project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))
        # Make sure that we only load packages from this environment specifically.
        @info "Running language server" env=Base.load_path()[1] pwd() project_path depot_path
        server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path);
        server.runlinter = true;
        run(server);
      ]]
    };
    new_config.cmd = cmd
  end,
  on_attach     = on_attach,
  capabilities  = capabilities,
})
-- }}}
-- Python {{{
require('lspconfig').pyright.setup(
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
require('lspconfig')['bashls'].setup(
  {
    on_attach = on_attach,
    capabilities = capabilities,
  }
)
-- }}}
-- Lua {{{
require('lspconfig').sumneko_lua.setup(
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
