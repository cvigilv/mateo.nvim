return {
  -- colorscheme {{{
  { -- tokyonight {{{
    "folke/tokyonight.nvim",
    dependencies = "rktjmp/lush.nvim",
    priority = 10000,
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

          -- Assign highlights
          local _diff_added = vim.g.defaults.colors.GitAdd
          local _diff_changed = vim.g.defaults.colors.GitChange
          local _diff_deleted = vim.g.defaults.colors.GitDelete

          -- Setup highlight
          highlights.ColorColumn = { fg = fg.hex, bg = bg.li(5).sa(15).hex }
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
      -- vim.cmd("colorscheme tokyonight-night")
    end,
  }, -- }}}
  {  -- deepwhite {{{
    "Verf/deepwhite.nvim",
    priority = 10000,
    dependencies = "rktjmp/lush.nvim",
    config = function()
      require("deepwhite").setup({
        low_blue_light = true,
      })

      vim.api.nvim_create_autocmd({ "ColorScheme" }, {
        pattern = { "deepwhite" },
        callback = function()
          -- Highlight group override
          local lush = require("lush")
          local hsl = lush.hsl

          local ok, hl = pcall(vim.api.nvim_get_hl_by_name, "Normal", true)
          if ok then
            local fg = hsl(string.format("#%06x", hl["foreground"])).hex
            local bg = hsl(string.format("#%06x", hl["background"])).hex

            local added_fg = vim.g.defaults.colors.GitAdd.bg
            local changed_fg = vim.g.defaults.colors.GitChange.bg
            local deleted_fg = vim.g.defaults.colors.GitDelete.bg
            local added_bg = hsl(vim.g.defaults.colors.GitAdd.fg).li(50).sa(25).hex
            local changed_bg = hsl(vim.g.defaults.colors.GitChange.fg).li(50).sa(25).hex
            local deleted_bg = hsl(vim.g.defaults.colors.GitDelete.fg).li(50).sa(25).hex

            -- Assign highlights
            local _diff_added = { guibg = added_bg, guifg = added_fg }
            local _diff_changed = { guibg = changed_bg, guifg = changed_fg }
            local _diff_deleted = { guibg = deleted_bg, guifg = deleted_fg }

            -- Setup highlight
            local highlights = {}
            highlights.DiffAdd = _diff_added
            highlights.DiffChange = _diff_changed
            highlights.DiffDelete = _diff_deleted
            highlights.GitSignsAdd = _diff_added
            highlights.GitSignsChange = _diff_changed
            highlights.GitSignsDelete = _diff_deleted
            highlights.WinBorder = { guifg = fg, guibg = bg }
            highlights.WinSeparator = { guifg = fg, guibg = bg }

            for k, v in pairs(highlights) do
              local hlstr = {}
              for g, hex in pairs(v) do
                table.insert(hlstr, g .. "=" .. hex)
              end
              hlstr = "hi! " .. k .. " " .. table.concat(hlstr, " ")
              vim.cmd(hlstr)
            end

            local links = {}
            links.EndOfBuffer = "ColorColumn"
            links.Folded = "@keyword.function"
            links.MiniStarterHeader = "Normal"
           links.MiniStarterFooter = "Normal"
            links.MiniStarterSection = "Normal"

            for k, v in pairs(links) do
              vim.cmd("hi! link " .. k .. " " .. v)
            end
          end
        end,
      })
      vim.cmd("colorscheme deepwhite")
    end,
  }, --}}}
  {  -- oxocarbon {{{
    "nyoom-engineering/oxocarbon.nvim",
  }, -- }}}
  -- }}}
  -- statusline {{{
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "rktjmp/lush.nvim", "lewis6991/gitsigns.nvim" },
    config = function()
      local lualine = require("lualine")
      local lush = require("lush")
      local hsl = lush.hsluv

      local setup_statusline = function()
        -- General configuration
        local ok, hl = pcall(vim.api.nvim_get_hl_by_name, "Normal", true)
        local fg = hsl("#F5F5F5")
        local bg = hsl("#09090C")
        if ok and vim.o.background == "light" then
          fg = hsl(string.format("#%06x", hl["foreground"]))
          bg = hsl(string.format("#%06x", hl["background"]))
        end

        local colors = {
          fg = fg,
          bg = bg,
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
              normal = { c = { fg = colors.fg.hex, bg = colors.bg.darken(5).hex } },
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
            { -- Filename    }{{{
              "filename",
              color = {
                fg=bg.hex,
                bg=fg.hex
              },
              padding = { left = 2, right = 2 },
            },   --}}}
            {  -- Root        }{{{
              function()
                if vim.b.gitsigns_status_dict ~= nil then
                  return "repo: " .. vim.fs.basename(vim.b.gitsigns_status_dict["root"])
                else
                  return vim.fn.pathshorten(vim.fn.getcwd(), 2)
                end
              end,
              icon = "",
              color = { fg = colors.fg.darken(30).hex },
              padding = { left = 0, right = 0 },
            },
          },    --}}}
          lualine_x = {
            { -- Git branch  }{{{
              function()
                if vim.b.gitsigns_status_dict ~= nil then
                  return vim.fs.basename(vim.b.gitsigns_status_dict["head"])
                else
                  return "n/a"
                end
              end,
              icon = "⎇ ",
              padding = { left = 1, right = 1 },
              color = { fg = colors.fg.darken(20).hex },
              cond = condition,
            },   --}}}
            {    -- Git added   } {{{
              function()
                return "+" .. vim.b.gitsigns_status_dict["added"]
              end,
              padding = { left = 1, right = 1 },
              color = {
                fg = vim.g.defaults.colors.GitAdd.bg,
                bg = vim.g.defaults.colors.GitAdd.fg
              },
              cond = condition,
            },   --}}}
            {    -- Git changed } {{{
              function()
                return "~" .. vim.b.gitsigns_status_dict["changed"]
              end,
              padding = { left = 1, right = 1 },
              color = {
                fg = vim.g.defaults.colors.GitChange.bg,
                bg = vim.g.defaults.colors.GitChange.fg
              },
              cond = condition,
            },   --}}}
            {    -- Git removed } {{{
              function()
                if vim.b.gitsigns_status_dict["removed"] then
                  return "-" .. vim.b.gitsigns_status_dict["removed"]
                else
                  return "(not tracked)"
                end
              end,
              padding = { left = 1, right = 1 },
              color = {
                fg = vim.g.defaults.colors.GitDelete.bg,
                bg = vim.g.defaults.colors.GitDelete.fg
              },
              cond = condition,
            },   --}}}
            {    -- Spacer      }{{{
              function()
                return " "
              end,
              padding = { left = 1, right = 1 },
              cond = condition,
            },   --}}}
            {    -- LSP         }{{{
              function()
                local msg = "⚙ "
                local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                local clients = vim.lsp.get_active_clients()

                -- Return nothing if no LSP server
                if next(clients) == nil then
                  return msg .. "n/a"
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
              padding = { left = 0, right = 1 },
              cond = condition,
            },   --}}}
            {    -- Diagnostics }{{{
              "diagnostics",
              sources = { "nvim_lsp", "nvim_diagnostic" },
              symbols = { error = "x", warn = "!", info = "?", hint = "*" },
              diagnostics_color = {
                error = { fg = colors.bg.hex, bg = colors.red },
                warn  = { fg = colors.bg.hex, bg = colors.yellow },
                info  = { fg = colors.bg.hex, bg = colors.cyan },
                hint  = { fg = colors.bg.hex, bg = colors.green },
              },
              always_visible = true,
              update_in_insert = true,
              padding = { left = 1, right = 1 },
              cond = function()
                if condition() then
                  return condition()
                elseif vim.tbl_count(vim.lsp.get_active_clients()) > 0 then
                  return false
                end
              end,
            },   --}}}
            {    -- Spacer      }{{{
              function()
                return "  "
              end,
              padding = { left = 0, right = 0 },
              cond = condition,
            },   --}}}
            {    -- Mode        }{{{
              function()
                return string.upper(vim.fn.mode())
              end,
              color = function()
                -- auto change color according to neovims mode
                local mode_color = {
                  n = colors.red,
                  i = colors.green,
                  v = colors.blue,
                  [""] = colors.blue,
                  V = colors.blue,
                  c = colors.magenta,
                  no = colors.red,
                  s = colors.orange,
                  S = colors.orange,
                  [""] = colors.orange,
                  ic = colors.yellow,
                  R = colors.violet,
                  Rv = colors.violet,
                  cv = colors.red,
                  ce = colors.red,
                  r = colors.cyan,
                  rm = colors.cyan,
                  ["r?"] = colors.cyan,
                  ["!"] = colors.red,
                  t = colors.red,
                }
                return { fg = colors.bg.hex, bg = mode_color[vim.fn.mode()] }
              end,
              padding = { left = 1, right = 1 },
            },   --}}}
          },
          lualine_y = {},
          lualine_z = {},
        }

        config.sections = sections
        config.inactive_sections = vim.deepcopy(sections)

        config.inactive_sections.lualine_c[1].color = { fg = colors.fg.hex }

        lualine.setup(config)
      end

      setup_statusline()

      vim.api.nvim_create_autocmd({ "ColorScheme" }, {
          pattern = { "*" },
          callback = setup_statusline
        }
      )
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
          marks = true,       -- shows a list of your marks on ' and `
          registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = false,  -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          presets = {
            operators = false,   -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false,     -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true,      -- default bindings on <c-w>
            nav = true,          -- misc bindings to work with windows
            z = true,            -- bindings for folds, spelling and others prefixed with z
            g = true,            -- bindings for prefixed with g
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
          scroll_up = "<c-u>",   -- binding to scroll up inside the popup
        },
        window = {
          border = vim.g.defaults.border.normal,
          position = "bottom",      -- bottom, top
          margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
          padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
          winblend = 0,
        },
        layout = {
          height = { min = 4, max = 25 },                                             -- min and max height of the columns
          width = { min = 20, max = 50 },                                             -- min and max width of the columns
          spacing = 3,                                                                -- spacing between columns
          align = "center",                                                           -- align columns left, center or right
        },
        ignore_missing = false,                                                       -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = true,                                                             -- show help message on the command line when the popup is visible
        show_keys = true,                                                             -- show the currently pressed key and its label as a message in the command line
        triggers = "auto",                                                            -- automatically setup triggers
        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          -- this is mostly relevant for key maps that start with a native binding
          -- most people should not need to change this
          i = { "j", "k" },
          v = { "j", "k" },
        },
        -- disable the WhichKey popup for certain buf types and file types.
        -- Disabled by default for Telescope
        disable = {
          buftypes = {},
          filetypes = { "TelescopePrompt" },
        },
      })

      wk.register({
        [",f"] = { name = "+finder" },
        [",g"] = { name = "+git" },
        [",z"] = { name = "+zettelkasten" },
        [",l"] = { name = "+lsp" },
        [",d"] = { name = "+diagnostics" },
      })
    end,
  }, -- }}}
}
