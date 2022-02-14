local execute = vim.api.nvim_command
local fn = vim.fn

-- Ensure `packer.nvim` is installed on any machine
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- `packer.nvim` configuration
execute 'packadd packer.nvim'
require('packer').startup(
	{
		function()
			use 'wbthomason/packer.nvim'
			use 'folke/tokyonight.nvim'
			use { -- Horizontal movement helper
				'unblevable/quick-scope',
				config = function() require('plugins.setup.quick-scope') end
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
		end,
		config = { max_jobs = 12 }
	}
)

-- vim:foldmethod=marker:ts=4:ft=lua
