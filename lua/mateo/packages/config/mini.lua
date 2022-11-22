-- Disable unused modules
-- vim.g.miniai_disable = true
-- vim.g.minialign_disable = true
vim.g.minibase16_disable = true
vim.g.minibufremove_disable = true
-- vim.g.minicomment_disable=true
vim.g.minicompletion_disable = true
vim.g.minicursorword_disable = true
vim.g.minifuzzy_disable = true
vim.g.miniindentscope_disable = true
vim.g.minijump_disable = true
vim.g.minimisc_disable = true
vim.g.minipairs_disable = true
-- vim.g.minisessions_disable=true
-- vim.g.ministarter_disable=true
vim.g.ministatusline_disable = true
vim.g.minisurround_disable = true
vim.g.minitabline_disable = true
vim.g.minitrailspace_disable = true

-- Setup ´mini.nvim´ modules
-- mini.comment
require('mini.comment').setup()

-- mini.sessions
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

-- mini.ai
require('mini.ai').setup()

-- mini.align
require("mini.align").setup()
