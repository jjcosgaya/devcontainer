local floating_windows = {}

function MaximizeFloatingWindow()
  local cur_win = vim.api.nvim_get_current_win()
  local cur_buf = vim.api.nvim_get_current_buf()

  if floating_windows[cur_buf] then
    -- -- Already floating: close the float and reopen buffer in original window
    local original_win = floating_windows[cur_buf]

    -- Focus on closed window and open the buffer there
    if vim.api.nvim_win_is_valid(original_win) then
      print("VALID")
      vim.api.nvim_win_set_buf(original_win, cur_buf)
      -- vim.api.nvim_set_current_win(original_win)
    end

    if vim.api.nvim_win_is_valid(cur_win) then
      vim.api.nvim_win_close(cur_win, true)
    end

    floating_windows[cur_buf] = nil
    return
  else
    -- Not floating: convert current buffer into floating window
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local float_win = vim.api.nvim_open_win(cur_buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      style = "minimal",
      border = "rounded",
    })

    -- Save float info
    floating_windows[cur_buf] = cur_win

    -- Put an empty buffer in the original window
    local new_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(cur_win, new_buf)
  end
end

vim.keymap.set("n", "<C-w>z", MaximizeFloatingWindow, { desc = "Maximize window" })
