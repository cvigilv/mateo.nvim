-- Highlight yanked text
vim.api.nvim_create_autocmd(
  { "TextYankPost" },
  {
    pattern = { "*" },
    callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 1000 }) end,
  }
)

-- Terminal behaviour
vim.api.nvim_create_autocmd(
  { "TermOpen" },
  {
    pattern = { "*" },
    callback = function()
      vim.api.nvim_win_set_option(0, "relativenumber", false)
      vim.api.nvim_win_set_option(0, "number", false)

    end,
  }
)
