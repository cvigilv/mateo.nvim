-- Tabulate behaviour
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4
vim.opt.tabstop     = 4
vim.opt.expandtab   = true

-- REPL
vim.keymap.set("n", "<leader>R", ":!tmux split-window -h 'exec julia'<CR>", { noremap=true, desc = "REPL" })
