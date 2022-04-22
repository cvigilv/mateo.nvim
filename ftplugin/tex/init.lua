-- nvim-cmp config
-- NOTE: Based in :h vimtex-completion-nvim-mcp
require('cmp').setup.buffer({
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
        buffer = "[Buffer]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = 'omni' },
    { name = 'buffer' },
  },
})

-- Prose defaults
vim.opt_local.wrap        = true
vim.opt_local.linebreak   = true
vim.opt_local.breakindent = true
vim.opt_local.spell       = true

-- Remaps
local g_keys = {
  'j',
  'k',
  '0',
  '$',
}

for _, key in pairs(g_keys) do
  vim.api.nvim_set_keymap(
    'n',
    key,
    'g'..key,
    { noremap = true, silent = true }
  )
end
