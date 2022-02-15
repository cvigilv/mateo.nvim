vim.g.vimtex_enabled               = 1
vim.g.vimtex_complete_enabled      = 1
vim.g.vimtex_complete_close_braces = 0
vim.g.vimtex_parser_bib_backend    = 'bibtex'
vim.g.vimtex_complete_bib = {
	simple   = 1,
	menu_fmt = '@author_short (@year), "@title"',
	abbr_fmt = '@key'
}
vim.g.vimtex_view_method          = 'okular'
vim.g.vimtex_view_general_method  = 'okular'
vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
vim.g.vimtex_view_options         = '--unique file:@pdf#src:@line@tex'
vim.g.vimtex_view_automatic       = 1
vim.g.vimtex_quickfix_mode        = 0
