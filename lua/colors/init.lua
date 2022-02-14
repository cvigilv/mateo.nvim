local execute = vim.cmd

-- Default options
vim.o.termguicolors = true

-- General overrides
execute [[
	augroup colors_override
		" Plugins
		autocmd ColorScheme * highlight link QuickScopePrimary IncSearch
		autocmd ColorScheme * highlight link QuickScopeSecondary Search
    augroup END
	]]

-- Specific overrides
-- TokyoNight
vim.g.tokyonight_style = "night"
vim.g.tokyonight_sidebars = {"packer", "terminal", "NvimTree"}
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_hide_inactive_statusline = false

execute [[
	function s:respect_background()
		let l:bg='set background?'
		if l:bg == 'dark'
			highlight! Normal guifg='#EDF0FC'
		elif l:bg == 'light'
			highlight! Normal guifg='#1A1B26'
		endif
	endfunction

	augroup colors_override
		" `tokyonight`
		autocmd ColorScheme tokyonight call s:respect_background()
		autocmd ColorScheme tokyonight highlight! link CursorLineNr WarningMsg
	augroup END
	]]

-- Load colorscheme
execute "colorscheme tokyonight"
