return {
  -- navigator {{{
  {
    "numToStr/Navigator.nvim",
    config = function()
      require("Navigator").setup({
        auto_save = "nil",
        disable_on_zoom = true,
      })

      -- Keybindings
      local opts = { noremap = true, silent = true }

      vim.keymap.set("n", "<C-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
      vim.keymap.set("n", "<C-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
      vim.keymap.set("n", "<C-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
      vim.keymap.set("n", "<C-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
      vim.keymap.set("n", "<C-p>", "<CMD>lua require('Navigator').previous()<CR>", opts)
    end,
  },
  -- }}}
  -- telescope {{{
  {
    "nvim-telescope/telescope.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = "Telescope",
    keys = {
      "<leader>ff",
      "<leader>fg",
      "<leader>fb",
      "<leader>fd",
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
      local execute = vim.cmd
      local previewers = require("telescope.previewers")
      local Job = require("plenary.job")

      local M = {}

      -- Intelligent find files
      M.project_files = function(opts)
        local ok = pcall(require("telescope.builtin").git_files, opts)
        if not ok then
          require("telescope.builtin").find_files(opts)
        end
      end

      -- Intelligent previewer
      local intelligent_previewer = function(filepath, bufnr, opts)
        filepath = vim.fn.expand(filepath)
        Job:new({
          command = "file",
          args = { "--mime-type", "-b", filepath },
          on_exit = function(j)
            local mime_type = vim.split(j:result()[1], "/")[1]
            if mime_type == "text" then
              previewers.buffer_previewer_maker(filepath, bufnr, opts)
            else
              vim.schedule(function()
                vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Binary file - Can't preview..." })
              end)
            end
          end,
        }):sync()
      end

      -- Setup
      require("telescope").setup({
        defaults = {
          prompt_prefix = "? ",
          selection_prefix = "  ",
          multi_icon = "!",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          path_display = { "truncate = 3", "smart" },
          layout_strategy = "bottom_pane",
          layout_config = {
            bottom_pane = {
              height = 0.4,
              prompt_position = "top",
              preview_width = 0.6,
            },
          },
          winblend = 0,
          border = true,
          borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
          buffer_previewer_maker = intelligent_previewer,
        },
        pickers = {
          find_files = { prompt_title = "   Find files   " },
          git_files = { prompt_title = "   Git files   " },
          live_grep = { prompt_title = "   Live Grep   " },
          builtin = { prompt_title = "   Pickers   ", previewer = false },
        },
      })
      -- Highlighting
      execute([[
        highlight TelescopeTitle         gui=bold   guibg=#1F1F36 guifg=#f5f5f5
        highlight TelescopeBorder                   guifg=#1F1F36 guibg=#020207
        highlight TelescopeNormal                   guifg=#F5F5F5 guibg=#020207
        highlight TelescopePromptNormal             guifg=#F5F5F5 guibg=#020207
        highlight TelescopePreviewNormal            guifg=#F5F5F5 guibg=#020207
      ]])

      -- Keymaps
      vim.keymap.set("n", ",ff", M.project_files, { silent = true, noremap = true, desc = "Find files" })
      vim.keymap.set(
        "n",
        ",fg",
        "<CMD>Telescope live_grep<CR>",
        { silent = true, noremap = true, desc = "Live grep" }
      )
      vim.keymap.set(
        "n",
        ",fb",
        "<CMD>Telescope buffers<CR>",
        { silent = true, noremap = true, desc = "Buffers" }
      )
      vim.keymap.set(
        "n",
        ",fd",
        "<CMD>Telescope diagnostics<CR>",
        { silent = true, noremap = true, desc = "LSP diagnostics" }
      )
    end,
  }, -- }}}
  -- oil {{{
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        columns = {},
        default_file_explorer = true,
        restore_win_options = true,
        skip_confirm_for_simple_edits = false,
        delete_to_trash = true,
        prompt_save_on_select_new_entry = true,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-S>"] = "actions.select_vsplit",
          ["<C-s>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["g."] = "actions.toggle_hidden",
        },
        -- Set to false to disable all of the above keymaps
        use_default_keymaps = true,
      })

      vim.keymap.set("n", "<leader><CR>", require("oil").open, {
        desc = "File browser",
        noremap = true,
        silent = true,
      })
    end,
  },
  -- }}}
}
