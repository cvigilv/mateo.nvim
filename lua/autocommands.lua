local execute = vim.api.nvim_command

-- Highlight yanked text
vim.api.nvim_create_autocmd(
  { "TextYankPost" },
  {
    pattern = { "*" },
    callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 1000 }) end,
  }
)

-- Highlight overrides
vim.api.nvim_create_autocmd(
  { "ColorScheme" },
  {
    pattern = { "*" },
    callback = function()
      -- Color table
      local colors = {
        fg = "#EDF0FC",
        bg = "#1A1B26",
        dark_bg = "#16161E",
        light_bg = "#24283B",
      }

      execute [[ highligh link CursorLineNr WarningMsg ]]
      execute("highlight Normal guibg = " .. colors['bg'])
      execute("highlight NormalNC guibg = " .. colors['bg'])
      -- execute("highlight VertSplit guifg = " .. colors['bg'] .. ", guibg = " .. colors['dark_bg'])
      -- execute("highlight NvimTreeVertSplit guifg = " .. colors['bg'] .. ", guibg = " .. colors['dark_bg'])
      execute("highlight NvimTreeNormal guifg = " .. colors['fg'] .. ", guibg = " .. colors['dark_bg'])
      execute("highlight NvimTreeNormalNC guifg = " .. colors['fg'] .. ", guibg = " .. colors['dark_bg'])
      -- execute("highlight NvimTreeStatusLine guibg = " .. colors['dark_bg'])
      -- execute("highlight NvimTreeStatusLineNC guibg = " .. colors['dark_bg'])
    end,
  }
)
