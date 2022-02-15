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
			use { -- Horizontal movement helper
				'unblevable/quick-scope',
				config = function() require('plugins.setup.quick-scope') end
			}
			use { -- Default colorscheme
				'folke/tokyonight.nvim',
				config = function() require('plugins.setup.tokyonight') end
			}
			use { -- Integrate ´tmux´ navigation
				'numToStr/Navigator.nvim',
				config = function() require('plugins.setup.Navigator') end
			}
			use { -- Minimal modules
				'echasnovski/mini.nvim',
				config = function() require('plugins.setup.mini') end
			}
			use { -- Fuzzy finder
				'nvim-telescope/telescope.nvim',
				config = function() require('plugins.setup.telescope') end,
				requires = {
					{'nvim-lua/plenary.nvim'},
					{'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
				}
			}
			use { -- LaTeX editing in Vim
				'lervag/vimtex',
				config = function() require('plugins.setup.vimtex') end,
				ft = {'tex', 'bib'}
			}
			use { -- Julia support
				'cvigilv/julia-vim',
				config = function() require('plugins.setup.julia-vim') end,
			}
			use { -- LSP servers
				'neovim/nvim-lspconfig',
				requires = {
					{'williamboman/nvim-lsp-installer'},
				},
			}
			use { -- Completion engine
				'hrsh7th/nvim-cmp',
				config = function() require('plugins.setup.nvim-cmp') end,
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
			-- use { -- More "special" comments
			-- 	"folke/todo-comments.nvim",
			-- 	requires = "nvim-lua/plenary.nvim",
			-- 	config = function() require("todo-comments").setup({}) end
			-- }
			use { -- Align text
				'tommcdo/vim-lion'
			}
			use { -- Git signs
				'lewis6991/gitsigns.nvim',
				requires = 'nvim-lua/plenary.nvim',
				config = function() require('plugins.setup.gitsigns') end,
			}
			use { -- Better commit buffer
				'rhysd/committia.vim'
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
