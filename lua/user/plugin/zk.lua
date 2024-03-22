return {
  -- img-clip {{{
  {
    "HakonHarnes/img-clip.nvim",
    config = function()
      local zk = vim.fn.expand(os.getenv("ZETTELDIR"))

      require("img-clip").setup({
        default = {
          dir_path = "~/media/images/img-clip.nvim",
          file_name = "%Y%m%d%H%M%S-" .. vim.fn.expand("%:t:r"),
          use_absolute_path = true,
          prompt_for_file_name = false,
        },
        dirs = {
          [zk] = {
            template = "![$CURSOR]($FILE_PATH)",
            dir_path = "meta/media/" .. vim.fn.expand("%:t:r"),
            file_name = vim.fn.expand("%:t:r") .. "-%Y%m%d%H%M%S",
            use_absolute_path = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
              copy_images = true,
              download_images = true,
            },
          },
          [zk] = {
            template = "![$CURSOR]($FILE_PATH)",
            dir_path = "meta/media/" .. vim.fn.expand("%:t:r"),
            file_name = vim.fn.expand("%:t:r") .. "-%Y%m%d%H%M%S",
            use_absolute_path = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
              copy_images = true,
              download_images = true,
            },
          },
        },
      })
    end,
    keys = {
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
    },
  }, -- }}}
}
