return {
  -- auto-hlsearch {{{
  {
    "asiryk/auto-hlsearch.nvim",
    keys = { "/", "?", "*", "#", "n", "N" },
    tag = "1.1.0",
    config = true,
  },
  -- }}}
  -- dial {{{
  {
    "monaqa/dial.nvim",
    keys = { "<C-a>", "<C-x>", "g<C-a>", "g<C-x>" },
    config = function()
      vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
      vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
      vim.keymap.set("n", "g<C-a>", require("dial.map").inc_gnormal(), { noremap = true })
      vim.keymap.set("n", "g<C-x>", require("dial.map").dec_gnormal(), { noremap = true })
      vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
      vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
      vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
      vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
    end,
  },
  -- }}}
  -- esqueleto {{{
  {
    dir = os.getenv("GITDIR") .. "/esqueleto.nvim",
    enabled = true,
    config = function()
      require("esqueleto").setup({
        autouse = false,
        directories = { os.getenv("GITDIR") .. "/mateo.nvim/skeletons" },
        patterns = vim.fn.readdir(vim.fn.stdpath("config") .. "/skeletons"),
        -- patterns = {
        --   -- File
        --   "README.md",
        --   "LICENSE",
        --   -- Filetype
        --   "julia",
        --   "sh",
        --   "markdown",
        --   "python",
        --   "latex",
        --   "tex",
        -- },
        wildcards = {
          expand = true,
          lookup = {
            ["gh-username"] = "cvigilv",
            ["zk-year"] = function() return string.sub(vim.fn.expand("%:t:r"), 1, 4) end,
            ["zk-month"] = function() return string.sub(vim.fn.expand("%:t:r"), 5, 6) end,
            ["zk-day"] = function() return string.sub(vim.fn.expand("%:t:r"), 7, 8) end,
          },
        },
      })
    end,
  },
  -- }}}
  -- mini TODO: change to single release modules {{{
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Disable unused modules
      vim.g.minibase16_disable = true
      vim.g.minibufremove_disable = true
      vim.g.minicompletion_disable = true
      vim.g.minicursorword_disable = true
      vim.g.minifuzzy_disable = true
      vim.g.miniindentscope_disable = true
      vim.g.minijump_disable = true
      vim.g.minimisc_disable = true
      vim.g.minipairs_disable = true
      vim.g.ministatusline_disable = true
      vim.g.minisurround_disable = true
      vim.g.minitabline_disable = true
      vim.g.minitrailspace_disable = true

      -- Setup ´mini.nvim´ modules
      require("mini.ai").setup()
      require("mini.align").setup()
      require("mini.comment").setup()
      require("mini.sessions").setup({
        -- Setup
        autoread = false,
        autowrite = true,
        force = { read = false, write = true, delete = false },
        verbose = { read = false, write = true, delete = true },
      })

      local generate_footer = function()
        local ls = require("lazy").stats()
        local n_updates = "0"
        if require("lazy.status").has_updates() then
          n_updates = require("lazy.status").updates():gsub("🔌", "")
        end
        return table.concat({
          "",
          "## Relevant keymaps",
          "",
          "- ,zc (New note)",
          "- ,zf (Search note)",
          "- ,ff (Find file)",
          "- ,fs (Find string)",
          "- ,ft (Find tasks)",
          "",
          "",
          "## Stats",
          "",
          "- Loaded "
            .. ls.loaded
            .. "/"
            .. ls.count
            .. " plugins in "
            .. ls.startuptime
            .. " miliseconds",
          "- " .. n_updates .. " plugins can be updated",
          -- TODO: Implement tasks finder and counter
          "- Tasks found in current directory: " .. "nil",
          "",
        }, "\n")
      end

      require("mini.starter").setup({
        -- Setup
        autoopen = true,
        evaluate_single = true,
        header = table.concat({
          "# mateo.nvim",
          "",
          "> mateo: someone who uses his head, smart guy (chilean slang)",
          "",
        }, "\n"),
        items = {
          -- Add prefix to section header
          function()
            local allfiles = require("mini.starter").sections.recent_files(5, true, false)()
            for _, file in ipairs(allfiles) do
              file.section = "## " .. file.section
            end
            return allfiles
          end,
        },
        footer = generate_footer,
        query_updaters = [[abcdefghijklmnopqrstuvwxyz0123456789_-.ABCDEFGHIJKLMNOPQRSTUVWXYZ]],
        content_hooks = {

          function(content)
            local blank_content_line = { { type = "empty", string = "" } }

            local section_coords = require("mini.starter").content_coords(content, "section")
            -- Insert backwards to not affect coordinates
            for i = #section_coords, 1, -1 do
              table.insert(content, section_coords[i].line + 1, blank_content_line)
            end

            return content
          end,
          require("mini.starter").gen_hook.adding_bullet("- "),
          require("mini.starter").gen_hook.aligning("center", "center"),
        },
      })
    end,
  },
  -- }}}
  -- neogen {{{
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      local neogen = require("neogen")

      -- Setup package
      neogen.setup({
        enabled = true,
        languages = {
          lua = { template = { annotation_convention = "emmylua" } },
          python = { template = { annotation_convention = "numpydoc" } },
        },
      })
    end,
    keymaps = {
      vim.keymap.set(
        "n",
        "<Leader>ld",
        function() require("neogen").generate({ type = "func" }) end,
        { desc = "Generate function docstring", noremap = true, silent = true }
      ),
      vim.keymap.set("n", "<Leader>lD", function()
        vim.ui.select(
          { "class", "func", "type", "file" },
          { prompt = "Select docstring to generate:" },
          function(choice) require("neogen").generate({ type = choice }) end
        )
      end, { desc = "Pick docstring to generate", noremap = true, silent = true }),
    },
  }, -- }}}
  -- numb.nvim {{{
  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup({
        show_numbers = true,
        show_cursorline = true,
        hide_relativenumbers = true,
        number_only = false,
        centered_peeking = true,
      })
    end,
  },
  -- }}}
  -- overlength {{{
  {
    "lcheylus/overlength.nvim",
    config = function()
      local utils = require("mateo.utils")
      vim.g.plugin_overlength = {
        enabled = true,
        colors = {
          ctermfg = "",
          ctermbg = "",
          fg = vim.g.defaults.colors.Critical.fg,
          bg = utils.get_hl_group_hex("ColorColumn", "background"),
        },
        textwidth_mode = 1,
        default_overlength = 96,
        grace_length = 0,
        highlight_to_eol = true,
        disable_ft = {
          "Lazy",
          "lazy",
          "NvimTree",
          "Telescope",
          "WhichKey",
          "MiniStarter",
          "Mason",
          "mason",
          "starter",
          "Starter",
          "esqueleto.ivy.selection",
          "help",
          "loclist",
          "orgagenda",
          "packer",
          "qf",
          "quickfix",
          "starter",
          "terminal",
        },
      }
      require("overlength").setup(vim.g.plugin_overlength)
    end,
  },
  -- }}}
  -- pqf {{{
  {
    "yorickpeterse/nvim-pqf",
    init = function()
      require("pqf").setup({
        signs = {
          error = vim.g.defaults.signs.error,
          warn = vim.g.defaults.signs.warn,
          info = vim.g.defaults.signs.info,
          hint = vim.g.defaults.signs.hint,
        },
        show_multiple_lines = false,
        max_filename_length = 0,
      })
    end,
  }, -- }}}
  -- quickscope {{{
  {
    "unblevable/quick-scope",
    event = "VeryLazy",
    keys = { "f", "F", "t", "T" },
    init = function()
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
      vim.g.qs_buftype_blacklist = {
        "terminal",
        "nofile",
        "NvimTree",
        "packer",
        "Starter",
        "Telescope",
        "telescope",
      }
      vim.g.qs_filetype_blacklist = {}

      -- Highlight groups overrides
      vim.cmd([[
        highlight link QuickScopePrimary IncSearch
        highlight link QuickScopeSecondary Search
        augroup hl_QuickScope
          " Plugins
          autocmd ColorScheme * highlight link QuickScopePrimary IncSearch
          autocmd ColorScheme * highlight link QuickScopeSecondary Search
        augroup END
      ]])
    end,
  },
  -- }}}
  -- todo-comments {{{
  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup({
        signs = false,
      })
      vim.keymap.set(
        "n",
        "<leader>ft",
        ":TodoTelescope<CR>",
        { desc = "Find tasks", noremap = true, silent = true }
      )
    end,
  },
  -- }}}
  -- undotree {{{
  {
    "mbbill/undotree",
    event = "VeryLazy",
    cmd = "UndotreeToggle",
    keys = "<leader>u",
    config = function()
      vim.keymap.set(
        "n",
        "<leader>u",
        ":UndotreeToggle<CR>",
        { silent = true, noremap = true, desc = "Undo tree" }
      )
    end,
  },
  -- }}}
  -- zenmode {{{
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    cmd = "ZenMode",
    keys = "<leader>Z",
    config = function()
      vim.keymap.set(
        "n",
        "<leader>Z",
        ":ZenMode<CR>",
        { silent = true, noremap = true, desc = "Zen Mode" }
      )
    end,
  },
  -- }}}
}
