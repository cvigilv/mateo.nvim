local execute = vim.cmd

-- Disable unused modules {{{
vim.g.minibase16_disable=true
vim.g.minibufremove_disable=true
vim.g.minicompletion_disable=true
vim.g.minijump_disable=true
vim.g.minimisc_disable=true
vim.g.minipairs_disable=true
vim.g.ministatusline_disable=true
vim.g.minitabline_disable=true
vim.g.minitrailspace_disable=true
vim.g.minifuzzy_disable=true
vim.g.miniindentscope_disable=true
-- vim.g.minicomment_disable=true
-- vim.g.minicursorword_disable=true
-- vim.g.minisessions_disable=true
-- vim.g.ministarter_disable=true
-- vim.g.minisurround_disable=true
-- }}}

-- Setup ´mini.nvim´ modules
-- mini.comment {{{
require('mini.comment').setup(
	{
		-- Module mappings.
		mappings = {
			comment = 'gc',        -- Toggle comment for both Normal and Visual modes
			comment_line = 'gcc',  -- Toggle comment on current line
			textobject = 'gc',     -- Define 'comment' textobject (like `dgc` - delete whole comment block)
		},
	}
)
--- }}}
-- mini.cursorword {{{
require('mini.cursorword').setup(
	{
		-- Delay (in ms) between when cursor moved and when highlighting appeared
		delay = 50,
	}
)

execute [[
	highlight MiniCursorWord gui=italic,bold cterm=italic,bold
	highlight MiniCursorWordCurrent gui=italic,bold cterm=italic,bold
]]

execute [[
	augroup mini.cursorwork.behaviour
		" Toggle when entering/leaving Insert mode
		autocmd InsertEnter * lua vim.b.minicursorword_disable = not vim.b.minicursorword_disable
		autocmd InsertLeave * lua vim.b.minicursorword_disable = not vim.b.minicursorword_disable
		" Disable module in non-relevant buffers
		autocmd TermOpen * lua vim.b.minicursorword_disable = true
		autocmd FileType help lua vim.b.minicursorword_disable = true
   augroup END
]]
-- }}}
-- mini.indentscope {{{
-- require('mini.indentscope').setup(
-- 	{
-- 		-- Drawing settings.
-- 		draw = {
-- 			delay = 10,
-- 			animation = require('mini.indentscope').gen_animation('linear')
-- 		},
-- 		-- Module mappings.
-- 		mappings = {
-- 			object_scope = '',
-- 			object_scope_with_border = '',
-- 			goto_top = '',
-- 			goto_bottom = '',
-- 		},
-- 		-- Options which control computation of scope.
-- 		options = {
-- 			border = 'top',
-- 			indent_at_cursor = true,
-- 			try_as_border = true,
-- 		},
-- 		-- Character to use as indicator.
-- 		symbol = '│'
-- 	}
-- )
--
-- execute [[
-- 	highlight clear MiniIndentscopePrefix
-- 	highlight link MiniIndentscopeSymbol WarningMsg
-- ]]
--
-- execute [[
-- 	augroup mini.indentscope.behaviour
-- 		" Disable module in non relevant buffer types
-- 		autocmd FileType help lua vim.b.miniindentscope_disable = true
-- 		autocmd TermOpen * lua vim.b.miniindentscope_disable = true
--    augroup END
-- ]]
-- }}}
-- mini.sessions {{{
require('mini.sessions').setup(
	{
		-- Setup
		autoread  = false,
		autowrite = true,
		-- directory = '../../../sessions',
		-- file      = 'Session.vim',
		force     = { read = false, write = true, delete = false },
		verbose   = { read = true,  write = true, delete = true  },
	}
)
-- }}}
-- mini.starter {{{
local telescope_items = {
	 { name = "Files",   action = [[ lua require("plugin.setup.telescope").project_files() ]], section = 'Telescope'},
	 { name = "Grep",    action = [[ lua require("telescope.builtin").live_grep() ]], section = 'Telescope'},
	 { name = "Pickers",    action = [[ lua require("telescope.builtin").builtin() ]], section = 'Telescope'},
 }

local starter = require('mini.starter')
starter.setup(
	{
		-- Setup
		autoopen = true,
		evaluate_single = false,
		items = {
			starter.sections.sessions(5, true),
			starter.sections.recent_files(10, false, false),
			starter.sections.recent_files(5, true, true),
			telescope_items,
			starter.sections.builtin_actions(),
		},
		header = "mateo.nvim - As in \"intelligent\" (chilean slang)",
		query_updaters = [[abcdefghijklmnopqrstuvwxyz0123456789_-.]],
	}
)
-- }}}
-- mini.surround {{{
require('mini.surround').setup(
{
	-- Number of lines within which surrounding is searched
	n_lines = 20,

	-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
	highlight_duration = 500,

	-- Pattern to match function name in 'function call' surrounding
	-- By default it is a string of letters, '_' or '.'
	funname_pattern = '[%w_%.]+',

	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		add = 'sa',            -- Add surrounding
		delete = 'sd',         -- Delete surrounding
		find = 'sf',           -- Find surrounding (to the right)
		find_left = 'sF',      -- Find surrounding (to the left)
		highlight = 'sh',      -- Highlight surrounding
		replace = 'sr',        -- Replace surrounding
		update_n_lines = 'sn', -- Update `n_lines`
	},
}
)

execute [[
	highlight link MiniSurround IncSearch
]]
-- }}}

-- vim:foldmethod=marker:ts=4:ft=lua
