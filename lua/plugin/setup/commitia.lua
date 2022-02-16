local execute = vim.api.nvim_command

execute [[
	let g:commitia_open_only_vim_starting = 0
	let g:commitia_status_window_min_height = 20

	let g:committia_hooks = {}
	function! g:committia_hooks.edit_open(info)
		" Scroll the diff window from insert mode
		" Map <C-n> and <C-p>
		imap <buffer><C-n> <Plug>(committia-scroll-diff-down)
		imap <buffer><C-p> <Plug>(committia-scroll-diff-up)
	endfunction
]]
