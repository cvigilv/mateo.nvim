local whichkey = require("which-key")

-- General setup
whichkey.setup(
	{
		plugins = {
			-- Neovim out-of-box functionality keybindings
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 15,
			},
			-- Default keybindings in Neovim
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = true,
				nav = false,
				z = true,
				g = true,
			},
		},

		operators = {
			gc = "Comments"
		},
		key_labels = {
			["<leader>"] = "SPC",
			["<space>"]  = "SPC",
			["<cr>"]     = "CR↵",
			["<tab>"]    = "TAB",
		},
		icons = {
			breadcrumb = "·",
			separator  = "::",
			group      = "+",
		},
		popup_mappings = {
			scroll_down = '<C-d>',
			scroll_up   = '<C-u>',
		},
		window = {
			border   = "none",
			position = "bottom",
			margin   = { 1, 0, 1, 0 },
			padding  = { 2, 2, 2, 2 },
			winblend = 20
		},
		layout = {
			height  = { min = 4,  max = 25 },
			width   = { min = 20, max = 50 },
			spacing = 3,
			align   = "center",
		},
		ignore_missing = true,
		show_help = true,
		triggers = { '<C-w>', 'g', 'z', ']', '[', '\\'},
		triggers_nowait = {},
		triggers_blacklist = {
			i = { "j", "k" },
			v = { "j", "k" },
		},
    }
)
-- }}}