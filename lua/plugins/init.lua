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
		use 'unblevable/quick-scope'
	end,

	config = {
		max_jobs = 12,
	}
})
