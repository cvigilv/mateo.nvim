local diagnostics_symbols = {
  [vim.diagnostic.severity.ERROR] = "x",
  [vim.diagnostic.severity.WARN] = "!",
  [vim.diagnostic.severity.HINT] = "?",
  [vim.diagnostic.severity.INFO] = "*",
}

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "x",
      [vim.diagnostic.severity.WARN] = "!",
      [vim.diagnostic.severity.HINT] = "?",
      [vim.diagnostic.severity.INFO] = "*",
    },
  },
  virtual_text = {
    prefix = function(diagnostic) return " " .. diagnostics_symbols[diagnostic.severity] end,
    suffix = " ",
  },
})
