-- Tabulate behaviour
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

-- REPL
vim.keymap.set("n", "<leader>R", ":Luapad<CR>", { noremap = true, desc = "REPL" })
