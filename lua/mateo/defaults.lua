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
}
