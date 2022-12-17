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

  -- Highlighting
  use {
    'folke/tokyonight.nvim',
    config = function() require('mateo.packages.config.tokyonight') end,
  }
  use 'nyoom-engineering/oxocarbon.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function() require('mateo.packages.config.treesitter') end,
    run = { 'TSUpdate' }
  }

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Additional autocompletion
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-omni' },
      { "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },

      -- Misc
      'j-hui/fidget.nvim',
    },
    config = function() require('mateo.packages.config.lsp') end
  }

  -- Quality of Life
  use {
    'echasnovski/mini.nvim',
    config = function() require('mateo.packages.config.mini') end
  }
  use {
    'kyazdani42/nvim-tree.lua',
    config = function() require('mateo.packages.config.tree') end,
  }
  use {
    'ahmedkhalf/project.nvim',
    config = function() require('mateo.packages.config.project') end,
  }
  use {
    'unblevable/quick-scope',
    setup = function() require('mateo.packages.config.quickscope') end
  }
  use 'folke/zen-mode.nvim'

  -- LaTeX
  use {
    'lervag/vimtex',
    setup = function() require('mateo.packages.config.vimtex') end
  }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('mateo.packages.config.gitsigns') end
  }

  -- personal
  use {
    '/home/carlos/documents/git/esqueleto.nvim',
    config = function() require('mateo.packages.config.esqueleto') end
  }
  use '/home/carlos/documents/git/diferente.nvim'

  if packer_bootstrap then
    require('packer').sync()
    warn("PackerSync is running, restart after the process is done!")
  end
end)
