return {
  -- lsp-zero {{{
  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',

      -- Additional autocompletion
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-omni',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',

      -- Misc
      'j-hui/fidget.nvim',
      'Maan2003/lsp_lines.nvim'
    },
    config = function()
      local lsp = require("lsp-zero")

      lsp.preset("recommended")

      -- LSP servers to install
      lsp.ensure_installed({
        "lua_ls",
        "julials",
        "bashls",
        "marksman",
        "pyright",
      })

      -- Better sign symbols
      lsp.set_preferences({
        set_lsp_keymaps = { omit = { '<C-k>' } },
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
          ['<C-P>'] = cmp.mapping.scroll_docs( -4),
          ['<C-N>'] = cmp.mapping.scroll_docs(4),
          ['<C-s>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-c>'] = cmp.mapping.abort(),
        },
        sources = {
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'path' },
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
      lsp.configure('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim', 'use' }
            }
          }
        }
      })
      lsp.configure('julials', {
        on_new_config = function(new_config, _)
          local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
          if require 'lspconfig'.util.path.is_file(julia) then
            new_config.cmd[1] = julia
          end
        end,
        root_dir = function(fname)
          local util = require('lspconfig.util')
          return util.root_pattern 'Project.toml' (fname) or util.find_git_ancestor(fname) or
              util.path.dirname(fname)
        end,
      })

      lsp.setup()
      vim.keymap.set("n", "<M-k>", function() vim.lsp.buf.signature_help() end, { noremap = true, silent = true })
      vim.keymap.set("n", "<C-f>", function() vim.lsp.buf.format({ async = true }) end, { noremap = true, silent = true })

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
    end,
  }, -- }}}
  -- lsp-lines {{{
  {
    'Maan2003/lsp_lines.nvim',
    config = function()
      -- Diagnostics configuration
      require("lsp_lines").setup()
      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          severity_sort = true,
          focusable = false,
          style = 'minimal',
          source = 'always',
          header = '',
          prefix = '',
        },
      })
      vim.keymap.set("n", "<Leader>d", require("lsp_lines").toggle, { desc = "Toggle diagnostics" })
    end,
  }, -- }}}
}
