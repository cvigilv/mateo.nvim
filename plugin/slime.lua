vim.g.slime_target = 'tmux'
vim.g.slime_paste_file = vim.api.nvim_eval('tempname()')
vim.g.slime_default_config = {
  socket_name = "default",
  target_pane = "{last}"
}
vim.g.slime_bracketed_paste = true
