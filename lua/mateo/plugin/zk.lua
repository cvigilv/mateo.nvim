return {
  -- obsidian {{{
  {
    "epwalsh/obsidian.nvim",
    enabled = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
    },
    ft = "markdown",
    lazy = true,
    event = "VeryLazy",
    keys = {
      "<leader>zc",
      "<leader>zf",
      "<leader>zg",
    },
    config = function()
      local zk = os.getenv("ZETTELDIR")
      require("obsidian").setup({
        dir = zk,
        notes_subdir = ".",
        completion = {
          nvim_cmp = true,
          new_notes_location = "notes_subdir",
        },
        mappings = {},
      })

      vim.keymap.set("n", "gf", function()
        if require("obsidian").util.cursor_on_markdown_link() then
          return "<cmd>ObsidianFollowLink<CR>"
        else
          return "gf"
        end
      end, { noremap = true, expr = true })
    end,
  }, -- }}}
}
