return {
  -- colorscheme {{{
  {
    -- tokyonight {{{
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
        sidebars = vim.g.defaults.ignored_fts.ui,
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
        on_highlights = function(highlights, _)
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

      -- Create autocommands to properly setup the customized highlight groups
      vim.api.nvim_create_autocmd({ "ColorScheme" }, {
        pattern = { "tokyonight-day" },
        callback = function() vim.o.background = "light" end,
      })
      vim.api.nvim_create_autocmd({ "ColorScheme" }, {
        pattern = { "tokyonight-night", "tokyonight-storm", "tokyonight-moon" },
        callback = function() vim.o.background = "dark" end,
      })
    end,
  }, --}}}
  {
    -- deepwhite {{{
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
          local utils = require("mateo.utils")

          -- Highlight group override
          local lush = require("lush")
          local hsl = lush.hsl

          local fg = hsl(utils.get_hl_group_hex("Normal", "foreground")).hex
          local bg = hsl(utils.get_hl_group_hex("Normal", "background")).hex

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
          highlights.CodeBlock = { guibg = hsl(bg).darken(5).hex }
          highlights.DiffAdd = _diff_added
          highlights.DiffChange = _diff_changed
          highlights.DiffDelete = _diff_deleted
          highlights.GitSignsAdd = _diff_added
          highlights.GitSignsChange = _diff_changed
          highlights.GitSignsDelete = _diff_deleted
          highlights.WinBorder = { guifg = fg, guibg = bg }
          highlights.WinSeparator = { guifg = fg, guibg = bg }
          highlights.TabLine = { guifg = fg, guibg = bg }
          highlights.TabLinSel = { guifg = fg, guibg = fg }
          highlights.TabLineFill = { guifg = bg, guibg = fg }
          highlights.DiagnosticOk = { gui = "reverse", guibg = bg }
          highlights.DiagnosticInfo = { gui = "reverse", guibg = bg }
          highlights.DiagnosticHint = { gui = "reverse", guibg = bg }
          highlights.DiagnosticWarn = { gui = "reverse", guibg = bg }
          highlights.DiagnosticError = { gui = "reverse", guibg = bg }

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
          vim.cmd.colorscheme("deepwhite")
        end,
      })
    end,
  }, --}}}
  -- oxocarbon
  "nyoom-engineering/oxocarbon.nvim",
  -- modus
  "miikanissi/modus-themes.nvim",
  -- }}}
  -- statusline {{{
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
      "lewis6991/gitsigns.nvim",
      "SmiteshP/nvim-navic",
    },
    config = function()
      local utils = require("mateo.utils")
      local lualine = require("lualine")
      local lush = require("lush")
      local hsl = lush.hsluv

      -- Setup statusline
      local setup_statusline = function()
        -- Colors
        local fg = utils.get_hl_group_hex("Normal", "foreground")
        local bg = utils.get_hl_group_hex("Normal", "background")
        local fg_dim = nil
        local bg_dim = nil
        if vim.o.background == "light" then
          fg_dim = hsl(fg).lighten(5).hex
          bg_dim = hsl(bg).darken(5).hex
        elseif vim.o.background == "dark" then
          fg_dim = hsl(bg).lighten(5).hex
          bg_dim = hsl(fg).darken(5).hex
        end

        local colors = {
          fg = fg,
          bg = bg,
          fg_dim = fg_dim,
          bg_dim = bg_dim,
        }

        -- Configuration
        local config = {
          options = {
            disabled_filetypes = vim.g.defaults.ignored_fts.ui,
            component_separators = "",
            section_separators = "",
            theme = {
              normal = { c = { fg = colors.fg, bg = colors.bg } },
              inactive = { c = { fg = colors.fg, bg = colors.bg } },
            },
          },
          sections = nil,
          inactive_sections = nil,
          winbar = nil,
        }

        -- Populate statusline
        --- Hide section if certain conditions are met
        ---@return boolean
        local function hide_section()
          if vim.fn.winwidth(0) < 70 then return false end

          local current_filetype = vim.bo.filetype
          for _, ignored in pairs(vim.g.defaults.ignored_fts.ui) do
            if current_filetype == ignored then return false end
          end
          return true
        end

        local function set_option_safe(name, setter)
          for _, scope in ipairs({ "local", "global" }) do
            setter(vim["opt_" .. scope][name])
          end
        end

        set_option_safe(
          "fillchars",
          function(opt) opt:append({ stl = "─", stlnc = "─" }) end
        )

        local sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { --{{{
            -- Location {{{
            {
              function() return "" end,
              color = { fg = colors.bg_dim, bg = colors.bg },
              padding = { left = 1, right = 0 },
            },
            {
              function() -- Root
                if vim.b.gitsigns_status_dict ~= nil then
                  local fmt_str = "gh: "
                    .. vim.fs.basename(vim.b.gitsigns_status_dict["root"])
                    .. " @ "
                    .. vim.fs.basename(vim.b.gitsigns_status_dict["head"])
                  if string.len(fmt_str) > 44 then
                    fmt_str = string.sub(fmt_str, 1, 32) .. "...)"
                  end
                  return fmt_str
                else
                  return "dir: " .. vim.fn.pathshorten(vim.fn.getcwd(), 3)
                end
              end,
              padding = { left = 1, right = 1 },
              color = { fg = colors.fg, bg = colors.bg_dim, gui = "bold" },
            },
            -- }}}
            -- {{{ Git
            {
              function() return "·" end,
              padding = { left = 0, right = 0 },
              color = { fg = colors.fg, bg = colors.bg_dim },
              cond = function() return vim.b.gitsigns_status_dict ~= nil end,
            },
            {
              "diff",
              diff_color = {
                added = { fg = vim.g.defaults.colors.GitAdd.bg },
                modified = { fg = vim.g.defaults.colors.GitChange.bg },
                removed = { fg = vim.g.defaults.colors.GitDelete.bg },
              },
              padding = { left = 1, right = 1 },
              color = { fg = colors.fg, bg = colors.bg_dim },
            },
            {
              function() return "" end,
              padding = { left = 0, right = 1 },
              color = { fg = colors.bg_dim, bg = colors.bg },
            },

            -- }}}
          },
          --}}}
          lualine_x = { ---{{{
            -- Diagnostics {{{
            {
              function() return "" end,
              color = { fg = colors.bg_dim, bg = colors.bg },
              padding = { left = 1, right = 0 },
            },
            {
              "diagnostics",
              sources = { "nvim_lsp", "nvim_diagnostic" },
              symbols = { error = "x", warn = "!", info = "?", hint = "*" },
              diagnostics_color = {
                error = { fg = utils.get_hl_group_hex("DiagnosticError", "foreground") },
                warn = { fg = utils.get_hl_group_hex("DiagnosticWarn", "foreground") },
                info = { fg = utils.get_hl_group_hex("DiagnosticInfo", "foreground") },
                hint = {
                  fg = utils.get_hl_group_hex("DiagnosticHint", "foreground"),
                },
              },
              always_visible = true,
              update_in_insert = true,
              cond = function()
                if hide_section() then
                  return hide_section()
                elseif vim.tbl_count(vim.lsp.get_active_clients()) > 1 then
                  return false
                end
              end,
              padding = { left = 1, right = 1 },
              color = { fg = colors.fg, bg = colors.bg_dim },
            },
            {
              function() return "·" end,
              padding = { left = 0, right = 0 },
              color = { fg = colors.fg, bg = colors.bg_dim },
            },
            -- }}}
            -- LSP {{{
            {
              function()
                local msg = "LSP: "
                local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                local clients = vim.lsp.get_active_clients()

                -- Return nothing if no LSP server
                if next(clients) == nil then return msg .. "n/a" end

                -- Return non-"null-ls" servers
                for _, client in ipairs(clients) do
                  if client.name ~= "null-ls" then
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                      return msg .. client.name:gsub("_", "-")
                    end
                  end
                end
              end,
              color = { fg = colors.fg, bg = colors.bg_dim, gui = "bold" },
              cond = hide_section,
            },
            {
              function() return "" end,
              padding = { left = 0, right = 1 },
              color = { fg = colors.bg_dim, bg = colors.bg },
            },
            -- }}}
          },
          --}}}
          lualine_y = {},
          lualine_z = {},
        }

        config.sections = sections
        config.inactive_sections = vim.deepcopy(sections)

        lualine.setup(config)
      end

      -- Launch statusline
      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        pattern = { "*" },
        callback = setup_statusline,
      })
    end,
  },
  -- }}}
  --incline {{{
  {
    "b0o/incline.nvim",
    dependencies = "rktjmp/lush.nvim",
    config = function()
      --- Setup incline filename statusbar
      ---@return nil
      local setup_incline = function()
        -- Get current colorscheme `Normal` highlight group
        local utils = require("mateo.utils")
        local hsl = require("lush.hsl")
        local fg = utils.get_hl_group_hex("Normal", "foreground")
        local bg = utils.get_hl_group_hex("Normal", "background")

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
                utils.get_mode(),
                " · ",
                res,
                guifg = fg,
                guibg = hsl(bg).darken(10).hex,
                gui = "bold",
              },
              "",
              guifg = hsl(bg).darken(10).hex,
              guibg = "none",
            }
          end,
          hide = { cursorline = true },
        })
        vim.on_key(incline.refresh(), 0)
      end

      -- Launch statusline
      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        pattern = { "*" },
        callback = setup_incline,
      })
    end,
  }, --}}}
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
}
