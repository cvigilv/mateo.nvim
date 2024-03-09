---@diagnostic disable: unused-local
local lush = require("lush")
local hsl = lush.hsl

-- Set color palette
local fg = "#1f1f1f"
local bg = "#f1f1f1"
local light_fg = hsl(fg).lighten(5).hex
local light_bg = hsl(bg).lighten(5).hex
local dark_fg = hsl(fg).darken(5).hex
local dark_bg = hsl(bg).darken(5).hex
local lighter_fg = hsl(fg).lighten(15).hex
local lighter_bg = hsl(bg).lighten(15).hex
local darker_fg = hsl(fg).darken(15).hex
local darker_bg = hsl(bg).darken(15).hex
local defaults = vim.g.defaults.colors

-- Override colorscheme
local all_highlights = {
  Normal = { guifg = fg, guibg = bg },
  Cursor = { guibg = light_bg },
  ColorColumn = { guibg = dark_bg },
  CodeBlock = { guibg = hsl(bg).darken(5).hex },
  Visual = { guibg = hsl(defaults.GitChange.fg).li(50).hex },
  WinBorder = { guifg = fg, guibg = bg },
  WinSeparator = { guifg = fg, guibg = bg },
  TabLine = { guifg = fg, guibg = bg },
  TabLinSel = { guifg = light_bg, guibg = fg },
  TabLineFill = { guifg = bg, guibg = fg },
  --{{{ diagnotics,
  DiagnosticOk = { gui = "reverse", guibg = bg },
  DiagnosticInfo = { gui = "reverse", guibg = bg },
  DiagnosticHint = { gui = "reverse", guibg = bg },
  DiagnosticWarn = { gui = "reverse", guibg = bg },
  DiagnosticError = { gui = "reverse", guibg = bg },
  --}}},
  -- diff {{{,
  DiffAdd = { guibg = defaults.GitAdd.bg, guifg = defaults.GitAdd.fg },
  DiffChange = { guibg = defaults.GitChange.bg, guifg = defaults.GitChange.fg },
  DiffDelete = { guibg = defaults.GitDelete.bg, guifg = defaults.GitDelete.fg },
  GitSignsAdd = { guibg = defaults.GitAdd.bg, guifg = defaults.GitAdd.fg },
  GitSignsChange = { guibg = defaults.GitChange.bg, guifg = defaults.GitChange.fg },
  GitSignsDelete = { guibg = defaults.GitDelete.bg, guifg = defaults.GitDelete.fg },
  -- }}},
  -- telescope.nvim {{{,
  TelescopeNormal = { guifg = fg, guibg = dark_bg },
  TelescopePreviewNormal = { guifg = fg, guibg = dark_bg },
  TelescopeResultsNormal = { guifg = fg, guibg = dark_bg },
  TelescopeTitle = { guifg = dark_bg, guibg = fg },
  --}}},
}

for k, v in pairs(all_highlights) do
  local hlstr = {}
  for g, hex in pairs(v) do
    table.insert(hlstr, g .. "=" .. hex)
  end
  vim.cmd("hi " .. k .. " " .. table.concat(hlstr, " "))
end

-- Highlight group links
local all_links = {}
all_links.EndOfBuffer = "ColorColumn"
all_links.Folded = "@keyword.function"
-- mini.nvim {{{
all_links.MiniStarterHeader = "Normal"
all_links.MiniStarterFooter = "Normal"
all_links.MiniStarterSection = "Normal"
--}}}
-- telescope {{{
all_highlights.TelescopeSelection = "Visual"
--}}}

for k, v in pairs(all_links) do
  vim.cmd("hi! link " .. k .. " " .. v)
end

-- Run Overlength
local _, overlength = pcall(require, "overlength")
if overlength ~= nil then overlength.setup(vim.g.plugins.overlength()) end
