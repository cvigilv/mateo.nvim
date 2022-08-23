local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local rep = require("luasnip.extras").rep
local lambda = require("luasnip.extras").l
local postfix = require("luasnip.extras.postfix").postfix

-- Setup
ls.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = false,
})

-- Keymaps
vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-h>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set("i", "<C-k>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

vim.keymap.set("i", "<C-j>", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end, { silent = true })

-- Snippets
local function _split(str, delimiter)
  local result = {}
  for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

local function julia_args(index)
  print(vim.inspect(index))
  return f(
    function(args)
      local arg_str = args[1][1]
      local formatted_args = {}

      for _, arg in ipairs(_split(arg_str, ", ")) do
        -- Parse differently if argument has default value
        if string.find(arg, "=") then
          local arg_with_default = _split(arg, '=')
          local argname = arg_with_default[1]:gsub("%s", "")
          local default = arg_with_default[2]:gsub("%s", "")
          table.insert(formatted_args, string.format("- `%s` : (default = %s)", argname, default))
        else
          table.insert(formatted_args, string.format("- `%s` : ", arg))
        end
      end

      return formatted_args
    end, { index })
end

ls.snippets = {}
ls.add_snippets("julia", {
  -- Ternary operator {{{
  s("ternary", {
    i(1, "if..."),
    t(" ? "),
    i(2, "then..."),
    t(" : "),
    i(3, "else...")
  }), -- }}}
  -- Function {{{
  s("func",
    c(1, {
      -- Undocumented function {{{
      fmt([[
        function {1}({2})
            {3}
        end
      ]],
        {
          i(1, "funcname"),
          i(2, "args..."),
          i(0, "body..."),
        }
      ), -- }}}
      -- Documented function {{{
      fmt([[
        """
            {4}({5})

        TODO: Add short description to `{6}`

        # Arguments
        {7}
        """
        function {1}({2})
            {3}
        end
      ]],
        {
          i(1, "funcname"),
          i(2, "args..."),
          i(0, "body..."),
          rep(1),
          rep(2),
          rep(1),
          julia_args(2)
        }
      ), -- }}}
    }
    )
  ), ---}}}
  -- Symmetric matrix constructor {{{
  s("simmat",
    fmt(
      [[
      using LinearAlgebra.diagind
      M = rand({},{})
      M = @. (M+M')/2
      M[diagind(M)] .= 1

      {}
      ]],
      {
        i(1, "size"),
        rep(1),
        i(0, "...")
      }
    )
  ), -- }}}
})
