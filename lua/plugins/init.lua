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

			-- `packer.nvim` bootstrapping
			if packer_bootstrap then
				require('packer').sync()
			end
		end,
		config = { max_jobs = 12 }
	}
)

-- vim:foldmethod=marker:ts=4:ft=lua
