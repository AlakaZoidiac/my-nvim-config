return {
  -- To return multiple snippets, use one `return` statement per snippet file
  -- and return a table of Lua snippets.
  require("luasnip").snippet(
    { trig = "foo" },
    { t("Another snippet.") }
  ),
 -- Example: how to set snippet parameters
  s("hi",  -- LuaSnip expands this to {trig = "hi"}
    { t("Hello, world!"), }
  ),

  -- Code for environment snippet in the above GIF
  s({trig="env", snippetType="autosnippet"},
    fmta(
      [[
        \begin{<>}
            <>
        \end{<>}
      ]],
      {
        i(1),
        i(2),
        rep(1),  -- this node repeats insert node i(1)
      }
    )
  ),
  s("bm2", fmt([[
  \begin{{bmatrix}}
    {} & {} \\
    {} & {}
  \end{{bmatrix}}
  ]], { i(1, "a_{11}"), i(2, "a_{12}"), i(3, "a_{21}"), i(4, "a_{22}") })),
  s("box", {
    f(function(args)
      local len = #args[1][1]
      return "┌" .. string.rep("─", len + 2) .. "┐"
    end, { 1 }),
    t({ "", "│ " }),
    i(1),
    t({ " │", "" }),
    f(function(args)
      local len = #args[1][1]
      return "└" .. string.rep("─", len + 2) .. "┘"
    end, { 1 }),
    i(0),
  }),
  s({ trig = "bm(%d+)", regTrig = true, snippetType = "autosnippet" }, {
    t("\\begin{bmatrix}"),
    t({ "", "" }),
    d(1, function(_, snip)
      local n = tonumber(snip.captures[1]) or 2
      local nodes = {}
      local count = 1

      for row = 1, n do
        for col = 1, n do
          table.insert(nodes, i(count, string.format("a_{%d%d}", row, col)))
          count = count + 1
          if col < n then
            table.insert(nodes, t(" & "))
          end
        end
        if row < n then
          table.insert(nodes, t({ " \\\\", "" }))
        end
      end

      return sn(nil, nodes)
    end, {}),
    t({ "", "\\end{bmatrix}" }),
    i(0),
  }, {
    condition = function()
      return vim.bo.filetype == "tex"
    end,
  }),
}
