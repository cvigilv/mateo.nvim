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
  { silent = true, noremap = true }
)
-- }}}
-- zenmode {{{
vim.keymap.set(
  "n",
  "<leader>Z",
  ":ZenMode<CR>",
  { silent = true, noremap = true }
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
