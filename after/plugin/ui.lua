-- colorscheme {{{
vim.opt.background = "dark"
require("tokyonight").setup({
  style = "night",
  light_style = "day",
  transparent = false,
  terminal_colors = false,
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
    functions = { italic = false },
    variables = { italic = false },
    sidebars = "dark",
    floats = "dark",
  },
  sidebars = { "qf", "help", "packer", "terminal", "NvimTree" },
  day_brightness = 0.05,
  hide_inactive_statusline = false,
  dim_inactive = false,
  lualine_bold = true,

  on_colors = function(colors)
    colors.fg = '#EDF0FC'
    colors.border = '#121317'
  end,
})
vim.cmd [[colorscheme tokyonight]]
-- }}}
-- statusline {{{
local lualine = require('lualine')

-- General configuration
-- Color table
local colors = {
  bg       = '#1a1b26',
  fg       = '#f1f1f1',
  light_bg = '#464d72',
  light_fg = '#3c3c3c',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

-- Config
local config = {
  options = {
    -- Disable lualine in certain filetypes
    disabled_filetypes = { "packer", "starter", "help", "NvimTree" },

    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.light_fg, bg = colors.bg } },
    },
  },
  sections = nil,
  inactive_sections = nil,
}

local sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = {
    { -- Git branch
      'branch',
      icon = '⎇',
      padding = { left = 5, right = 2 },
      cond = function() return vim.fn.winwidth(0) > 70 end
    },

    { -- Center section
      function() return '%=' end,
      padding = { left = 0, right = 0 },
    },

    { -- Filename
      '%r%t',
      padding = { left = 1, right = 1 },
    },

    { -- LSP diagnostics
      'diagnostics',
      icon = '∘',
      sources = { 'nvim_diagnostic' },
      symbols = {
        error = 'x',
        warn = '!',
        info = '?',
        hint = '*'
      },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
        color_hint = { fg = colors.cyan },
      },
      padding = { left = 0, right = 1 },
    },


  },
  lualine_x = {
    { -- LSP attached
      function()
        local msg = ''
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = '⌕',
      padding = { left = 2, right = 5 },
      cond = function() return vim.fn.winwidth(0) > 55 end
    },
  },
  lualine_y = {},
  lualine_z = {},
}

config.sections = sections
config.inactive_sections = sections

lualine.setup(config)
-- }}}

-- Insert modules
for _, tbl in ipairs(left) do
  insert_left(tbl, false)
end

insert_left({ function() return '%=' end,
  color = { fg = colors.light_bg },
})

for _, tbl in ipairs(middle) do
  insert_left(tbl, false)
end

for _, tbl in ipairs(right) do
  insert_right(tbl, false)
end

lualine.setup(config)
-- }}f
