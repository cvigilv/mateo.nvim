local borders = {
  top = "▔",
  bottom = "▁",
  right = "▕",
  left = "▏",
  top_right = "🭾",
  top_left = "🭽",
  bottom_right = "🭿",
  bottom_left = "🭼",
}

vim.g.defaults = {
  colors = { -- {{{
    black = "#1f1f1f",
    dark_gray = "#575756",
    gray = "#8f8f8d",
    light_gray = "#c6c6c3",
    white = "#fefefa",
  }, --}}}
  highlights = { -- {{{
    -- Normal
    Normal = { fg = "#1f1f1f", bg = "#fefefa" },

    -- Diagnostics
    DiagnosticOK = { fg = "#fefefa", bg = "#c6c6c3" },
    DiagnosticHint = { fg = "#1f1f1f", bg = "#2ec4b6" },
    DiagnosticWarn = { fg = "#1f1f1f", bg = "#ff9f1c" },
    DiagnosticError = { fg = "#fefefa", bg = "#7b2cbf" },

    -- Git
    DiffAdd = { fg = "#c9fdc6", bg = "#0f4f09" },
    DiffChange = { fg = "#faf3c6", bg = "#4c4109" },
    DiffDelete = { fg = "#f9c4d1", bg = "#4c0016" },

    -- Misc
    Critical = { fg = "#ec1313", bg = "#ffffff" },
  }, --}}}
  signs = { --{{{
    add = "+",
    change = "~",
    delete = "x",
    error = "x",
    warn = "!",
    info = "?",
    hint = "*",
  }, --}}}
  border = { --{{{
    named = borders,
    floating = {
      borders.top_left,
      borders.top,
      borders.top_right,
      borders.right,
      borders.bottom_right,
      borders.bottom,
      borders.bottom_left,
      borders.left,
    },
    normal = {
      borders.top_left,
      borders.top,
      borders.top_right,
      borders.right,
      borders.bottom_right,
      borders.bottom,
      borders.bottom_left,
      borders.left,
    },
    telescope = {
      ivy = {
        borders.top,
        borders.right,
        borders.bottom,
        borders.left,
        borders.top_left,
        borders.top_right,
        borders.bottom_right,
        borders.bottom_left,
      },
    },
  }, --}}}
  ignored_fts = { -- {{{
    ui = {
      "Lazy",
      "MiniStarter",
      "NvimTree",
      "Starter",
      "Telescope",
      "TelescopePrompt",
      "WhichKey",
      "esqueleto.ivy.selection",
      "help",
      "lazy",
      "loclist",
      "orgagenda",
      "packer",
      "qf",
      "quickfix",
      "starter",
      "terminal",
    },
  }, -- }}}
  mode = { --{{{
    ["n"] = "NORMAL",
    ["no"] = "O-PENDING",
    ["nov"] = "O-PENDING",
    ["noV"] = "O-PENDING",
    ["no\22"] = "O-PENDING",
    ["niI"] = "NORMAL",
    ["niR"] = "NORMAL",
    ["niV"] = "NORMAL",
    ["nt"] = "NORMAL",
    ["ntT"] = "NORMAL",
    ["v"] = "VISUAL",
    ["vs"] = "VISUAL",
    ["V"] = "V-LINE",
    ["Vs"] = "V-LINE",
    ["\22"] = "V-BLOCK",
    ["\22s"] = "V-BLOCK",
    ["s"] = "SELECT",
    ["S"] = "S-LINE",
    ["\19"] = "S-BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["ix"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rc"] = "REPLACE",
    ["Rx"] = "REPLACE",
    ["Rv"] = "V-REPLACE",
    ["Rvc"] = "V-REPLACE",
    ["Rvx"] = "V-REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "EX",
    ["ce"] = "EX",
    ["r"] = "REPLACE",
    ["rm"] = "MORE",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
  },

  --}}}
}

vim.g.plugins = {
  overlength = function()
    -- TODO: Add diagnostics generation for lines that are too long
    local utils = require("user.utils")
    local config = {
      enabled = true,
      colors = {
        ctermfg = "",
        ctermbg = "",
        fg = vim.g.defaults.colors.Critical.fg,
        bg = utils.get_hl_group_hex("ColorColumn", "background"),
      },
      textwidth_mode = 1,
      default_overlength = 96,
      grace_length = 0,
      highlight_to_eol = true,
      disable_ft = vim.g.defaults.ignored_fts.ui,
    }
    return config
  end,
}
