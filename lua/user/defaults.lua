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
    GitAdd = { fg = "#80e080", bg = "#1B492B" },
    GitChange = { fg = "#c0b05f", bg = "#4E460C" },
    GitDelete = { fg = "#ff9095", bg = "#65161B" },
    Critical = { fg = "#ff0000" },
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
