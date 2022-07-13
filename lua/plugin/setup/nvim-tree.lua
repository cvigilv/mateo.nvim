-- Keymapping
local wk = require("which-key")
wk.register({
  ['<leader>'] = {
    ['<CR>'] = { '<CMD>NvimTreeToggle<CR>', 'File tree', noremap = true, silent = true }
  }
})

-- Config
require('nvim-tree').setup({
  create_in_closed_folder = true,
  respect_buf_cwd = true,
  disable_netrw = true,
  hijack_cursor = true,
  ignore_buffer_on_setup = false,
  open_on_setup = true,
  open_on_setup_file = false,
  open_on_tab = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = { 'help' },
  },
  actions = {
    open_file = {
      resize_window = true
    },
  },
  view = {
    width = 36,
  },
  renderer = {
    highlight_opened_files = 'icon',
    add_trailing = true,
    group_empty = true,
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        file = false,
        git = true,
        folder = false,
        folder_arrow = true
      },
      glyphs = {
        default = "◦",
        symlink = "◇",
        git = {
          unstaged = "!",
          staged = "",
          unmerged = "&",
          renamed = ">",
          untracked = "?",
          deleted = "x",
          ignored = "◌"
        },
        folder = {
          arrow_open = "▾",
          arrow_closed = "▸",
          default = "○",
          open = "●",
          empty = "▹",
          empty_open = "▿",
          symlink = "◇",
          symlink_open = "◆",
        }
      },
      symlink_arrow = " ◇ ",
    }
  },
  git = {
    timeout = 500,
  },
  filters = { custom = { "^.git$", "^.gitignore$" } }
})
