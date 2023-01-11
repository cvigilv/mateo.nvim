-- Boostrapping
-- NOTE: This snippet will automatically install and setup `packer.nvim`
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- Package management
-- NOTE: For more information about `packer` and it's use, please refer
-- to `https://github.com/wbthomason/packer.nvim`
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- UI
  use 'folke/tokyonight.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'nyoom-engineering/oxocarbon.nvim'
  use 'nvim-lualine/lualine.nvim'

  --Syntax
  use 'nvim-treesitter/nvim-treesitter'
  use 'lervag/vimtex'

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
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
      { 'petertriho/cmp-git', requires = 'nvim-lua/plenary.nvim' },

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',

      -- Misc
      'j-hui/fidget.nvim',
    }
  }

  -- Quality of Life
  use 'nvim-lua/plenary.nvim'
  use 'lewis6991/impatient.nvim'
  use 'mbbill/undotree'
  use 'echasnovski/mini.nvim'
  use 'unblevable/quick-scope'
  use 'folke/zen-mode.nvim'
  use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'numToStr/Navigator.nvim'

  -- Navigation
  use 'kyazdani42/nvim-tree.lua'
  use 'ahmedkhalf/project.nvim'

  -- Git
  use 'lewis6991/gitsigns.nvim'

  -- Personal
  use '/home/carlos/git/esqueleto.nvim'
  use '/home/carlos/git/diferente.nvim'

  if packer_bootstrap then
    require('packer').sync()
    warn('PackerSync is running, restart after the process is done!')
  end
end)
