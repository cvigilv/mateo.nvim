local execute = vim.api.nvim_command

-- Setup
vim.g.tokyonight_style = "night"
vim.g.tokyonight_sidebars = {"packer", "terminal", "NvimTree"}
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_hide_inactive_statusline = false

-- More contrast for ´Normal´ group and respect the ´background´ variable
execute [[
	function s:TokyoNight_bg()
		let l:bg='set background?'
		if l:bg == 'dark'
			highlight! Normal guifg='#EDF0FC'
		elif l:bg == 'light'
			highlight! Normal guifg='#1A1B26'
		endif
	endfunction

	augroup hl_TokyoNight
		" `tokyonight`
		autocmd ColorScheme tokyonight call s:TokyoNight_bg()
		autocmd ColorScheme tokyonight highligh link CursorLineNr WarningMsg
	augroup END
]]

execute [[ colorscheme tokyonight ]]
