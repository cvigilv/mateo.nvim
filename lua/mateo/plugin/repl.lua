return {
  -- nvim-luapad {{{
  {
    'rafcamlet/nvim-luapad',
  }, -- }}}
  -- vim-slime {{{
  {
    'jpalardy/vim-slime',
    lazy = true,
    event = "VeryLazy",
    cmd = {
      "SlimeConfig",
      "SlimeSend",
      "SlimeSend0",
      "SlimeSend1",
      "SlimeSendCurrentLine",
    },
    init = function()
      vim.g.slime_target = 'tmux'
      vim.g.slime_paste_file = vim.api.nvim_eval('tempname()')
      vim.g.slime_default_config = {
        socket_name = "default",
        target_pane = "{right-of}"
      }
      vim.g.slime_bracketed_paste = true
    end
  }, -- }}}
}
