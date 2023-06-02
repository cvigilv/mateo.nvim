return {
  -- colorscheme {{{
  {
    "folke/tokyonight.nvim",
    dependencies = "rktjmp/lush.nvim",
    config = function()
      local lush = require("lush")
      local hsl = lush.hsl

      require("tokyonight").setup({
        style = "night",
        light_style = "day",
        transparent = false,
        terminal_colors = false,
        styles = {
          comments = { bold = false, italic = false },
          keywords = { bold = true, italic = false },
          functions = { bold = true, italic = false },
          variables = { bold = false, italic = false },
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = {
          "qf",
          "help",
          "packer",
          "terminal",
          "NvimTree",
          "loclist",
          "starter",
          "orgagenda",
          "esqueleto.ivy.selection",
        },
        day_brightness = 0.1,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = true,
        on_colors = function(colors)
          colors.fg = "#F5F5F5"
          colors.bg = "#09090C"
          colors.bg_dark = "#020207"
          colors.bg_float = "#020207"
          colors.bg_popup = "#020207"
          colors.bg_sidebar = "#020207"
          colors.bg_statusline = "#09090C"
        end,
        on_highlights = function(highlights, colors)
          -- Assign colors
          local fg = hsl("#F5F5F5")
          local bg = hsl("#09090C")
          local added_fg = "#80e080"
          local added_bg = "#1B492B"
          local changed_fg = "#c0b05f"
          local changed_bg = "#4E460C"
          local deleted_fg = "#ff9095"
          local deleted_bg = "#65161B"

          -- Assign highlights
          local _diff_added = { bg = added_bg, fg = added_fg }
          local _diff_changed = { bg = changed_bg, fg = changed_fg }
          local _diff_deleted = { bg = deleted_bg, fg = deleted_fg }

          -- Setup highlight
          highlights.ColorColumn = { fg = fg.hex, bg = bg.li(20).hex }
          highlights.CursorLineNr = { fg = fg.li(10).hex }
          highlights.CursorLine = { bg = bg.li(5).sa(15).hex }
          highlights.DiffAdd = _diff_added
          highlights.DiffChange = _diff_changed
          highlights.DiffDelete = _diff_deleted
          highlights.GitSignsAdd = _diff_added
          highlights.GitSignsChange = _diff_changed
          highlights.GitSignsDelete = _diff_deleted
          highlights.WinBorder = { fg = fg.hex, bg = bg.hex }
          highlights.WinSeparator = { fg = fg.hex, bg = bg.hex }
        end,
      })
      vim.cmd("colorscheme tokyonight-night")
    end,
  }, -- }}}
  -- statusline {{{
  {
    "nvim-lualine/lualine.nvim",
    dependencies = "rktjmp/lush.nvim",
    config = function()
      local lualine = require("lualine")
      local lush = require("lush")
      local hsl = lush.hsluv

      -- General configuration
      local colors = {
        fg = hsl("#F5F5F5"),
        bg = hsl("#09090C"),
        yellow = "#ECBE7B",
        cyan = "#008080",
        darkblue = "#081633",
        green = "#98BE65",
        orange = "#FF8800",
        violet = "#A9A1E1",
        magenta = "#C678DD",
        blue = "#51AFEF",
        red = "#EC5F67",
      }

      local ignore_filetype = {
        "help",
        "NvimTree",
        "orgagenda",
        "quickfix",
        "loclist",
        "packer",
        "starter",
        "esqueleto.ivy.selection",
      }

      local condition = function()
        local current_filetype = vim.bo.filetype

        -- Window width
        if vim.fn.winwidth(0) < 70 then
          return false
        end

        -- File type
        for _, ignored in pairs(ignore_filetype) do
          if current_filetype == ignored then
            return false
          end
        end

        return true
      end

      -- Config
      local config = {
        options = {
          -- Disable lualine in certain filetypes
          disabled_filetypes = ignore_filetype,

          -- Disable sections and component separators
          component_separators = "",
          section_separators = "",

          -- Configure theme
          theme = {
            normal = { c = { fg = colors.fg.hex, bg = colors.bg.sa(10).li(5).hex } },
            inactive = { c = { fg = colors.fg.hex, bg = colors.bg.hex } },
          },
        },

        -- Initialize empty sections
        sections = nil,
        inactive_sections = nil,
      }

      -- Setup lualine sections
      local sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            -- Filename
            "filename",
            padding = { left = 2, right = 1 },
          },
        },
        lualine_x = {
          {
            -- Git branch
            "branch",
            icon = "⎇",
            padding = { left = 0, right = 0 },
            color = { fg = colors.fg.darken(20).hex },
            cond = condition,
          },
          {
            -- Git diff
            "diff",
            symbols = {
              added = "+",
              modified = "~",
              removed = "-",
            },
            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.orange },
              removed = { fg = colors.red },
            },
            padding = { left = 1, right = 0 },
            cond = condition,
          },
          {
            function()
              return "∘"
            end,
            padding = { left = 1, right = 1 },
            cond = condition,
          },
          {
            -- LSP attached
            function()
              local msg = "⚙ "
              local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
              local clients = vim.lsp.get_active_clients()

              -- Return nothing if no LSP server
              if next(clients) == nil then
                return ""
              end

              -- return non-"null-ls" servers
              for _, client in ipairs(clients) do
                if client.name ~= "null-ls" then
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    msg = msg .. client.name
                  end
                end
              end
              if vim.tbl_count(clients) > 0 then
                msg = msg .. "+" .. vim.tbl_count(clients) - 1
              end
              return msg
            end,
            color = { fg = colors.fg.darken(20).hex },
            padding = { left = 0, right = 0 },
            cond = condition,
          },
          {
            -- LSP diagnostics
            "diagnostics",
            sources = { "nvim_lsp", "nvim_diagnostic" },
            symbols = { error = "x", warn = "!", info = "?", hint = "*" },
            diagnostics_color = {
              color_error = { fg = colors.red },
              color_warn = { fg = colors.yellow },
              color_info = { fg = colors.cyan },
              color_hint = { fg = colors.cyan },
            },
            always_visible = true,
            update_in_insert = true,
            padding = { left = 1, right = 2 },
            cond = condition,
          },
        },
        lualine_y = {},
        lualine_z = {},
      }

      config.sections = sections
      config.inactive_sections = sections

      lualine.setup(config)
    end,
  },
  -- }}}
  -- which-key {{{
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = {
          marks = true, -- shows a list of your marks on ' and `
          registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true,    -- misc bindings to work with windows
            z = true,      -- bindings for folds, spelling and others prefixed with z
            g = true,      -- bindings for prefixed with g
          },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
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
          breadcrumb = "!", -- symbol used in the command line area that shows your active key combo
          separator = "→", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        },
        popup_mappings = {
          scroll_down = "<c-d>", -- binding to scroll down inside the popup
          scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        window = {
          border = "none",     -- none, single, double, shadow
          position = "bottom", -- bottom, top
          margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
          padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
          winblend = 0,
        },
        layout = {
          height = { min = 4, max = 25 },                                         -- min and max height of the columns
          width = { min = 20, max = 50 },                                         -- min and max width of the columns
          spacing = 3,                                                            -- spacing between columns
          align = "center",                                                       -- align columns left, center or right
        },
        ignore_missing = false,                                                   -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = true,                                                         -- show help message on the command line when the popup is visible
        show_keys = true,                                                         -- show the currently pressed key and its label as a message in the command line
        triggers = "auto",                                                        -- automatically setup triggers
        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          -- this is mostly relevant for key maps that start with a native binding
          -- most people should not need to change this
          i = { "j", "k" },
          v = { "j", "k" },
        },
        -- disable the WhichKey popup for certain buf types and file types.
        -- Disabled by deafult for Telescope
        disable = {
          buftypes = {},
          filetypes = { "TelescopePrompt" },
        },
      })

      wk.register({
        [",f"] = { name = "+finder" },
        [",g"] = { name = "+git" },
        [",o"] = { name = "+orgmode" },
        [",z"] = { name = "+zettelkastan" },
      })
    end,
  }, -- }}}
}
