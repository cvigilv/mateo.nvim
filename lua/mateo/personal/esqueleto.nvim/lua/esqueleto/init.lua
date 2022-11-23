local M = {}

local function _scandir(directory, pattern)
  local i, t, popen = 0, {}, io.popen
  for filename in popen('ls -1 ' .. directory .. pattern):lines() do
    i = i + 1
    t[i] = filename
  end
  return t
end

M._defaults = {
  patterns = { "*.jl", "README.md" },
  directory = "/home/carlos/.config/nvim/skeletons/",
}

M.select = function(templates)
  if templates == nil then
    vim.notify("[WARNING] No skeletons found for this file!\nPattern is known by `esqueleto` but could not find any template file")
    return nil
  end

  local selection = nil
  vim.ui.select(
    vim.tbl_keys(templates),
    { prompt = 'Select skeleton to use:', },
    function(choice) selection = choice end
  )

  return templates[selection]
end

M.get = function(pattern, kind)
  local templates = _scandir(M._defaults.directory, pattern)
  if vim.tbl_isempty(templates) then
    return nil
  end

  local types = {}
  if kind == "extension" then
    for _, skeleton in pairs(templates) do
      local l = vim.fs.basename(skeleton)
      local t = vim.split(l, ".", { plain = true, trimempty = true })[2]

      if "*." .. t == pattern then
        t = "default"
      end

      types[t] = skeleton
    end
  elseif kind == "file" then
    types["default"] = templates[1]
  end

  return types
end

M.create = function()
end

M.insert = function(pattern, kind)
  print(pattern)
  local templates = M.get(pattern, kind)
  local file = M.select(templates)

  if file ~= nil then
    vim.cmd("0r " .. file)
  end
end

M.setup = function(opts)
  -- update defaults
  if opts ~= nil then
    for key, value in pairs(opts) do
      M._defaults[key] = value
    end
  end

  -- create autocommands for skeleton insertion
  local group = vim.api.nvim_create_augroup(
    "esqueleto", { clear = true }
  )
  vim.api.nvim_create_autocmd(
    "BufNewFile",
    {
      group = group,
      desc = "Insert skeleton",
      pattern = M._defaults.patterns,
      callback = function()
        -- match either filename or extension. Filename has priority
        local filename = vim.fs.basename(vim.fn.expand("<amatch>"))
        if vim.tbl_contains(M._defaults.patterns, filename) then
          M.insert(filename, "file")
        else
          M.insert("*" .. filename:match("^.+(%..+)$"), "extension")
        end
      end
    }
  )
end

return M
