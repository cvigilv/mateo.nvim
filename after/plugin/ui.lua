-- colorscheme {{{
vim.opt.background = "dark"
require("tokyonight").setup({
  style = "storm",
  light_style = "day",
  transparent = false,
  terminal_colors = false,
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
    functions = { italic = false},
    variables = { italic = false},
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
    colors.border = '#24283b'
  end,

  on_highlights = function(highlights, colors) end,
})
vim.cmd[[colorscheme tokyonight-night]]
-- }}}
-- statusline {{{
local lualine = require('lualine')

-- General configuration
-- Color table
local colors = {
  bg       = '#24283b',
  fg       = '#EDF0FC',
  light_bg = '#464d72',
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
    disabled_filetypes = { "packer", "starter" },

    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Helper functions
local spacer = {
  function()
    return ' '
  end,
  color = {},
  padding = { left = 0, right = 1 },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component, keep)
  table.insert(config.sections.lualine_c, component)

  keep = keep or false
  if (keep) then
    table.insert(config.inactive_sections.lualine_c, component)
  else
    table.insert(config.inactive_sections.lualine_c, spacer)
  end
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component, keep)
  table.insert(config.sections.lualine_x, component)

  keep = keep or false
  if (keep) then
    table.insert(config.sections.lualine_x, component)
  else
    table.insert(config.inactive_sections.lualine_x, spacer)
  end
end

-- Statusline
-- Left section
-- Divider
ins_left({
  function()
    return '▊'
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
}, false)

-- Mode component
ins_left {
  function()
    return string.upper(vim.fn.mode())
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

-- Filename
ins_left({
  'filename',
  file_status = true,
  color = { fg = colors.magenta, gui = 'bold' },
}, true)

-- Git
ins_left {
  'branch',
  icon = '⎇',
  color = { fg = colors.violet },
  cond = function () return vim.fn.winwidth(0) > 70 end
}
ins_left {
  'diff',
  symbols = {
    added = '+',
    modified = '~',
    removed = '-'
  },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = function () return vim.fn.winwidth(0) > 70 end
}

-- Mid section
ins_left {
  function()
    return '%='
  end,
  color = { fg = colors.light_bg },
  cond = function() return vim.fn.winwidth(0) > 120 end
}

-- Right section
-- Diagnostics
ins_right {
  'diagnostics',
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
  cond = function () return vim.fn.winwidth(0) > 55 end
}

-- LSP
ins_right {
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
        return '■ ' .. client.name .. ' ■'
      end
    end
    return msg
  end,
  icon = '',
  color = { fg = colors.fg },
  cond = function() return vim.fn.winwidth(0) > 55 end
}

-- Cursor location
ins_right {
  '%l/%L',
  icon = 'ℓ',
  color = { fg = colors.light_bg },
  cond = function() return vim.fn.winwidth(0) > 120 end
}
ins_right {
  function()
    local _, c = unpack(vim.api.nvim_win_get_cursor(0))
    local ncols = string.len(vim.api.nvim_get_current_line())
    return string.format('%d/%d', c + 1, ncols)
  end,
  icon = '∁',
  color = { fg = colors.light_bg },
  cond = function() return vim.fn.winwidth(0) > 80 end
}

-- Divider
ins_right({
  function()
    return '▊'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}, false)

lualine.setup(config)
-- }}}