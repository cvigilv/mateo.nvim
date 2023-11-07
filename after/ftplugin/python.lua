-- Custom highlight groups
local query = vim.treesitter.query.parse("python", [[
  (function_definition
    body:
      (block . (expression_statement (string) @capture)))
]])


-- Ruff linter fix
vim.keymap.set(
  "n",
  "<leader>df",
  ":!ruff check --fix %<CR>",
  { noremap = true, silent = true, desc = "Fix linter errors" }
)
