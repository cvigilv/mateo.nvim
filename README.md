# mateo.nvim 🧠

> _mateo_ (chilean slang)
> 1. A person who obtains good grades or marks regularly, studious person.
> 2. A person who without the merit of studying obtains good grades.

This is the `refactor` branch of `mateo.nvim`, which serves 2 purposes: (i) be a guide for
setting Neovim as a Julia Language development and (ii) clean my Neovim setup since I have
decided to fully invest in Julia as my main programming language.

:exclamation: This repo intends to be a **minimalistic** (less than 1000 lines of code over all the
files) and **opinionated** setup, therefore some design choices may be made (either good or bad)
under my own opinions of what's best or what I like more in this setup.

## What will this repo contain?

I need, as a minimum viable product, the following for Julia Language development:

!- Minimum Viable Product Neovim a.k.a. the starting point
!- Highlighting
!- LSP
!- Autocompletion & snippets
- REPL integration
!- Quality-of-life plugins

## Log
### Minimum Viable Product Neovim a.k.a. the starting point

First, I would like to setup Neovim to function as a my MVP, this means, configure Neovim
as a starting point to start adding and modifying its behavior depending in what my end
goal is. My Neovim MVP consists in 3 things: (i) better Neovim defaults, (ii) package 
managment and (iii) a nice colorscheme.

For my MVP Neovim defaults, please refer to commit []().

For package managment, I personally like `packer.nvim` do to its straighfoward nature for
beginners and extreme configuration for seasoned users. Here, `packer.nvim` is setup in a
way that I can download Neovim in any computer and clone my repo and have my "exact"same 
configuration. For this, we must bootstrap `packer.nvim` in order to ensure it is installed
in the machine. For this we can use the following code chunk:

~~~lua
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

  -- Here goes the rest of the plugins, empty for now...

  if packer_bootstrap then
    require('packer').sync()
    warn("PackerSync is running, restart after the process is done!")
  end
end)
~~~

Finally, we will install our first plugin! A colorscheme!

Personally, I don't mind colorschemes that much, but since we want to get the best
experience possible with the less amount of effort, a colorscheme with TreeSitter support
is a must in order to ease our way into a minimal config for Julia development.

The key point here is installing a colorscheme with TreeSitter, since we won't use the
official package for Julia support in Vim/Neovim, `JuliaEditorSupport/julia-vim`.

Here, as an example, we will install `Mofiqul/dracula.nvim`. Your `packer.nvim` should look
like this now:

~~~lua
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'Mofiqul/dracula.nvim'

  if packer_bootstrap then
    require('packer').sync()
    warn("PackerSync is running, restart after the process is done!")
  end
end)
~~~

Finally, we create a new file in the directory `mateo.nvim/lua/mateo/after/` called
`init.lua` and add the following line:

~~~lua
vim.cmd[[colorscheme dracula]]
~~~

and we also add the following in our `init.lua` file:
~~~lua
require("mateo.after")
~~~


Hurray! We have our MVP to configure Neovim as a Julia "IDE".
