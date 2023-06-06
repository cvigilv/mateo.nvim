local M = {}

local null_ls = require("null-ls")

local function parsearg(argstr)
  -- Initialize argument structure
  local argstruct = {
    ["string"] = argstr,
    ["name"] = nil,
    ["type"] = nil,
    ["default"] = nil,
  }

  -- Cleanup argument string
  argstr = string.gsub(argstr, "%s+", "")

  -- Parse argument string
  if string.find(argstr, "=") then
    local tmp = vim.split(argstr, "=")
    argstr = tmp[1]
    argstruct["default"] = tmp[2]
  end

  if string.find(argstr, "::") then
    local tmp = vim.split(argstr, "::")
    argstruct["name"] = tmp[1]
    argstruct["type"] = tmp[2]
  else
    argstruct["name"] = argstr
  end

  return argstruct
end

local function maptype(argstruct, typemapper)
  if vim.tbl_contains(vim.tbl_keys(typemapper), argstruct["type"]) then
    argstruct["type"] = typemapper[argstruct["type"]]
  end
end

local function formatstruct(argstruct)
  -- Initialize formatted argument string
  local fargs = "- `" .. argstruct["name"]

  -- Add argument type
  if argstruct["type"] then
    fargs = fargs .. "::" .. argstruct["type"]
  end

  fargs = fargs .. "`: "

  -- Add argument default value
  if argstruct["default"] then
    fargs = fargs .. "(default = " .. argstruct["default"] .. ")"
  end

  argstruct["formatted"] = fargs
end

local function extractparametric(paramstr)
  paramstr = string.gsub(paramstr, "^{", "")
  paramstr = string.gsub(paramstr, "}$", "")

  local typemapper = {}
  for _, s in ipairs(vim.split(paramstr, ", ")) do
    local kv = vim.split(s, "<:")
    typemapper[kv[1]] = kv[2]
  end

  return typemapper
end

local function formatfuncstruct(funcstruct)
  local docstring = {
    '"""',
    "    " .. funcstruct.string,
    "",
    "! Single one-line sentence in imperative form describing what the function does or what",
    "  the object represents after the simplified signature block.",
    "! If needed, provide more details in a second paragraph, after a blank line.",
    "! It is recommended that lines are at most 92 characters wide.",
    "",
    "# Arguments",
    "! Only provide an argument list when really necessary.",
    "",
    "# Example",
    "```jldoctest",
    "```",
    "",
    "# Extended help",
    "! Provide longer description of intended functionality for more complex functions",
    "",
    "# References",
    "! Provide hints to related functions, e.g., See also [`bar!`](@ref).",
    "",
    '"""',
  }
  for i, farg in ipairs(funcstruct.args) do
    table.insert(docstring, 10 + i, farg.formatted)
  end

  return docstring
end

M.generate_jldocstring = {
  method = null_ls.methods.CODE_ACTION,
  filetypes = { "julia" },
  generator = {
    fn = function(context)
      -- Get function string
      local fstring = vim.api.nvim_get_current_line()
      fstring = string.gsub(fstring, "^function ", "")

      -- Parse parametric typing declaration
      local typemapper = nil
      if string.find(fstring, " where ") then
        local paramstr = string.match(fstring, "^.* where (.*)$")
        typemapper = extractparametric(paramstr)
      end

      local kv = { string.match(fstring, "^(.*)%((.*)%)") }
      local funcstruct = {
        ["string"] = fstring,
        ["name"] = kv[1],
        ["args"] = {},
      }

      for i, argstr in ipairs(vim.split(kv[2], "[,;] ")) do
        local argstruct = parsearg(argstr)
        if typemapper then
          maptype(argstruct, typemapper)
        end
        formatstruct(argstruct)
        funcstruct["args"][i] = argstruct
      end

      return {
        {
          title = "Generate jldocstring",
          action = function()
            vim.api.nvim_buf_set_lines(
              context.bufnr,
              context.lsp_params.range.start.line,
              context.lsp_params.range.start.line,
              false,
              formatfuncstruct(funcstruct)
            )
          end,
        },
      }
    end,
  },
}

return M
