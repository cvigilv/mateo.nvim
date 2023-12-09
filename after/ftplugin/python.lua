-- Ruff linter fix
vim.keymap.set(
  "n",
  "<leader>df",
  ":!ruff check --fix %<CR>",
  { noremap = true, silent = true, desc = "Fix linter errors" }
)
