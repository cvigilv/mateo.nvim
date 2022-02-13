-- Setup
local M = {}
M.setup = function()
	vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
	vim.g.qs_buftype_blacklist = {'terminal', 'nofile', 'NvimTree', 'packer'}
	vim.g.qs_filetype_blacklist = {} --TODO: Add mini-dashboard filetype
end

return M
