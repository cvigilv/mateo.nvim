-- Color table
local colors = {
  fg = "#EDF0FC",
  bg = "#1A1B26",
  dark_bg = "#16161E",
  light_bg = "#24283B",
}

-- Setup
require('kanagawa').setup({
  undercurl = false,
  commentStyle = { italic = true },
  dimInactive = false,
  colors = { fg = colors['fg'], bg = colors['bg'] },
  overrides = {
    VertSplit            = { bg = colors['bg'], fg = colors['dark_bg'] },
    NvimTreeVertSplit    = { bg = colors['bg'], fg = colors['dark_bg'] },
  }
})
