-- Custom highlight groups
local query = vim.treesitter.query.parse("python", [[
  (function_definition
    body:
      (block . (expression_statement (string) @capture)))
]])


