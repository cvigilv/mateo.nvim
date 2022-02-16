local execute = vim.cmd
local themes = require("telescope.themes")
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local action_layout = require("telescope.actions.layout")

local M = {}

-- Intelligent find files
-- INFO: If in Git repo, showcase only git files, else, show all files
M.project_files = function(opts)
  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then require("telescope.builtin").find_files(opts) end
end

-- Intelligent previewer
-- INFO: Don't preview binary files
local intelligent_previewer = function(filepath, bufnr, opts)
	filepath = vim.fn.expand(filepath)
	Job:new({
		command = "file",
		args = { "--mime-type", "-b", filepath },
		on_exit = function(j)
			local mime_type = vim.split(j:result()[1], "/")[1]
			if mime_type == "text" then
				previewers.buffer_previewer_maker(filepath, bufnr, opts)
			else
				vim.schedule(function()
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Binary file - Can't preview..." })
				end)
			end
		end
	}):sync()
end

-- Setup
require("telescope").setup(
	{
		defaults = {
			prompt_prefix = '? ',
			selection_prefix = '  ',
			multi_icon = '!',
			
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			path_display = { 'truncate = 3', 'smart' },
				
			layout_strategy = 'bottom_pane',
			layout_config = {
				bottom_pane = {
					height = 0.3,
					prompt_position = 'top',
					preview_width = 0.6,
				},
			},

			winblend = 10,
			border = true,
			borderchars = { " ", "│", " ", " ", " ", " ", " ", " " },
			buffer_previewer_maker = intelligent_previewer,
		},
		pickers = {
			find_files = { prompt_title = '   Find files   ', },
			git_files = { prompt_title  = '   Git files   ', },
			live_grep = { prompt_title  = '   Live Grep   ', },
			builtin = { prompt_title  = '   Pickers   ', previewer = false},
		},
	}
)

-- Highlighting
execute [[
	highlight clear TelescopeTitle
	highlight TelescopeTitle gui=bold guibg=#E0AF68 guifg=#16161E
	highlight TelescopeBorder gui=bold guifg=#2ac3de guibg=#16161E
]]

-- Load extensions
require('telescope').load_extension('fzf')

return M

-- vim:foldmethod=marker:ts=4:ft=lua
