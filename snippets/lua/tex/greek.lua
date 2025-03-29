-- Greek letter autosnippets using ; prefix
local in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

return {
  -- lowercase Greek
  s({ trig = ";a", snippetType = "autosnippet" }, { t("\\alpha") }, { condition = in_mathzone }),
  s({ trig = ";b", snippetType = "autosnippet" }, { t("\\beta") }, { condition = in_mathzone }),
  s({ trig = ";g", snippetType = "autosnippet" }, { t("\\gamma") }, { condition = in_mathzone }),
  s({ trig = ";d", snippetType = "autosnippet" }, { t("\\delta") }, { condition = in_mathzone }),
  s({ trig = ";e", snippetType = "autosnippet" }, { t("\\epsilon") }, { condition = in_mathzone }),
  s({ trig = ";z", snippetType = "autosnippet" }, { t("\\zeta") }, { condition = in_mathzone }),
  s({ trig = ";et", snippetType = "autosnippet" }, { t("\\eta") }, { condition = in_mathzone }),
  s({ trig = ";o", snippetType = "autosnippet" }, { t("\\theta") }, { condition = in_mathzone }),
  s({ trig = ";i", snippetType = "autosnippet" }, { t("\\iota") }, { condition = in_mathzone }),
  s({ trig = ";k", snippetType = "autosnippet" }, { t("\\kappa") }, { condition = in_mathzone }),
  s({ trig = ";l", snippetType = "autosnippet" }, { t("\\lambda") }, { condition = in_mathzone }),
  s({ trig = ";m", snippetType = "autosnippet" }, { t("\\mu") }, { condition = in_mathzone }),
  s({ trig = ";n", snippetType = "autosnippet" }, { t("\\nu") }, { condition = in_mathzone }),
  s({ trig = ";x", snippetType = "autosnippet" }, { t("\\xi") }, { condition = in_mathzone }),
  -- s({ trig = ";o", snippetType = "autosnippet" }, { t("o") }, { condition = in_mathzone }), -- omicron is just 'o'
  s({ trig = ";p", snippetType = "autosnippet" }, { t("\\pi") }, { condition = in_mathzone }),
  s({ trig = ";r", snippetType = "autosnippet" }, { t("\\rho") }, { condition = in_mathzone }),
  s({ trig = ";s", snippetType = "autosnippet" }, { t("\\sigma") }, { condition = in_mathzone }),
  s({ trig = ";t", snippetType = "autosnippet" }, { t("\\tau") }, { condition = in_mathzone }),
  s({ trig = ";u", snippetType = "autosnippet" }, { t("\\upsilon") }, { condition = in_mathzone }),
  s({ trig = ";f", snippetType = "autosnippet" }, { t("\\phi") }, { condition = in_mathzone }),
  s({ trig = ";ch", snippetType = "autosnippet" }, { t("\\chi") }, { condition = in_mathzone }),
  s({ trig = ";ps", snippetType = "autosnippet" }, { t("\\psi") }, { condition = in_mathzone }),
  s({ trig = ";w", snippetType = "autosnippet" }, { t("\\omega") }, { condition = in_mathzone }),

  -- uppercase Greek
  s({ trig = ";G", snippetType = "autosnippet" }, { t("\\Gamma") }, { condition = in_mathzone }),
  s({ trig = ";D", snippetType = "autosnippet" }, { t("\\Delta") }, { condition = in_mathzone }),
  s({ trig = ";O", snippetType = "autosnippet" }, { t("\\Theta") }, { condition = in_mathzone }),
  s({ trig = ";L", snippetType = "autosnippet" }, { t("\\Lambda") }, { condition = in_mathzone }),
  s({ trig = ";X", snippetType = "autosnippet" }, { t("\\Xi") }, { condition = in_mathzone }),
  s({ trig = ";P", snippetType = "autosnippet" }, { t("\\Pi") }, { condition = in_mathzone }),
  s({ trig = ";S", snippetType = "autosnippet" }, { t("\\Sigma") }, { condition = in_mathzone }),
  s({ trig = ";F", snippetType = "autosnippet" }, { t("\\Phi") }, { condition = in_mathzone }),
  s({ trig = ";P", snippetType = "autosnippet" }, { t("\\Psi") }, { condition = in_mathzone }),
  s({ trig = ";W", snippetType = "autosnippet" }, { t("\\Omega") }, { condition = in_mathzone }),
}
