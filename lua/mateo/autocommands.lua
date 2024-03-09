-- Highlight yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = { "*" },
  callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 1000 }) end,
})

-- Terminal behaviour
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = { "*" },
  callback = function()
    vim.o.relativenumber = false
    vim.o.number = false
  end,
})

-- Refresh MiniStarter after calculating `lazy.nvim` stats
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "LazyVimStarted" },
  callback = function()
    if vim.bo.filetype == "starter" then
      require("mini.starter").refresh()
      vim.notify_once("Refreshed MiniStarter dashboard", 3)
    end
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
      vim.notify_once("Setting out-of-bounds region to filetype `textwidth`", 3)
      min_col = vim.bo.textwidth
    end
    for col = min_col, 288 do
      table.insert(cols2blur, col)
    end

    vim.opt.colorcolumn = table.concat(cols2blur, ",")
  end,
})

-- Update listchars
local function update_lead()
  local lcs = vim.opt_local.listchars:get()
  local tab = vim.fn.str2list(lcs.tab)
  local space = vim.fn.str2list(lcs.multispace or lcs.space)
  local lead = { tab[1] }
  for i = 1, vim.bo.tabstop - 1 do
    lead[#lead + 1] = space[i % #space + 1]
  end
  vim.opt_local.listchars:append({ leadmultispace = vim.fn.list2str(lead) })
end

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = { "listchars", "tabstop", "filetype" },
  callback = update_lead,
})
vim.api.nvim_create_autocmd("VimEnter", { callback = update_lead, once = true })
