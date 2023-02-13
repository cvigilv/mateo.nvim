-- treesitter {{{
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "bash",
    "julia",
    "lua",
    "markdown",
    "markdown_inline",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "markdown", "org" },
  },
  incremental_selection = { enable = true },
  indent = { enable = true },
})
-- }}}
