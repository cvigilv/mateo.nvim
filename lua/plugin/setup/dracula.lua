local execute = vim.api.nvim_command

-- Setup {{{
vim.g.dracula_colors = {
  bg = "#1A1B26",
  fg = '#EDF0FC',
}
vim.g.dracula_show_end_of_buffer = false -- show the '~' characters after the end of buffers
vim.g.dracula_transparent_bg = false -- use transparent background
vim.g.dracula_lualine_bg_color = "#44475a" -- set custom lualine background color
vim.g.dracula_italic_comment = true -- set italic comment
-- }}}

execute [[ colorscheme dracula ]]
execute [[ highligh link CursorLineNr WarningMsg ]]
