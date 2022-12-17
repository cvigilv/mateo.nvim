require("esqueleto").setup({
  patterns = {
    -- File
    "README.md",
    "LICENSE",
    -- Filetype
    "julia",
    "sh",
    "markdown",
    "python"
  },
  directory = "/home/carlos/.config/nvim/skeletons/"
})
