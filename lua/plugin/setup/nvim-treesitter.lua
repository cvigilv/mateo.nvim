require('nvim-treesitter.configs').setup {
	ensure_installed = {"python", "julia", "r", "bash", "latex"},
	sync_install = false,

	highlight = {
		enable = true,
		disable = { "latex" },
		additional_vim_regex_highlighting = false,
	},

	indent = {
		enable = true,
	},
}
