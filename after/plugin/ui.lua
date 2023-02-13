-- colorscheme {{{
vim.opt.background = "dark"

-- TokyoNight
require("tokyonight").setup({
  style = "night",
  light_style = "day",
  transparent = false,
  terminal_colors = false,
  styles = {
    comments = { bold = false, italic = false },
    keywords = { bold = true, italic = false },
    functions = { bold = true, italic = false },
    variables = { bold = false, italic = false },
    sidebars = "dark",
    floats = "dark",
  },
  sidebars = {
    "qf",
    "help",
    "packer",
    "terminal",
    "NvimTree",
    "loclist",
    "starter",
    "orgagenda",
    'esqueleto.ivy.selection',
  },
  day_brightness = 0.1,
  hide_inactive_statusline = false,
  dim_inactive = false,
  lualine_bold = true,

  on_colors = function(colors)
    colors.fg = '#F5F5F5'
    colors.bg = '#121217'
    colors.bg_dark = '#09090C'
    colors.bg_float = "#09090C"
    colors.bg_popup = "#09090C"
    colors.bg_sidebar = "#09090C"
    colors.bg_statusline = "#121217"
  end,

  on_highlights = function(highlights, colors)
    -- Assign colors
    local added_fg = "#80e080"
    local added_bg = "#237f3f"
    local added2bg = "#1B492B"
    local changed_fg = "#c0b05f"
    local changed_bg = "#8a7a00"
    local changed2bg = "#4E460C"
    local deleted_fg = "#ff9095"
    local deleted_bg = "#b81a1f"
    local deleted2bg = "#65161B"
    local ignored_fg = "#2fafef"
    local ignored_bg = "#1f2f8f"
    local ignored2bg = "#192153"

    -- Assign highlights
    local _diff_added = { bg = added2bg, fg = added_fg }
    local _diff_changed = { bg = changed2bg, fg = changed_fg }
    local _diff_deleted = { bg = deleted2bg, fg = deleted_fg }
    local _diff_ignored = { bg = ignored2bg, fg = ignored_fg }

    -- Setup highlight
    highlights.DiffAdd = _diff_added
    highlights.DiffChange = _diff_changed
    highlights.DiffDelete = _diff_deleted
    highlights.GitSignsAdd = _diff_added
    highlights.GitSignsChange = _diff_changed
    highlights.GitSignsDelete = _diff_deleted
  end
})

-- GitHub
require('github-theme').setup(
  {
    colors = {},
    dark_float = true,
    sidebars = {
      "qf",
      "help",
      "packer",
      "terminal",
      "NvimTree",
      "loclist",
      "starter",
      "orgagenda"
    },
    transparent = false,
    comment_style = "italic",
    function_style = 'bold',
    keyword_style = 'bold',
  }
)

vim.cmd("colorscheme tokyonight-night")
-- }}}
-- statusline {{{
local lualine = require('lualine')

-- General configuration
-- Color table
local colors = {
  fg       = vim.api.nvim_eval('synIDattr(synIDtrans(hlID("Normal")), "fg#")'),
  bg       = vim.api.nvim_eval('synIDattr(synIDtrans(hlID("Normal")), "bg#")'),
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
  sections = nil,
  inactive_sections = nil,
}

local ignore_filetype = { 'help', 'NvimTree', 'orgagenda', 'quickfix', 'loclist', 'packer', 'starter',
  'esqueleto.ivy.selection' }
local condition = function()
  local current_filetype = vim.bo.filetype

  if vim.fn.winwidth(0) < 70 then
    return false
  end

  for _, ignored in pairs(ignore_filetype) do
    if current_filetype == ignored then
      return false
    end
  end

  return true
end

local sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = {
    { -- Git branch
      'branch',
      icon = '⎇',
      padding = { left = 2, right = 1 },
      cond = condition
    },
    { -- Git diff
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
      padding = { left = 0, right = 2 },
      cond = condition,
    },

    { -- Center section
      function() return '%=' end,
      padding = { left = 0, right = 0 },
    },

    { -- Filename
      '%r%t',
      padding = { left = 1, right = 1 },
    },
  },
  lualine_x = {
    { -- LSP diagnostics
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
      padding = { left = 2, right = 1 },
      cond = condition,
    },
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
      padding = { left = 1, right = 2 },
      cond = condition,
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
        operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = false, -- adds help for motions
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
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
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
    [",f"] = { name = "+finder" },
    [",g"] = { name = "+git" },
    [",o"] = { name = "+orgmode" },
    [",z"] = { name = "+zettelkastan" },
  }
)
-- }}}
-- misc {{{
-- Highlight any text after virtual column 90
vim.cmd("match ErrorMsg '\\%>90v.\\+'")
-- }}}
