-- Configuration
vim.g.zepl_default_maps = 0
vim.g.repl_config = {
  julia = {
    cmd = "julia -t auto --banner no",
    formatter = function (lines)
      local allprocessed = {}
      for _, line in pairs(lines) do
        -- TODO: Change to dynamically detect indentetion change
        local processed = string.gsub(line, '^%s+', '')
        table.insert(allprocessed, processed)
      end
      return table.concat(allprocessed, "\n") .. "\n"
    end,
  }
}

-- Keymaps
vim.keymap.set("n", "<Leader>r", "<Plug>ReplSend_Motion", {noremap = false, silent = true})
vim.keymap.set("v", "<Leader>r", "<Plug>ReplSend_Visual", {noremap = false, silent = true})
