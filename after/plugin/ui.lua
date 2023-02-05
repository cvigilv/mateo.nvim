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

-- GitHub
require('github-theme').setup(
  {
    colors = {},
    dark_float = true,
    sidebars = { "qf", "help", "packer", "terminal", "NvimTree" },
    transparent = false,
    comment_style = "italic",
    function_style = 'bold',
    keyword_style = 'bold',
  }
)
vim.cmd [[colorscheme github_dark_default]]
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
-- whichkey {{{
local wk = require('which-key')
wk.setup(
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
wk.register(
  {
    [",f"] = {name = "+finder"},
    [",g"] = {name = "+git"},
    [",o"] = {name = "+orgmode"},
    [",z"] = {name = "+zettelkastan"},
  }
)
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
