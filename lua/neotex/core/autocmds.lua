local api = vim.api

-- Set special buffers as fixed and map 'q' to close
api.nvim_create_autocmd(
  "FileType",
  {
    pattern = { "man", "help", "qf", "lspinfo", "infoview", "NvimTree" }, -- "startuptime",
    callback = function(ev)
      -- Set the window as fixed
      vim.wo.winfixbuf = true
      -- Map q to close
      vim.keymap.set("n", "q", ":close<CR>", { buffer = ev.buf, silent = true })
    end,
  }
)

-- Open matching PDF in Sioyek silently (no cmd popup)
local function open_sioyek_after_compile()
  local pdf_file = vim.fn.expand('%:r') .. '.pdf'
  if vim.fn.filereadable(pdf_file) == 0 then
    return
  end
  local path = vim.fn.expand("~\\scoop\\apps\\sioyek\\2.0.0\\sioyek.exe")
  local exe = '"' .. path .. '"'
  local cmd = 'cmd /c start /b "" ' .. exe .. ' ' .. vim.fn.shellescape(pdf_file)
  os.execute(cmd)
end

api.nvim_create_autocmd("User", {
  pattern = "VimtexEventCompileSuccess",
  callback = open_sioyek_after_compile,
})

-- Inverse Search Fix
api.nvim_create_autocmd("User", {
  pattern = "VimtexEventCompileSuccess",
  callback = function()
    require("neotex.core.functions").launch_sioyek()
  end,
})
