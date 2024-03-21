local M = {}

--- Helper function to determine when to hide section in statusline
---@param width integer Window width in characters
M.hide_section = function(width) return vim.api.nvim_win_get_width(0) < width end

--- Get current mode
---@return string current mode name
M.get_mode = function()
  local mode_code = vim.api.nvim_get_mode().mode
  if vim.g.defaults.mode[mode_code] == nil then return mode_code end
  return vim.g.defaults.mode[mode_code]
end

-- UI elements {{{
M.pill_left = {
  function() return "" end,
  color = { fg = vim.g.defaults.colors.lighter_gray, bg = vim.g.defaults.colors.white },
  padding = { left = 1, right = 0 },
}
M.pill_right = {
  function() return "" end,
  color = { fg = vim.g.defaults.colors.lighter_gray, bg = vim.g.defaults.colors.white },
  padding = { left = 0, right = 1 },
}
M.separator = {
  function() return "·" end,
  color = { fg = vim.g.defaults.colors.black, bg = vim.g.defaults.colors.lighter_gray },
  padding = { left = 1, right = 1 },
}
-- }}}
-- Components {{{
M.parent_dir = {
  function()
    local content = ""

    -- If inside of git repo, show git related info
    if vim.b.gitsigns_status_dict ~= nil then
      -- Add branch information
      content = "" --"%#htmlBold#"
        .. "󰊢 "
        .. vim.fs.basename(vim.b.gitsigns_status_dict["root"])
        -- .. "%#Conceal#"
        .. " "
        .. vim.b.gitsigns_head
        .. ""

      -- Add separator
      -- content = "%#htmlBold#" .. content .. "%#lualine_a_normal#" .. " · "
      content = content .. " · "

      -- Add status
      -- NOTE: Left the highlight groups in case I want to use them in a future
      local stylesheet = {
        ["added"] = { hl = "UserDiffAdd", symbol = vim.g.defaults.signs.add },
        ["changed"] = { hl = "UserDiffChange", symbol = vim.g.defaults.signs.change },
        ["removed"] = { hl = "UserDiffDelete", symbol = vim.g.defaults.signs.delete },
        ["untracked"] = { hl = "DiagnosticWarn", symbol = "!" },
      }

      local status = {}
      if vim.b.gitsigns_status_dict["added"] ~= nil then
        for _, name in ipairs({ "added", "changed", "removed" }) do
          table.insert(status, stylesheet[name]["symbol"] .. vim.b.gitsigns_status_dict[name])
        end
      else
        local name = "untracked"
        table.insert(status, "untracked" .. stylesheet[name]["symbol"])
      end
      content = content .. table.concat(status, " ") .. " %#lualine_a_normal#"

    -- if in zk folder, show total notes and today notes
    elseif string.find(vim.fn.getcwd(), "zk") then
      content = "%#htmlBold#" .. " Zettelkasten" .. "%#lualine_a_normal#"

      -- local total_notes = io.popen("ls *.md " .. vim.fn.getcwd() .. " | wc -l")
      -- local total_today_notes = io.popen("ls *.md " .. vim.fn.getcwd() .. " | wc -l")

      -- If outside of git repo, show directory
    else
      content = "󰝰 " .. vim.fn.pathshorten(vim.fn.getcwd(), 3)
    end

    return content
  end,
  padding = 0,
  color = { bg = vim.g.defaults.colors.lighter_gray },
}

M.diagnostics = {
  "diagnostics",
  sources = { "nvim_lsp", "nvim_diagnostic" },
  symbols = vim.g.defaults.signs,
  always_visible = true,
  colored = false,
  color = { bg = vim.g.defaults.colors.lighter_gray },
  padding = { left = 0, right = 0 },
}

M.lsp_servers = {
  function()
    -- local msg = "%#htmlBold#" .. "LSP: "
    local msg = "LSP: "
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()

    -- Return nothing if no LSP server
    if next(clients) == nil then return msg .. "n/a" end

    -- Return non-"null-ls" servers
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return msg .. client.name:gsub("_", "-")
      end
    end
  end,
  color = { bg = vim.g.defaults.colors.lighter_gray },
  padding = { left = 0, right = 0 },
}
-- }}}

return M
