local execute = vim.api.nvim_command
local fn = vim.fn

-- Ensure `packer.nvim` is installed on any machine {{{
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end
-- }}}
-- `packer.nvim` configuration {{{
execute 'packadd packer.nvim'
require('packer').startup(
  {
    function()
      use 'wbthomason/packer.nvim'
      -- Completion and sources {{{
      use { -- A completion engine plugin for neovim written in Lua
        'hrsh7th/nvim-cmp',
        config = function() require('plugin.setup.nvim-cmp') end,
        requires = {
          { 'hrsh7th/cmp-nvim-lsp' },
          { 'hrsh7th/cmp-vsnip' },
          { 'hrsh7th/vim-vsnip' },
          { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-omni', after = 'nvim-cmp' },
        },
      }
      use { -- LSP servers
        'neovim/nvim-lspconfig',
        config = function() require('plugin.setup.nvim-lspconfig') end,
        requires = {
          { 'williamboman/nvim-lsp-installer' },
        },
      }
      -- }}}
      -- Quality-of-life {{{
      use { -- Minimal modules
        'echasnovski/mini.nvim',
        config = function() require('plugin.setup.mini') end
      }
      use { -- Integrate ´tmux´ navigation
        'numToStr/Navigator.nvim',
        config = function() require('plugin.setup.Navigator') end
      }
      use { -- What is mapped to this key?
        'folke/which-key.nvim',
        config = function() require('plugin.setup.which-key') end,
      }
      use { -- Horizontal movement helper
        'unblevable/quick-scope',
        config = function() require('plugin.setup.quick-scope') end
      }
      use { -- Align text
        'tommcdo/vim-lion',
        config = function() require('plugin.setup.vim-lion') end,
      }
      --- }}}
      -- Add-ons {{{
      use { -- Fuzzy finder
        'nvim-telescope/telescope.nvim',
        config = function() require('plugin.setup.telescope') end,
        requires = {
          { 'nvim-lua/plenary.nvim' },
          { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        }
      }
      use { -- treesitter support
        'nvim-treesitter/nvim-treesitter',
        config = function() require('plugin.setup.nvim-treesitter') end,
        run = ':TSUpdate'
      }
      use { -- Startup timings
        'dstein64/vim-startuptime',
      }
      use { -- Speed up loading Lua modules to improve startup time
        'lewis6991/impatient.nvim',
      }
      use { -- A high-performance color highlighter for Neovim
        'norcalli/nvim-colorizer.lua',
      }
      use { -- A file explorer for Neovim written in Lua
        'kyazdani42/nvim-tree.lua',
        config = function() require('plugin.setup.nvim-tree') end,
      }
      use { -- All in one project management.
        'ahmedkhalf/project.nvim',
        config = function() require('plugin.setup.project') end,
      }
      use { -- A blazing fast and easy to configure Neovim statusline written in Lua
        'nvim-lualine/lualine.nvim',
        config = function() require('plugin.setup.lualine') end,
      }
      -- }}}
      -- Git {{{
      use { -- Super fast git decorations implemented purely in lua/teal
        'lewis6991/gitsigns.nvim',
        config = function() require('plugin.setup.gitsigns') end,
        requires = { 'nvim-lua/plenary.nvim' },
      }
      -- }}}
      -- Language specific support {{{
      use { -- LaTeX editing in Vim
        'lervag/vimtex',
      }
      use { -- Emacs org-mode
        'nvim-orgmode/orgmode',
        config = function() require('plugin.setup.orgmode') end,
      }
      -- }}}
      -- Aesthetics {{{
      use {
        'folke/tokyonight.nvim',
        config = function() require('plugin.setup.tokyonight') end
      }
      use {
        'Mofiqul/dracula.nvim',
        config = function() require('plugin.setup.dracula') end
      }
      use {
        'rebelot/kanagawa.nvim',
        config = function() require('plugin.setup.kanagawa') end
      }
      use { -- Better orgmode headers
        'akinsho/org-bullets.nvim',
        config = function() require('plugin.setup.org-bullets') end
      }
      use { -- LSP UI progress eye-candy
        'j-hui/fidget.nvim',
        config = function() require('plugin.setup.fidget') end
      }
      -- }}}
      -- `packer.nvim` bootstrapping
      if packer_bootstrap then
        require('packer').sync()
      end
    end,
    config = { max_jobs = 12 }
  }
)
-- }}}
