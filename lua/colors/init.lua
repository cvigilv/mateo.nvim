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
vim.g.tokyonight_hide_inactive_statusline = true

if vim.g.tokyonight_style == "day" then
	execute [[
		augroup colors_override
			" `tokyonight`
			autocmd ColorScheme tokyonight highlight! Normal guibg='#EDF0FC'
			autocmd ColorScheme tokyonight highlight! link CursorLineNr WarningMsg
		augroup END
		]]
else
	execute [[
		augroup colors_override
			" `tokyonight`
			autocmd ColorScheme tokyonight highlight! Normal guifg='#EDF0FC'
			autocmd ColorScheme tokyonight highlight! link CursorLineNr WarningMsg
		augroup END
		]]
end

-- Load colorscheme
execute "colorscheme tokyonight"
