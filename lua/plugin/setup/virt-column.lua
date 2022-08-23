local execute = vim.cmd

require("virt-column").setup({
  char = "⁚",
})

execute [[ highlight VirtColumn guibg=#1A1B26 guifg=#464D72 ]]
