M = {}

--- Get the hexadecimal value for a given highlight group and entry.
---@param hl_group string NeoVim highlight group name
---@param entry string Entry name to extract. Must be "foreground" or "background"
---@return string|nil Hexadecimal value of highlight group entry
M.get_hl_group_hex = function(hl_group, entry)
  local ok, hl = pcall(vim.api.nvim_get_hl_by_name, hl_group, true)
  if ok then
    return string.format("#%06x", hl[entry])
  else
    vim.notify("[ERROR] Highlight group doesn't exist!", vim.log.levels.ERROR)
    return nil
  end
end

return M
