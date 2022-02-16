local execute = vim.api.nvim_command

-- Setup
vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
vim.g.qs_buftype_blacklist = {'terminal', 'nofile', 'NvimTree', 'packer', 'Starter', 'Telescope', 'telescope'}
vim.g.qs_filetype_blacklist = {}

-- Highlight groups overrides
execute [[
	highlight link QuickScopePrimary IncSearch
	highlight link QuickScopeSecondary Search

	augroup hl_QuickScope
		" Plugins
		autocmd ColorScheme * highlight link QuickScopePrimary IncSearch
		autocmd ColorScheme * highlight link QuickScopeSecondary Search
    augroup END
]]

