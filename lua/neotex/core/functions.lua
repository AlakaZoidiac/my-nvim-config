local M = {}

-- Fine all instances of a word in a project with telescope
function SearchWordUnderCursor()
  local word = vim.fn.expand('<cword>')
  require('telescope.builtin').live_grep({ default_text = word })
end

-- Reload neovim config
vim.api.nvim_create_user_command('ReloadConfig', function()
  for name, _ in pairs(package.loaded) do
    if name:match('^plugins') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify('Nvim configuration reloaded!', vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command("SilentVimtexView", function()
  local tex_file = vim.fn.expand('%:p')                 -- full path to .tex
  local pdf_file = vim.fn.expand('%:r') .. '.pdf'       -- matching PDF
  local line = vim.fn.line('.')                         -- current line for forward search

  if vim.fn.filereadable(pdf_file) == 0 then
    vim.notify("PDF not found!", vim.log.levels.WARN)
    return
  end

  local path = vim.fn.expand("~\\scoop\\apps\\sioyek\\2.0.0\\sioyek.exe")
  local exe = '"' .. path .. '"'

  local cmd = string.format(
    'cmd /c start /b "" %s "%s" --forward-search-file "%s" --forward-search-line %d',
    exe,
    pdf_file,
    tex_file,
    line
  )

  os.execute(cmd)
end, {})


-- Go to next/previous most recent buffer, excluding buffers where winfixbuf = true
function GotoBuffer(count, direction)
  -- Check if a buffer is in a fixed window
  local function is_buffer_fixed(buf)
    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
      if vim.wo[win].winfixbuf then
        return true
      end
    end
    return false
  end

  -- Check if current window is fixed
  local current_buf = vim.api.nvim_get_current_buf()
  if is_buffer_fixed(current_buf) then
    return
  end

  local buffers = vim.fn.getbufinfo({ buflisted = 1 })

  -- Filter and sort buffers into two groups
  local normal_buffers = {}
  local fixed_buffers = {}

  for _, buf in ipairs(buffers) do
    if is_buffer_fixed(buf.bufnr) then
      table.insert(normal_buffers, buf)
    else
      table.insert(fixed_buffers, buf)
    end
  end

  -- Sort both lists by modification time
  local sort_by_mtime = function(a, b)
    return vim.fn.getftime(a.name) > vim.fn.getftime(b.name)
  end
  table.sort(normal_buffers, sort_by_mtime)
  table.sort(fixed_buffers, sort_by_mtime)

  -- Choose which buffer list to use
  local target_buffers = #normal_buffers > 0 and normal_buffers or fixed_buffers
  if #target_buffers == 0 then
    return
  end

  -- Find current buffer index
  local current = vim.fn.bufnr('%')
  local current_index = 1
  for i, buf in ipairs(target_buffers) do
    if buf.bufnr == current then
      current_index = i
      break
    end
  end

  -- Calculate target buffer index
  local target_index = current_index + (direction * count)
  if target_index < 1 then
    target_index = #target_buffers
  elseif target_index > #target_buffers then
    target_index = 1
  end

  -- Switch to target buffer
  vim.cmd('buffer ' .. target_buffers[target_index].bufnr)
end


-- Inverse Search Fix
function M.launch_sioyek()
  local tex_file = vim.fn.expand('%:p')
  local pdf_file = vim.fn.expand('%:r') .. '.pdf'
  local line = vim.fn.line('.')
  local sioyek = vim.fn.expand("~\\scoop\\apps\\sioyek\\2.0.0\\sioyek.exe")

  local inverse_cmd = [[nvim --headless -c "VimtexInverseSearch %2 '%1'"]]

  local args = {
    "--inverse-search", inverse_cmd,
    "--forward-search-file", tex_file,
    "--forward-search-line", tostring(line),
    pdf_file,
  }

  local full_cmd = { sioyek }
  for _, arg in ipairs(args) do
    table.insert(full_cmd, arg)
  end

  vim.fn.jobstart(full_cmd, { detach = true })
end

return M
