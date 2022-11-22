local skeletondir = "/home/carlos/.config/nvim/skeletons/"

local function get_keys(t)
  local keys = {}
  for key, _ in pairs(t) do
    table.insert(keys, key)
  end
  return keys
end

local function split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

local function scandir(directory, pattern)
  local i, t, popen = 0, {}, io.popen
  for filename in popen('ls -1 ' .. directory .. pattern):lines() do
    i = i + 1
    t[i] = filename
  end
  return t
end

local function getskeletons(directory, filetype)
  local skeletonfiles = scandir(directory, "*." .. filetype)

  local skeletontypes = {}
  for _, skeleton in pairs(skeletonfiles) do
    local l = split(skeleton, "/")
    local f = l[#l]
    local t = split(f, ".")[2]
    print(t, filetype)
    if t == filetype then
      t = "default"
    end

    skeletontypes[t] = skeleton
  end

  return skeletontypes
end

local function selectskeleton(skeletons)
  local selection = nil

  vim.ui.select(
    get_keys(skeletons),
    {
      prompt = 'Select skeleton to use:',
    },
    function(choice)
      selection = choice
    end
  )

  return skeletons[selection]
end

local function insertskeleton(skeletonfile)
  if skeletonfile ~= nil then
    vim.cmd("0r " .. skeletonfile)
  end
end

local function esqueleto(directory, filetype)
  insertskeleton(selectskeleton(getskeletons(directory, filetype)))
end

local filetypes_with_skeletons = { "jl", "sh", "md", "py" }
for _, filetype in pairs(filetypes_with_skeletons) do
  vim.api.nvim_create_autocmd(
    "BufNewFile",
    {
      desc = "Skeleton files insertion",
      pattern = "*." .. filetype,
      callback = function() esqueleto(skeletondir, filetype) end
    }
  )
end
