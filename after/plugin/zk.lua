-- Setup Zettelkasten directory
local zk = vim.fn.expand(os.getenv("ZETTELDIR"))
local media = vim.fn.expand(zk .. "/meta/media")

-- Telescope searchers
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local conf = require("telescope.config").values

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
      horizontal = {},
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
    borderchars = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
  }

  return vim.tbl_deep_extend("force", theme_opts, opts)
end

local search_notes = function()
  require("telescope.builtin").live_grep(zk_theme({ cwd = zk }))
end

local search_headings = function(user_opts)
  -- Get all the title headings in Zettelkasten
  local notes = vim.split(vim.fn.glob(zk .. "/*.md"), "\n", { trimempty = true })
  table.sort(notes)
  local titles = {}

  for _, note in ipairs(notes) do
    local contents = io.open(note, "r"):read("*a")

    if contents ~= nil then
      for _, line in ipairs(vim.split(contents, "\n", { trimempty = true })) do
        -- If line is a level 1 heading, store and continue to next note
        if line ~= "" and string.find(line, "^# ") ~= nil then
          table.insert(titles, { note, line:gsub("^# ", "") })
          break
        end
      end
    end
  end

  -- Setup Telescope picker
  local opts = zk_theme({
    finder = finders.new_table({
      results = titles,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry[2],
          ordinal = entry[2],
          path = entry[1],
          lnum = 0,
        }
      end,
    }),
    sorter = conf.file_sorter({}),
    previewer = conf.file_previewer({}),
  })

  -- Add user options
  if user_opts ~= nil then
    opts = vim.tbl_extend("force", user_opts, opts)
  end

  -- Launch picker
  pickers.new({}, opts):find()
end

local opts = { noremap = true, silent = false }
vim.keymap.set(
  "n",
  "<leader>zf",
  search_headings,
  vim.tbl_extend("keep", opts, { desc = "Search notes by headings" })
)
vim.keymap.set(
  "n",
  "<leader>zF",
  search_notes,
  vim.tbl_extend("keep", opts, { desc = "Search notes by content" })
)

-- Note generator
local function getdatelut(directory)
  -- Get files associated to journal notes
  local pattern = directory .. "/[0-9][0-9][0-9][0-9][0,1][0-9][0-3][0-9][a-zA-Z].md"
  local notes = vim.split(vim.fn.glob(pattern), "\n", { trimempty = true })

  -- Construct lookup table for last note ID per date
  local lut_dates = {}
  for _, notepath in ipairs(notes) do
    -- Get date and note ID from filename
    local date = vim.fn.fnamemodify(notepath, ":t:r"):sub(0, 8)
    local id = vim.fn.fnamemodify(notepath, ":t:r"):sub(9)

    -- Add note ID if not found or update to last note ID
    if not vim.tbl_contains(lut_dates, date) then
      lut_dates[date] = id
    else
      if id > lut_dates[date] then
        lut_dates[date] = id
      end
    end
  end

  return lut_dates
end

-- Return identifier of note given a date and list of known notes
local function nextnoteid(date, lut)
  if vim.tbl_contains(vim.tbl_keys(lut), date) then
    -- Get byte number of current last note ID
    local charbyte = lut[date]:byte()

    -- Jump from uppercase to lowercase IDs
    if charbyte == 90 then
      charbyte = 48
    elseif charbyte == 122 then
      charbyte = 64
    end

    -- Compute next node ID
    local nextid = string.char(charbyte + 1)

    return nextid
  else
    return "A"
  end
end

-- Return file name of a note given a date and list of known notes
local function nextnotename(date, lut)
  return date .. nextnoteid(date, lut)
end

-- Return file path for the next note given a directory, date and list of known notes
local function nextnotepath(dir, date, lut)
  return dir .. "/" .. nextnotename(date, lut) .. ".md"
end

-- Bind ,zc to new today note
vim.keymap.set("n", "<leader>zc", function()
  local currentdate = os.date("%Y%m%d", os.time())
  local note_media = media .. "/" .. nextnotename(currentdate, getdatelut(zk))

  os.execute("rm -r " .. note_media .. "; mkdir " .. note_media)
  vim.cmd("e " .. nextnotepath(zk, currentdate, getdatelut(zk)))
end, vim.tbl_extend("keep", opts, { desc = "Create new note for today" }))

-- Bind ,zC to new dated note
vim.keymap.set("n", "<leader>zC", function()
  local date = vim.fn.input("Date in YYYYMMDD format:")
  if string.find(date, "[0-9][0-9][0-9][0-9][0,1][0-9][0-3][0-9]") ~= nil then
    local note_media = media .. "/" .. nextnotename(date, getdatelut(zk))

    os.execute("rm -r " .. note_media .. "; mkdir " .. note_media)
    vim.cmd("e " .. nextnotepath(zk, date, getdatelut(zk)))
  else
    error("Date is in incorrect format!", 1)
  end
end, vim.tbl_extend("keep", opts, { desc = "Create new note for given date" }))

-- Bind ,z to new link whenever in visual mode
local function replace_date(string)
  -- Use unpack to give tuple values a name otherwise you can only use indexing.
  -- We are getting line, column, buffer nr etc based on the visual markers here.
  local s_buf, s_row, s_col, _ = unpack(vim.fn.getpos("'<"))
  local _, e_row, e_col, _ = unpack(vim.fn.getpos("'>"))
  -- Indexing into buffer row needs - 1 because lua indexing starts from 1.
  -- Column subtracts are just to account for start and end scenarios.
  -- We use the positions to fully clear all selected text of a v-block.
  vim.api.nvim_buf_set_text(s_buf, e_row - 1, s_col - 1, e_row - 1, e_col, {})
  -- Place date.
  vim.api.nvim_buf_set_text(s_buf, s_row - 1, s_col, s_row - 1, s_col, { string })
  -- Exit visual mode
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", false)
end

vim.keymap.set("v", "<leader>z", function()
  local picker_opts = {
    attach_mappings = function(prompt_bufnr, _)
      local state = require("telescope.actions.state")
      actions.select_default:replace(function()
        -- Close Telescope picker
        actions.close(prompt_bufnr) -- closing picker

        -- Get path of selected item in picker
        local link_path = state.get_selected_entry()["path"]

      -- Use unpack to give tuple values a name otherwise you can only use indexing.
      -- We are getting line, column, buffer nr etc based on the visual markers here.
      local s_buf, s_row, s_col, _ = unpack(vim.fn.getpos("'<"))
      local _, e_row, e_col, _ = unpack(vim.fn.getpos("'>"))
      -- Indexing into buffer row needs - 1 because lua indexing starts from 1.
      -- Column subtracts are just to account for start and end scenarios.
      -- We use the positions to fully clear all selected text of a v-block.
      vim.api.nvim_buf_set_text(s_buf, e_row - 1, s_col - 1 , e_row - 1, e_col, {})
      -- Place date.
      vim.api.nvim_buf_set_text(s_buf, s_row - 1, s_col, s_row - 1, s_col, { link_path })
      -- Exit visual mode
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'x', false)


      end)
      return true
    end,
  }
  search_headings(picker_opts)
end, vim.tbl_extend("keep", opts, { desc = "Link to file" }))
