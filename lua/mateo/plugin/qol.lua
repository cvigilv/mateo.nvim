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
  -- mini {{{
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Disable unused modules
      vim.g.miniai_disabled = false
      vim.g.minialign_disabled = false
      vim.g.minianimate_disabled = true
      vim.g.minibase16_disabled = false
      vim.g.minibasics_disabled = true
      vim.g.minibracketed_disabled = true
      vim.g.minibufremove_disabled = true
      vim.g.miniclue_disabled = true
      vim.g.minicolors_disabled = false
      vim.g.minicomment_disabled = false
      vim.g.minicompletion_disabled = true
      vim.g.minicursorword_disabled = true
      vim.g.minideps_disabled = true
      vim.g.minidoc_disabled = true
      vim.g.miniextra_disabled = true
      vim.g.minifiles_disabled = true
      vim.g.minifuzzy_disabled = true
      vim.g.minihipatterns_disabled = false
      vim.g.minihues_disabled = true
      vim.g.miniindentscope_disabled = true
      vim.g.minijump_disabled = true
      vim.g.minijump2d_disabled = true
      vim.g.minimap_disabled = true
      vim.g.minimisc_disabled = true
      vim.g.minimove_disabled = true
      vim.g.mininotify_disabled = true
      vim.g.mininvim_disabled = true
      vim.g.minioperators_disabled = true
      vim.g.minipairs_disabled = true
      vim.g.minipick_disabled = true
      vim.g.minisessions_disabled = true
      vim.g.minisplitjoin_disabled = false
      vim.g.ministarter_disabled = false
      vim.g.ministatusline_disabled = true
      vim.g.minisurround_disabled = false
      vim.g.minitabline_disabled = true
      vim.g.minitest_disabled = true
      vim.g.minitrailspace_disabled = false
      vim.g.minivisits_disabled = true

      -- Setup ´mini.nvim´ modules using default behaviour
      require("mini.ai").setup()
      require("mini.align").setup()
      require("mini.comment").setup()
      require("mini.surround").setup()
      require("mini.splitjoin").setup()
      require("mini.trailspace").setup()

      -- Setup ´mini.nvim´ modules using custom behaviour
      -- TODO: Replace with folke/todo.comments (more powerful)
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
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
    keymaps = { "<Leader>ld", "<Leader>lD" },
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

      -- Keymaps
      vim.keymap.set(
        "n",
        "<Leader>ld",
        function() require("neogen").generate({ type = "func" }) end,
        { desc = "Generate function docstring", noremap = true, silent = true }
      )

      vim.keymap.set("n", "<Leader>lD", function()
        vim.ui.select(
          { "class", "func", "type", "file" },
          { prompt = "Select docstring to generate:" },
          function(choice) require("neogen").generate({ type = choice }) end
        )
      end, { desc = "Pick docstring to generate", noremap = true, silent = true })
    end,
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
    config = function() require("overlength").setup(vim.g.plugins.overlength()) end,
  },
  -- }}}
  -- pqf {{{
  {
    "yorickpeterse/nvim-pqf",
    config = function()
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
      vim.g.qs_filetype_blacklist = vim.g.defaults.ignored_fts.ui

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
}
