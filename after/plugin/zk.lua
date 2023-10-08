-- Setup Zettelkasten directory
local zk = vim.fn.expand(os.getenv("ZETTELDIR"))
local media = vim.fn.expand(zk .. "/meta/media")

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

local find_notes = function()
  require("telescope.builtin").find_files(zk_theme({ cwd = zk }))
end

local search_notes = function()
  require("telescope.builtin").live_grep(zk_theme({ cwd = zk }))
end

local opts = { noremap = true, silent = false }
vim.keymap.set(
  "n",
  "<leader>zf",
  find_notes,
  vim.tbl_extend("keep", opts, { desc = "Search notes" })
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
vim.keymap.set(
  "n",
  "<leader>zc",
  function()
    local currentdate = os.date("%Y%m%d", os.time())
    local note_media = media .. "/" .. nextnotename(currentdate, getdatelut(zk))

    os.execute("rm -r " .. note_media .. "; mkdir " .. note_media)
    vim.cmd("e " .. nextnotepath(zk, currentdate, getdatelut(zk)))
  end,
  vim.tbl_extend("keep", opts, { desc = "Create new note for today" })
)

-- Bind ,zC to new dated note
vim.keymap.set(
  "n",
  "<leader>zC",
  function()
    local date = vim.fn.input("Date in YYYYMMDD format:")
    if string.find(date, "[0-9][0-9][0-9][0-9][0,1][0-9][0-3][0-9]") ~= nil then
      local note_media = media .. "/" .. nextnotename(date, getdatelut(zk))

      os.execute("rm -r " .. note_media .. "; mkdir " .. note_media)
      vim.cmd("e " .. nextnotepath(zk, date, getdatelut(zk)))
    else
      error("Date is in incorrect format!", 1)
    end
  end,
  vim.tbl_extend("keep", opts, { desc = "Create new note for given date" })
)

