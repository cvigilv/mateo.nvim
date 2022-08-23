let g:vimtex_enabled               = 1
let g:vimtex_complete_enabled      = 1
let g:vimtex_complete_close_braces = 0
let g:vimtex_parser_bib_backend    = 'bibtex'
let g:vimtex_complete_bib = {'simple':1,
      \ 'menu_fmt':'@author_short (@year), "@title"',
      \ 'abbr_fmt':'@key',
      \ 'auth_len':12}
let g:vimtex_view_general_viewer  = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
let g:vimtex_view_automatic       = 1
let g:vimtex_quickfix_mode        = 0

let maplocalleader = ','
