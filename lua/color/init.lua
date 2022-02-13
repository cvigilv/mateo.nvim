local execute = vim.cmd

-- Default options
vim.o.termguicolors = true

-- Overrides autocommand
execute [[
	augroup colors_override
		" `tokyonight`
		autocmd ColorScheme tokyonight highlight! Normal guifg='#EDF0FC'
		autocmd ColorScheme tokyonight highlight! link CursorLineNr WarningMsg
		" General
		autocmd ColorScheme * highlight Comment cterm=italic gui=italic
		" Plugins
		autocmd ColorScheme * highlight link QuickScopePrimary IncSearch
		autocmd ColorScheme * highlight link QuickScopeSecondary Search
    augroup END
	]]

-- Load colorscheme
execute "colorscheme tokyonight"
