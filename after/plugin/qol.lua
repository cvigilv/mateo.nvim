-- esqueleto {{{
require("esqueleto").setup({
  fancy_prompt = true,
  patterns = {
    -- File
    "README.md",
    "LICENSE",
    -- Filetype
    "julia",
    "sh",
    "markdown",
    "python",
    "tex",
  },
  directories = {
    "/home/carlos/.config/nvim/skeletons/",
  }
})
-- }}}
-- mini {{{
-- Disable unused modules
vim.g.minibase16_disable = true
vim.g.minibufremove_disable = true
vim.g.minicompletion_disable = true
vim.g.minicursorword_disable = true
vim.g.minifuzzy_disable = true
vim.g.miniindentscope_disable = true
vim.g.minijump_disable = true
vim.g.minimisc_disable = true
vim.g.minipairs_disable = true
vim.g.ministatusline_disable = true
vim.g.minisurround_disable = true
vim.g.minitabline_disable = true
vim.g.minitrailspace_disable = true

-- Setup ´mini.nvim´ modules
require('mini.ai').setup()
require("mini.align").setup()
require('mini.comment').setup()
require('mini.sessions').setup(
  {
    -- Setup
    autoread  = false,
    autowrite = true,
    force     = { read = false, write = true, delete = false },
    verbose   = { read = false, write = true, delete = true },
  }
)

-- mini.starter
require('mini.starter').setup(
  {
    -- Setup
    autoopen = true,
    evaluate_single = true,
    items = {
      require('mini.starter').sections.sessions(5, true),
      require('mini.starter').sections.recent_files(5, true, false),
      require('mini.starter').sections.recent_files(5, false, true),
      require('mini.starter').sections.builtin_actions(),
    },
    header = "mateo.nvim - As in \"smart guy\" (chilean slang)",
    query_updaters = [[abcdefghijklmnopqrstuvwxyz0123456789_-.]],
    content_hooks = {
      require('mini.starter').gen_hook.adding_bullet("⁞ "),
      require('mini.starter').gen_hook.aligning("center", "center")
    }
  }
)
-- }}}
-- navigator {{{
require('Navigator').setup({
  auto_save = 'nil',
  disable_on_zoom = true
})

-- Keybindings
local opts = { noremap = true, silent = true }

vim.keymap.set('n', "<C-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
vim.keymap.set('n', "<C-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
vim.keymap.set('n', "<C-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
vim.keymap.set('n', "<C-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
vim.keymap.set('n', "<C-p>", "<CMD>lua require('Navigator').previous()<CR>", opts)
-- }}}
-- quickscope {{{
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
vim.g.qs_buftype_blacklist = { 'terminal', 'nofile', 'NvimTree', 'packer', 'Starter', 'Telescope', 'telescope' }
vim.g.qs_filetype_blacklist = {}

-- Highlight groups overrides
vim.cmd [[
	highlight link QuickScopePrimary IncSearch
	highlight link QuickScopeSecondary Search
	augroup hl_QuickScope
		" Plugins
		autocmd ColorScheme * highlight link QuickScopePrimary IncSearch
		autocmd ColorScheme * highlight link QuickScopeSecondary Search
    augroup END
]]
-- }}}
-- undotree {{{
vim.keymap.set(
  "n",
  "<leader>u",
  ":UndotreeToggle<CR>",
  { silent = true, noremap = true, desc = "Undo tree"}
)
-- }}}
-- whichkey {{{
require("which-key").setup(
{
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    ["<space>"] = "⎵ ",
    ["<Space>"] = "⎵ ",
    ["<cr>"] = "⏎ ",
    ["<CR>"] = "⏎ ",
    ["<Tab>"] = "⭾ ",
    ["<tab>"] = "⭾ ",
    ["<M>"] = "TAB",
  },
  icons = {
    breadcrumb = "!", -- symbol used in the command line area that shows your active key combo
    separator = "→", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  triggers = "auto", -- automatically setup triggers
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
  -- disable the WhichKey popup for certain buf types and file types.
  -- Disabled by deafult for Telescope
  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt" },
  },
}
)
-- }}}
-- zenmode {{{
vim.keymap.set(
  "n",
  "<leader>Z",
  ":ZenMode<CR>",
  { silent = true, noremap = true, desc = "Zen Mode"}
)
-- }}}
-- misc {{{
vim.api.nvim_create_user_command(
  'Q',
  'q',
  {}
)
vim.api.nvim_create_user_command(
  'W',
  'w',
  {}
)
vim.api.nvim_create_user_command(
  'Wqa',
  'wqa',
  {}
)

-- }}}
