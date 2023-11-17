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
    links.MiniStarterHeader = "Normal"
    links.MiniStarterFooter = "Normal"
    links.MiniStarterSection = "Normal"

    for k, v in pairs(links) do
      vim.cmd("hi! link " .. k .. " " .. v)
    end

    -- Reinitialize OverLength
    require("overlength").setup(vim.g.plugin_overlength)
  end,
})

-- Refresh MiniStarter after calculating `lazy.nvim` stats
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "LazyVimStarted" },
  callback = function()
    vim.cmd("ColorizerToggle")
    require("mini.starter").refresh()
  end,
})

-- Highlight out-of-bounds region
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*" },
  callback = function()
    -- Add colorcolumn to line overlength
    local cols2blur = {}

    local min_col = 96
    if vim.bo.textwidth ~= 0 then
      min_col = vim.bo.textwidth
    end
    for col = min_col, 288 do
      table.insert(cols2blur, col)
    end

    vim.opt.colorcolumn = table.concat(cols2blur, ",")
  end,
})
