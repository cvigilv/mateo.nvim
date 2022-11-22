-- Boostrapping
-- NOTE: This snippet will automatically install and setup `packer.nvim`
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
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

  use {
    'folke/tokyonight.nvim',
    config = function() require('mateo.packages.config.tokyonight') end,
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function() require('mateo.packages.config.treesitter') end,
    run = { 'TSUpdate' }
  }

  if packer_bootstrap then
    require('packer').sync()
    warn("PackerSync is running, restart after the process is done!")
  end
end)
