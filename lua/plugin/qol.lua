return {
  -- auto-hlsearch {{{
  {
    "asiryk/auto-hlsearch.nvim",
    event = "VeryLazy",
    tag = "1.1.0",
    config = true
  },
  -- }}}
  -- esqueleto {{{
  {
    dir = '/home/carlos/git/esqueleto.nvim',
    ft = {
      "text",
      "julia",
      "sh",
      "markdown",
      "python",
      "tex",
    },
    config = function()
      require("esqueleto").setup({
        autouse = false,
        prompt = 'ivy',
        patterns = {
          -- File
          "README.md",
          "LICENSE",
          -- Filetype
          "julia",
          "sh",
          "markdown",
          "python",
          "tex",
        },
        directories = {
          "/home/carlos/.config/nvim/skeletons/",
        }
      })
    end
  },
  -- }}}
  -- mini TODO: change to single release modules {{{
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Disable unused modules
      vim.g.minibase16_disable = true
      vim.g.minibufremove_disable = true
      vim.g.minicompletion_disable = true
      vim.g.minicursorword_disable = true
      vim.g.minifuzzy_disable = true
      vim.g.miniindentscope_disable = true
      vim.g.minijump_disable = true
      vim.g.minimisc_disable = true
      vim.g.minipairs_disable = true
      vim.g.ministatusline_disable = true
      vim.g.minisurround_disable = true
      vim.g.minitabline_disable = true
      vim.g.minitrailspace_disable = true

      -- Setup ´mini.nvim´ modules
      require('mini.ai').setup()
      require("mini.align").setup()
      require('mini.comment').setup()
      require('mini.sessions').setup(
        {
          -- Setup
          autoread  = false,
          autowrite = true,
          force     = { read = false, write = true, delete = false },
          verbose   = { read = false, write = true, delete = true },
        }
      )

      require('mini.starter').setup(
        {
          -- Setup
          autoopen = true,
          evaluate_single = true,
          items = {
            require('mini.starter').sections.sessions(5, true),
            require('mini.starter').sections.builtin_actions(),
            require('mini.starter').sections.telescope(),
          },
          header = "mateo.nvim - As in \"smart guy\" (chilean slang)",
          query_updaters = [[abcdefghijklmnopqrstuvwxyz0123456789_-.]],
          content_hooks = {
            require('mini.starter').gen_hook.adding_bullet("⁞ "),
            require('mini.starter').gen_hook.aligning("center", "center")
          }
        }
      )
    end
  },
  -- }}}
  -- quickscope {{{
  {
    'unblevable/quick-scope',
    event = "VeryLazy",
    keys = { 'f', 'F', 't', 'T' },
    init = function()
      vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
      vim.g.qs_buftype_blacklist = {
        'terminal',
        'nofile',
        'NvimTree',
        'packer',
        'Starter',
        'Telescope',
        'telescope'
      }
      vim.g.qs_filetype_blacklist = {}

      -- Highlight groups overrides
      vim.cmd([[
        highlight link QuickScopePrimary IncSearch
        highlight link QuickScopeSecondary Search
        augroup hl_QuickScope
          " Plugins
          autocmd ColorScheme * highlight link QuickScopePrimary IncSearch
          autocmd ColorScheme * highlight link QuickScopeSecondary Search
        augroup END
      ]])
    end
  },
  -- }}}
  -- todo-comments {{{
  {
    'folke/todo-comments.nvim',
    config = function()
      require("todo-comments").setup(
        {
          signs = false,
        }
      )
    end
  },
  -- }}}
  -- undotree {{{
  {
    'mbbill/undotree',
    event = "VeryLazy",
    cmd = 'UndotreeToggle',
    keys = '<leader>u',
    config = function()
      vim.keymap.set(
        'n',
        '<leader>u',
        ':UndotreeToggle<CR>',
        { silent = true, noremap = true, desc = 'Undo tree' }
      )
    end
  },
  -- }}}
  -- zenmode {{{
  {
    'folke/zen-mode.nvim',
    event = "VeryLazy",
    cmd = 'ZenMode',
    keys = '<leader>Z',
    config = function()
      vim.keymap.set(
        'n',
        '<leader>Z',
        ':ZenMode<CR>',
        { silent = true, noremap = true, desc = 'Zen Mode' }
      )
    end
  },
  -- }}}
  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
  }
}
