for group, colors in pairs(vim.g.defaults.highlights) do
  vim.api.nvim_set_hl(0, group, colors)
end
