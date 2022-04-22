local execute = vim.api.nvim_command

-- Setup {{{
vim.g.tokyonight_style = "night"
vim.g.tokyonight_terminal_colors = false
vim.g.tokyonight_italic_comments = false
vim.g.tokyonight_italic_keyworks = false
vim.g.tokyonight_italic_functions = false
vim.g.tokyonight_italic_variables = false
vim.g.tokyonight_transparent = true
vim.g.tokyonight_hide_inactive_statusline = true
vim.g.tokyonight_sidebars = {"packer", "terminal", "NvimTree"}
vim.g.tokyonight_transparent_sidebar = false
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_colors = {}
vim.g.tokyonight_day_brightness = 0.8
vim.g.tokyonight_lualine_bold = true
-- }}}

execute [[ colorscheme tokyonight ]]
execute [[ highlight Normal guifg='#EDF0FC' guibg=none ]]
execute [[ highligh link CursorLineNr WarningMsg ]]
