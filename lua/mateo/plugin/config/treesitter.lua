require('nvim-treesitter.configs').setup({
  ensure_installed = { "lua", "julia", "markdown", "bash" },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
})
