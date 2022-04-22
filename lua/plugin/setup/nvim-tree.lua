vim.g.nvim_tree_highlight_opened_files =  1
vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_symlink_arrow = ' ◆ '
vim.g.nvim_tree_respect_buf_cwd = 1
vim.g.nvim_tree_create_in_closed_folder = 1
vim.g.nvim_tree_show_icons =  {git = 1, folders = 1,folders_arrows = 1}
vim.g.nvim_tree_icons = {
    default = "◦",
    symlink= "◇",
    git = {
      unstaged= "!",
      staged= "",
      unmerged= "&",
      renamed= ">",
      untracked= "?",
      deleted= "x",
      ignored= "◌"
      },
    folder = {
      arrow_open= "▾",
      arrow_closed= "▸",
      default= "▸",
      open= "▾",
      empty= "▹",
      empty_open= "▿",
      symlink= "◇",
      symlink_open= "◆",
      }
    }

-- Keymapping
vim.api.nvim_set_keymap(
	'n',
	'<Leader><CR>',
	':NvimTreeToggle<CR>',
	{ noremap = true, silent = true }
)

-- Config
require('nvim-tree').setup({
  disable_netrw = true,
  hijack_cursor = true,
  ignore_buffer_on_setup = false,
  open_on_setup = true,
  open_on_setup_file = false,
  open_on_tab = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {'help'},
  },
  actions = {
    open_file = {
      resize_window = true
    },
  },
  view = {
    width = 50,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
  git = {
    timeout = 500,
  },
})
