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
    config = function()
      local statusline = require("user.helpers.statusline")
      local colors = vim.g.defaults.colors

      -- Setup theme
      local active = { bg = colors.white, fg = colors.black }
      local inactive = { bg = colors.white, fg = colors.dark_gray }

      local theme = {
        normal = { a = active, b = active, c = active },
        insert = { a = active, b = active, c = active },
        visual = { a = active, b = active, c = active },
        replace = { a = active, b = active, c = active },
        command = { a = active, b = active, c = active },
        inactive = { a = inactive, b = inactive, c = inactive },
      }

      -- Setup lualine
      require("lualine").setup({
        options = {
          theme = theme,
          component_separators = "",
          section_separators = "",
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = { "help" },
          refresh = {
            statusline = 1000,
            tabline = 5000,
            winbar = 5000,
          },
        },
        sections = {
          lualine_a = {
            statusline.pill_left,
            statusline.parent_dir,
            statusline.pill_right,
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            statusline.pill_left,
            statusline.diagnostics,
            statusline.separator,
            statusline.lsp_servers,
            statusline.pill_right,
          },
        },
        inactive_sections = {
          lualine_a = {
            statusline.pill_left,
            statusline.parent_dir,
            statusline.pill_right,
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            statusline.pill_left,
            statusline.diagnostics,
            statusline.separator,
            statusline.lsp_servers,
            statusline.pill_right,
          },
        },
        extensions = { "oil", "quickfix" },
      })

      local function set_option_safe(name, setter)
        for _, scope in ipairs({ "local", "global" }) do
          setter(vim["opt_" .. scope][name])
        end
      end

      set_option_safe("fillchars", function(opt) opt:append({ stl = "─", stlnc = "─" }) end)
    end,
  },
  {
    "b0o/incline.nvim",
    dependencies = "rktjmp/lush.nvim",
    config = function()
      --- Setup incline filename statusbar
      ---@return nil
      local setup_incline = function()
        -- Get current colorscheme `Normal` highlight group
        local statusline = require("user.helpers.statusline")
        local fg = vim.g.defaults.colors["black"]
        local bg = vim.g.defaults.colors["lighter_gray"]

        -- Setup `incline`
        local incline = require("incline")
        incline.setup({
          window = {
            padding = 0,
            placement = {
              horizontal = "center",
              vertical = "bottom",
            },
          },
          render = function(props)
            local bufname = vim.api.nvim_buf_get_name(props.buf)
            local res = bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or bufname
            if vim.bo[props.buf].modified then res = "* " .. res end
            return {
              "",
              {
                statusline.get_mode(),
                " · ",
                res,
                guifg = fg,
                guibg = bg,
                gui = "bold",
              },
              "",
              guifg = bg,
              guibg = vim.g.defaults.colors.white,
            }
          end,
          hide = { cursorline = true },
        })
      end

      -- Launch statusline
      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        pattern = { "*" },
        callback = setup_incline,
      })
    end,
  },
  -- }}}
}
