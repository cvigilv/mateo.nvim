-- nvim-tree {{{
require('nvim-tree').setup({
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

vim.api.nvim_set_keymap(
  "n",
  "<leader><CR>",
  "<CMD>NvimTreeToggle<CR>",
  {
    noremap = true,
    silent = true
  }
)
-- }}}
-- project {{{
require("project_nvim").setup({
  silent_chdir = true,
})
-- }}}
-- telescope {{{
local execute = vim.cmd
local previewers = require("telescope.previewers")
local Job = require("plenary.job")

local M = {}
-- Intelligent find files
M.project_files = function(opts)
  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then require("telescope.builtin").find_files(opts) end
end
-- Intelligent previewer
local intelligent_previewer = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Binary file - Can't preview..." })
        end)
      end
    end
  }):sync()
end

-- Setup
require("telescope").setup(
  {
    defaults = {
      prompt_prefix = '? ',
      selection_prefix = '  ',
      multi_icon = '!',

      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      path_display = { 'truncate = 3', 'smart' },

      layout_strategy = 'bottom_pane',
      layout_config = {
        bottom_pane = {
          height = 0.3,
          prompt_position = 'top',
          preview_width = 0.6,
        },
      },

      winblend = 0,
      border = true,
      borderchars = { " ", "│", " ", " ", " ", " ", " ", " " },
      buffer_previewer_maker = intelligent_previewer,
    },
    pickers = {
      find_files = { prompt_title = '   Find files   ', },
      git_files = { prompt_title = '   Git files   ', },
      live_grep = { prompt_title = '   Live Grep   ', },
      builtin = { prompt_title = '   Pickers   ', previewer = false },
    },
  }
)
-- Highlighting
execute [[
	highlight clear TelescopeTitle
	highlight TelescopeTitle gui=bold guibg=#E0AF68 guifg=#16161E
	highlight TelescopeBorder gui=bold guifg=#2ac3de guibg=#16161E
]]

-- Keymaps
vim.keymap.set("n", ",ff", "<CMD>Telescope find_files<CR>", {silent = true, noremap = true, desc = "Find files"})
vim.keymap.set("n", ",fp", M.project_files, {silent = true, noremap = true, desc = "Project files"})
vim.keymap.set("n", ",fg", "<CMD>Telescope live_grep<CR>", {silent = true, noremap = true, desc = "Live grep"})
vim.keymap.set("n", ",fb", "<CMD>Telescope buffers<CR>", {silent = true, noremap = true, desc = "Buffers"})
vim.keymap.set("n", ",fd", "<CMD>Telescope diagnostics<CR>", {silent = true, noremap = true, desc = "LSP diagnostics"})
