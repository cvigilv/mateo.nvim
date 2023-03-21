local merge = function(a, b)
  local c = {}
  for k, v in pairs(a) do c[k] = v end
  for k, v in pairs(b) do c[k] = v end
  return c
end

return {
  -- obsidian {{{
  {
    'epwalsh/obsidian.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'hrsh7th/nvim-cmp',
    },
    ft = "markdown",
    lazy = true,
    event = "VeryLazy",
    keys = {
      "<leader>zn",
      "<leader>zp",
      "<leader>zl",
      "<leader>zj",
      "<leader>zN",
      "<leader>zP",
      "<leader>zL",
      "<leader>zJ",
    },
    config = function()
      require('obsidian').setup(
        {
          dir = "~/zk",
          completion = {
            nvim_cmp = true,
          },
          note_id_func = function(title)
            if title ~= nil then
              return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
              return string.char(math.random(65, 90))
            end
          end,
          notes_subdir = "inbox",
        }
      )

      vim.keymap.set(
        "n",
        ",zg",
        "<CMD>ObsidianFollowLink<CR>",
        { noremap = true }
      )

      -- Zettelkasten paths
      local zk = vim.fn.expand("~/zk")
      local fleeting = vim.fn.expand(zk .. "/inbox")
      local permanent = vim.fn.expand(zk .. "/archive")
      local literature = vim.fn.expand(zk .. "/reference")
      local media = vim.fn.expand(zk .. "/media")

      -- Zettelkasten-specific functions
      -- local get_links = function()
      -- end
      --
      -- local get_backlinks = function()
      -- end
      --
      -- local get_alllinks = function()
      -- end
      --
      -- local move_note = function()
      -- end

      -- Telescope searchers
      local zk_theme = function(opts)
        opts = opts or {}

        local theme_opts = {
          prompt_title = "",
          preview_title = "Zettelkasten",
          results_title = "",
          prompt_prefix = "⌕ ",
          selection_caret = "> ",
          entry_prefix = "  ",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            horizontal = {
            },
            vertical = {
              prompt_position = "top",
              results_width = 60,
              results_length = 1,
            },
            width = 90,
            height = 40,
          },
          path_display = { "truncate" },
          winblend = 0,
          border = {},
          borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
        }

        return vim.tbl_deep_extend("force", theme_opts, opts)
      end

      local find_notes = function()
        require("telescope.builtin").find_files(zk_theme({ cwd = zk, }))
      end

      local find_journals = function()
        require("telescope.builtin").find_files(zk_theme({ preview_title = "Journals", cwd = journal, }))
      end

      local find_literature = function()
        require("telescope.builtin").find_files(zk_theme({ preview_title = "Literature notes", cwd = reference, }))
      end

      local find_permanent = function()
        require("telescope.builtin").find_files(zk_theme({ preview_title = "Permanent notes", cwd = archive, }))
      end

      local search_notes = function()
        require("telescope.builtin").live_grep(zk_theme({ cwd = zk, }))
      end

      local search_journals = function()
        require("telescope.builtin").live_grep(zk_theme({ preview_title = "Journals", cwd = journal, }))
      end

      local search_literature = function()
        require("telescope.builtin").live_grep(zk_theme({ preview_title = "Literature notes", cwd = reference, }))
      end

      local search_permanent = function()
        require("telescope.builtin").live_grep(zk_theme({ preview_title = "Permanent notes", cwd = archive, }))
      end

      -- Keymaps
      local opts = { noremap = true, silent = false }

      vim.keymap.set("n", "<leader>zn", find_notes, merge(opts, { desc = "Find notes" }))
      vim.keymap.set("n", "<leader>zp", find_permanent, merge(opts, { desc = "Find permanent note" }))
      vim.keymap.set("n", "<leader>zl", find_literature, merge(opts, { desc = "Find literature note" }))
      vim.keymap.set("n", "<leader>zj", find_journals, merge(opts, { desc = "Find journal" }))

      vim.keymap.set("n", "<leader>zN", search_notes, merge(opts, { desc = "Search in notes" }))
      vim.keymap.set("n", "<leader>zP", search_permanent, merge(opts, { desc = "Search in permanent notes" }))
      vim.keymap.set("n", "<leader>zL", search_literature, merge(opts, { desc = "Search in literature notes" }))
      vim.keymap.set("n", "<leader>zJ", search_journals, merge(opts, { desc = "Search in journals" }))
    end
  }, -- }}}
}
