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
