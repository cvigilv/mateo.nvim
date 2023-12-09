-- Highlight yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = { "*" },
  callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 1000 }) end,
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
    if vim.bo.filetype == "starter" then
      vim.cmd("ColorizerDetachFromBuffer")
      require("mini.starter").refresh()
      vim.notify_once("Refreshed MiniStarter dashboard", 3)
    end
  end,
})

-- Override from behaviour from Lazy
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "lazy" },
  callback = function() vim.cmd("ColorizerDetachFromBuffer") end,
})

-- Highlight out-of-bounds region
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*" },
  callback = function()
    -- Add colorcolumn to line overlength
    local cols2blur = {}

    local min_col = 96
    if vim.bo.textwidth ~= 0 then
      vim.notify_once("Setting out-of-bounds region to filetype `textwidth`", 3)
      min_col = vim.bo.textwidth
    end
    for col = min_col, 288 do
      table.insert(cols2blur, col)
    end

    vim.opt.colorcolumn = table.concat(cols2blur, ",")
  end,
})
