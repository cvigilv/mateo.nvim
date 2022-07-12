-- Setup {{{
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitSignsAdd', text = '+', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete = { hl = 'GitSignsDelete', text = '-', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete = { hl = 'GitSignsDelete', text = '-', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
  },
  signcolumn = true,
  numhl = true,
  linehl = false,
  word_diff = false,
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = false,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'right_align',
    delay = 10,
    ignore_whitespace = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,
  preview_config = {
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
} -- }}}
-- Mappings {{{
local wk = require("which-key")
wk.register({
  ['<leader>'] = {
    g = {
      name = "+git",
      [']'] = { "<CMD>Gitsigns next_hunk<CR>", "Next hunk", noremap = true, silent = true },
      ['['] = { "<CMD>Gitsigns prev_hunk<CR>", "Prev hunk", noremap = true, silent = true },
      s = { "<CMD>Gitsigns stage_hunk<CR>", "Stage hunk", noremap = true, silent = true },
      S = { "<CMD>Gitsigns stage_buffer<CR>", "Stage buffer", noremap = true, silent = true },
      u = { "<CMD>Gitsigns undo_stage_hunk<CR>", "Undo staging", noremap = true, silent = true },
      r = { "<CMD>Gitsigns reset_hunk<CR>", "Reset hunk", noremap = true, silent = true },
      D = { "<CMD>Gitsigns diffthis<CR>", "Diff file", noremap = true, silent = true },
      t = {
        name = "+toggle",
        n = { "<CMD>Gitsigns toggle_numhl<CR>", "Number highlight", noremap = true, silent = true },
        s = { "<CMD>Gitsigns toggle_signs<CR>", "Signs", noremap = true, silent = true },
        l = { "<CMD>Gitsigns toggle_linehl<CR>", "Line highlight", noremap = true, silent = true },
        b = { "<CMD>Gitsigns toggle_current_line_blame<CR>", "Line blame", noremap = true, silent = true },
        d = { "<CMD>Gitsigns toggle_word_diff<CR>", "Word diff", noremap = true, silent = true },
        D = { "<CMD>Gitsigns toggle_deleted<CR>", "Deleted", noremap = true, silent = true },

      }
    }
  },
})
-- }}}
