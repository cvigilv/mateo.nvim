local execute = vim.api.nvim_command
local fn = vim.fn

-- Ensure `packer.nvim` is installed on any machine
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- `packer.nvim` configuration
execute 'packadd packer.nvim'
require('packer').startup(
	{
		function()
			use 'wbthomason/packer.nvim'

			-- Completion and sources
			use { -- Completion engine
				'hrsh7th/nvim-cmp',
				config = function() require('plugin.setup.nvim-cmp') end,
				requires = {
					{'hrsh7th/cmp-nvim-lsp'},
					{'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp'},
					{'hrsh7th/cmp-nvim-lua',                after = 'nvim-cmp'},
					{'hrsh7th/cmp-buffer',                  after = 'nvim-cmp'},
					{'hrsh7th/cmp-path',                    after = 'nvim-cmp'},
					{'hrsh7th/cmp-cmdline',                 after = 'nvim-cmp'},
					{'hrsh7th/cmp-omni',                    after = 'nvim-cmp'},
				},
				event = 'InsertEnter *',
			}
			use { -- LSP servers
				'neovim/nvim-lspconfig',
				config = function() require('plugin.setup.nvim-lspconfig') end,
				requires = {
					{'williamboman/nvim-lsp-installer'},
				},
				after = 'nvim-cmp'
			}

			-- Quality-of-life
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

			-- Add-ons
			use { -- Fuzzy finder
				'nvim-telescope/telescope.nvim',
				config = function() require('plugin.setup.telescope') end,
				requires = {
					{'nvim-lua/plenary.nvim'},
					{'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
				}
			}

			-- Git
			use { -- Git signs
				'lewis6991/gitsigns.nvim',
				config = function() require('plugin.setup.gitsigns') end,
				requires = { 'nvim-lua/plenary.nvim'},
			}
			use { -- Better commit buffer
				'rhysd/committia.vim',
				config = function() require('plugin.setup.commitia') end,
			}

			-- Language specific support
			use { -- LaTeX editing in Vim
				'lervag/vimtex',
				config = function() require('plugin.setup.vimtex') end,
				ft = {'tex', 'bib'}
			}
			use { -- Julia support
				'cvigilv/julia-vim',
				config = function() require('plugin.setup.julia-vim') end,
			}
			use { -- Convert Neovim into a Rstudio-like development environment
				'jalvesaq/Nvim-R',
				config = function() require('plugin.setup.Nvim-R') end,
			}

			-- Aesthetics
			use {
				'folke/tokyonight.nvim',
				config = function() require('plugin.setup.tokyonight') end
			}

			-- `packer.nvim` bootstrapping
			if packer_bootstrap then
				require('packer').sync()
			end
		end,
		config = { max_jobs = 12 }
	}
)

-- vim:foldmethod=marker:ts=4:ft=lua
