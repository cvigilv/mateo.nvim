local execute = vim.api.nvim_command

vim.g.commitia_open_only_vim_starting = 0
vim.g.commitia_status_window_min_height = 20

execute [[
  " let g:commitia_open_only_vim_starting = 0
  " let g:commitia_status_window_min_height = 20
  let g:committia_hooks = {}
	function! g:committia_hooks.edit_open(info)
		" Scroll the diff window from insert mode
		" Map <C-n> and <C-p>
		imap <buffer><C-f> <Plug>(committia-scroll-diff-down)
		imap <buffer><C-b> <Plug>(committia-scroll-diff-up)
	endfunction
]]
