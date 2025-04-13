-- BOOTSTRAP LAZY
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.cmd [[
  augroup Transparency
    autocmd!
    autocmd VimEnter * hi Normal guibg=NONE ctermbg=NONE
    autocmd VimEnter * hi NormalNC guibg=NONE ctermbg=NONE
    autocmd VimEnter * hi VertSplit guibg=NONE ctermbg=NONE
    autocmd VimEnter * hi StatusLine guibg=NONE ctermbg=NONE
    autocmd VimEnter * hi StatusLineNC guibg=NONE ctermbg=NONE
    autocmd VimEnter * hi TabLine guibg=NONE ctermbg=NONE
    autocmd VimEnter * hi TabLineFill guibg=NONE ctermbg=NONE
    autocmd VimEnter * hi TabLineSel guibg=NONE ctermbg=NONE
  augroup END
]]

vim.cmd[[
" Use Tab to expand and jump through snippets
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

" Use Shift-Tab to jump backwards through snippets
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
]]

vim.keymap.set("n", "<CR>", function()
  vim.cmd("nohlsearch")
  vim.cmd("echo ''")
end, { desc = "Clear search + messages" })

vim.keymap.set("n", "<Esc>", function()
  vim.cmd("nohlsearch")
  vim.cmd("echo ''")
end, { desc = "Clear search + messages" })

require("lazy").setup({
  { import = "neotex.plugins" },    -- main plugins directory
  { import = "neotex.plugins.lsp" } -- lsp plugins directory
}, {
  install = {
    colorscheme = { "gruvbox" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
