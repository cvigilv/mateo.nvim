local M = {}

--- Get the hexadecimal value for a given highlight group and entry.
---@param hl_group string NeoVim highlight group name
---@param entry string|nil Entry name to extract. Any of "foreground", "background", "fg" or "bg".
---@return table|string|nil Hexadecimal value of highlight group entry
M.get_hl_group_hex = function(hl_group, entry)
  -- Fix invalid entry names
  if entry == "foreground" then
    entry = "fg"
  elseif entry == "background" then
    entry = "bg"
  end

  -- Get highlight group colors
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = hl_group, link = true, create = false })
  if ok then
    if entry ~= nil then
      return string.format("#%06x", hl[entry])
    else
      return vim.tbl_map(function(e) return string.format("#%06x", e) end, hl)
    end
  else
    vim.notify(
      "[ERROR] Highlight group `" .. hl_group .. "` doesn't exist!",
      vim.log.levels.ERROR
    )
    return nil
  end
end

return M
