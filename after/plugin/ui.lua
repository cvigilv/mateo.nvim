-- Add colorcolumn to line overlength
local cols2blur = {}
for col = 96, 288 do
	table.insert(cols2blur, col)
end

vim.opt.colorcolumn = table.concat(cols2blur, ",")
