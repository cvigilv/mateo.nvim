-- Highlight yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 1000 })
  end,
})

-- Terminal behaviour
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = { "*" },
  callback = function()
    vim.api.nvim_win_set_option(0, "relativenumber", false)
    vim.api.nvim_win_set_option(0, "number", false)
  end,
})

-- Colorscheme overrides

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  pattern = { "*" },
  callback = function()
    -- Link some highlight groups
    local links = {}
    links.EndOfBuffer = "ColorColumn"

    for k, v in pairs(links) do
      vim.cmd("hi! link " .. k .. " " .. v)
    end

    -- Reinitialize OverLength
    require("overlength").setup({
      enabled = true,
      colors = {
        ctermfg = "",
        ctermbg = "",
        foreground = "#FF0000",
        background = string.format("#%06x", vim.api.nvim_get_hl_by_name("ColorColumn", true)["background"]),
      },
      textwidth_mode = 0,
      default_overlength = 96,
      grace_length = 0,
      highlight_to_eol = true,
      disable_ft = {
        "NvimTree",
        "Telescope",
        "WhichKey",
        "MiniStarter",
        "esqueleto.ivy.selection",
        "help",
        "loclist",
        "orgagenda",
        "packer",
        "qf",
        "starter",
        "terminal",
      },
    })
  end,
})
