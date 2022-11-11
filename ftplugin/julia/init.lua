-- Tabulate behaviour
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4
vim.opt.tabstop     = 4
vim.opt.expandtab   = true

-- Miscellaneous
vim.wo.colorcolumn  = "92"

-- Custom functionality
function REPL()
  vim.api.nvim_command("vnew")
  vim.api.nvim_command("call termopen('julia')")
end

vim.api.nvim_create_user_command("REPL", "lua REPL()", {})
