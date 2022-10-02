-- Disable unused modules {{{
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
-- }}}

-- Setup ´mini.nvim´ modules
-- mini.comment {{{
require('mini.comment').setup(
  {
    -- Module mappings.
    mappings = {
      comment = 'gc', -- Toggle comment for both Normal and Visual modes
      comment_line = 'gcc', -- Toggle comment on current line
      textobject = 'gc', -- Define 'comment' textobject (like `dgc` - delete whole comment block)
    },
  }
)
--- }}}
-- mini.sessions {{{
require('mini.sessions').setup(
  {
    -- Setup
    autoread  = false,
    autowrite = true,
    -- directory = '../../../sessions',
    -- file      = 'Session.vim',
    force     = { read = false, write = true, delete = false },
    verbose   = { read = true, write = true, delete = true },
  }
)
-- }}}
-- mini.starter {{{
local telescope_items = {
  { name = "Files", action = [[ lua require("plugin.setup.telescope").project_files() ]], section = 'Telescope' },
  { name = "Grep", action = [[ lua require("telescope.builtin").live_grep() ]], section = 'Telescope' },
  { name = "Pickers", action = [[ lua require("telescope.builtin").builtin() ]], section = 'Telescope' },
}

local starter = require('mini.starter')
starter.setup(
  {
    -- Setup
    autoopen = true,
    evaluate_single = true,
    items = {
      starter.sections.sessions(5, true),
      starter.sections.recent_files(10, false, true),
      starter.sections.recent_files(5, true, false),
      telescope_items,
      starter.sections.builtin_actions(),
    },
    header = "mateo.nvim - As in \"smart guy\" (chilean slang)",
    query_updaters = [[abcdefghijklmnopqrstuvwxyz0123456789_-.]],
    content_hooks = {
      starter.gen_hook.adding_bullet("⁞ "),
      starter.gen_hook.aligning("center", "center")
    }
  }
)
-- }}}
-- mini.ai {{{
require('mini.ai').setup(
-- No need to copy this inside `setup()`. Will be used automatically.
  {
    -- Table with textobject id as fields, textobject specification as values.
    -- Also use this to disable builtin textobjects. See |MiniAi.config|.
    custom_textobjects = nil,

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Main textobject prefixes
      around = 'a',
      inside = 'i',

      -- Next/last variants
      around_next = 'an',
      inside_next = 'in',
      around_last = 'al',
      inside_last = 'il',

      -- Move cursor to corresponding edge of `a` textobject
      goto_left = 'g[',
      goto_right = 'g]',
    },

    -- Number of lines within which textobject is searched
    n_lines = 50,

    -- How to search for object (first inside current line, then inside
    -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
    -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
    search_method = 'cover_or_next',
  }
)
-- }}}
-- mini.align {{{
require("mini.align").setup()
-- }}}
