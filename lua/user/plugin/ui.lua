return {
  -- which-key {{{
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = {
          marks = false,
          registers = true,
          spelling = { enabled = false },
          presets = {
            operators = false,
            motions = false,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        operators = { gc = "Comments" },
        key_labels = {
          ["<space>"] = "⎵ ",
          ["<Space>"] = "⎵ ",
          ["<cr>"] = "⏎ ",
          ["<CR>"] = "⏎ ",
          ["<Tab>"] = "⭾ ",
          ["<tab>"] = "⭾ ",
          ["<M>"] = "TAB",
        },
        icons = {
          breadcrumb = "→",
          separator = "・",
          group = "+",
        },
        popup_mappings = {
          scroll_down = "<c-d>",
          scroll_up = "<c-u>",
        },
        window = {
          border = vim.g.defaults.border.normal,
          position = "bottom",
          margin = { 1, 0, 1, 0 },
          padding = { 2, 2, 2, 2 },
          winblend = 0,
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
          align = "center",
        },
        ignore_missing = false,
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
        show_help = true,
        show_keys = true,
        triggers = "auto",
        triggers_blacklist = {
          i = { "j", "k" },
          v = { "j", "k" },
        },
        disable = {
          buftypes = {},
          filetypes = { "TelescopePrompt" },
        },
      })

      -- Register some categories
      wk.register({
        [",f"] = { name = "+finder" },
        [",g"] = { name = "+git" },
        [",z"] = { name = "+zettelkasten" },
        [",l"] = { name = "+lsp" },
        [",d"] = { name = "+diagnostics" },
      })
    end,
  }, --}}}
  -- statusline {{{
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function() require("lualine").setup({}) end,
  },
  {
    "b0o/incline.nvim",
    config = function() require("incline").setup() end,
  },
  -- }}}
}
