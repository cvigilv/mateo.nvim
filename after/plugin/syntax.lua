-- treesitter {{{
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "bash",
    "julia",
    "lua",
    "markdown",
  },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
  additional_vim_regex_highlighting = {'org'},
})
-- }}}
