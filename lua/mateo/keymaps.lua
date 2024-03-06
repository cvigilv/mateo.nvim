-- Terminal
vim.api.nvim_set_keymap("t", "<leader><Esc>", "<C-\\><C-n>", { noremap = true })
vim.api.nvim_set_keymap("t", "<leader>gf", ":e <cfile><CR>", { noremap = true })

-- Diagnostics
vim.keymap.set(
  "n",
  "[d",
  function() vim.diagnostic.goto_prev({ wrap = false }) end,
  { desc = "Go to previous diagnostics", noremap = true }
)
vim.keymap.set(
  "n",
  "]d",
  function() vim.diagnostic.goto_next({ wrap = false }) end,
  { desc = "Go to next diagnostics", noremap = true }
)
vim.keymap.set(
  "n",
  "<leader>d",
  function() vim.diagnostic.goto_next({ wrap = false }) end,
  { desc = "Go to next diagnostics", noremap = true }
)
