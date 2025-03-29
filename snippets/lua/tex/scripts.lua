local in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

return{
  s({
    trig = "([a-zA-Z0-9%)%]%}])'", -- captures letter/number/closing brackets
    regTrig = true,
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    f(function(_, snip)
      return snip.captures[1] .. "_{"
    end),
    i(1),
    t("}"),
  }, { condition = in_mathzone }),

  s({
    trig = "([a-zA-Z0-9%)%]%}])%[", -- must escape [ with %
    regTrig = true,
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    f(function(_, snip)
      return snip.captures[1] .. "^{"
    end),
    i(1),
    t("}"),
  }, { condition = in_mathzone }),
}
