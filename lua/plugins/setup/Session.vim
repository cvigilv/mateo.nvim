let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/documents/git/mateo.nvim/lua/plugins/setup
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd ~/documents/git/mateo.nvim/init.lua
$argadd ~/documents/git/mateo.nvim/lua
$argadd ~/documents/git/mateo.nvim/plugin
$argadd ~/documents/git/mateo.nvim/README.md
$argadd ~/documents/git/mateo.nvim/sessions
set stal=2
tabnew
tabnew
tabrewind
edit ~/documents/git/mateo.nvim/init.lua
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 27) / 55)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext
edit ~/documents/git/mateo.nvim/lua/plugins/init.lua
argglobal
if bufexists("~/documents/git/mateo.nvim/lua/plugins/init.lua") | buffer ~/documents/git/mateo.nvim/lua/plugins/init.lua | else | edit ~/documents/git/mateo.nvim/lua/plugins/init.lua | endif
if &buftype ==# 'terminal'
  silent file ~/documents/git/mateo.nvim/lua/plugins/init.lua
endif
balt ~/documents/git/mateo.nvim/init.lua
setlocal fdm=marker
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1 - ((0 * winheight(0) + 27) / 55)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext
edit ~/documents/git/mateo.nvim/lua/plugins/setup/mini.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 27 + 29) / 58)
exe '2resize ' . ((&lines * 27 + 29) / 58)
argglobal
if bufexists("~/documents/git/mateo.nvim/lua/plugins/setup/mini.lua") | buffer ~/documents/git/mateo.nvim/lua/plugins/setup/mini.lua | else | edit ~/documents/git/mateo.nvim/lua/plugins/setup/mini.lua | endif
if &buftype ==# 'terminal'
  silent file ~/documents/git/mateo.nvim/lua/plugins/setup/mini.lua
endif
balt ~/documents/git/mateo.nvim/lua/plugins/init.lua
setlocal fdm=marker
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 35 - ((34 * winheight(0) + 13) / 27)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 35
normal! 01|
wincmd w
argglobal
if bufexists("~/.local/share/nvim/site/pack/packer/start/mini.nvim/doc/mini.txt") | buffer ~/.local/share/nvim/site/pack/packer/start/mini.nvim/doc/mini.txt | else | edit ~/.local/share/nvim/site/pack/packer/start/mini.nvim/doc/mini.txt | endif
if &buftype ==# 'terminal'
  silent file ~/.local/share/nvim/site/pack/packer/start/mini.nvim/doc/mini.txt
endif
balt /usr/share/nvim/runtime/doc/options.txt
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
silent! normal! zE
let &fdl = &fdl
let s:l = 2473 - ((7 * winheight(0) + 13) / 27)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 2473
normal! 067|
wincmd w
exe '1resize ' . ((&lines * 27 + 29) / 58)
exe '2resize ' . ((&lines * 27 + 29) / 58)
tabnext 3
set stal=1
badd +1 ~/documents/git/mateo.nvim/init.lua
badd +1 ~/documents/git/mateo.nvim/lua
badd +1 ~/documents/git/mateo.nvim/plugin
badd +1 ~/documents/git/mateo.nvim/README.md
badd +1 ~/documents/git/mateo.nvim/sessions
badd +1 ~/documents/git/mateo.nvim/lua/plugins/init.lua
badd +1 ~/documents/git/mateo.nvim/lua/plugins/setup/mini.lua
badd +5083 /usr/share/nvim/runtime/doc/options.txt
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=ifncTFtOolx
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
