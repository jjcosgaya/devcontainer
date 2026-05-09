-- ────────────────────────────────────────────────
-- which-key loading
-- ────────────────────────────────────────────────
local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
  return
end

-- ────────────────────────────────────────────────
-- Utility Keymaps
-- ────────────────────────────────────────────────
-- Clear search highlighting with <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { noremap = true, silent = true, desc = 'Clear search highlight' })

-- ────────────────────────────────────────────────
-- System Clipboard Mappings
-- ────────────────────────────────────────────────
-- Use <leader>y to yank to system clipboard, <leader>p/P to paste from system clipboard.
vim.keymap.set('n', '<leader>y', '"+y', { noremap = true, silent = true, desc = "Yank to system clipboard" })
vim.keymap.set('n', '<leader>p', '"+p', { noremap = true, silent = true, desc = "Paste from system clipboard after cursor" })
vim.keymap.set('n', '<leader>P', '"+P', { noremap = true, silent = true, desc = "Paste from system clipboard before cursor" })
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true, desc = "Yank selection to system clipboard" })
vim.keymap.set('v', '<leader>p', '"+p', { noremap = true, silent = true, desc = "Paste from system clipboard over selection" })
vim.keymap.set('v', '<leader>P', '"+P', { noremap = true, silent = true, desc = "Paste from system clipboard before selection (like normal P)"})
wk.add({
  mode = { 'n', 'v' },
  hidden = true,
  { '<leader>y' },
  { '<leader>p' },
  { '<leader>P' }
})

-- ────────────────────────────────────────────────
-- Buffer & Window Navigation
-- ────────────────────────────────────────────────
-- Move between windows
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true, desc = 'Left' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true, desc = 'Down' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true, desc = 'Up' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true, desc = 'Right' })

vim.keymap.set('n', '<leader>wh', '<C-w>h', { noremap = true, silent = true, desc = 'Move left' })
vim.keymap.set('n', '<leader>wj', '<C-w>j', { noremap = true, silent = true, desc = 'Move down' })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { noremap = true, silent = true, desc = 'Move up' })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { noremap = true, silent = true, desc = 'Move right' })

wk.add({
  { '<leader>w', group = 'Windows', mode = 'n' }
})

-- Close Current Buffer
vim.keymap.set('n', '<leader>cb', ':bd<CR>', { noremap = true, silent = true, desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>cw', ':close<CR>', { noremap = true, silent = true, desc = 'Close current window' })

wk.add({
  { '<leader>c', group = 'Close', mode = 'n' }
})

-- COMMENTED BECAUSE I INSTALLED YAZI
-- -- Open File Explorer
-- local prev_buf = nil
-- function OpenNetrw()
--   prev_buf = vim.api.nvim_get_current_buf()
--   vim.cmd("Explore")
-- end
--
-- vim.keymap.set('n', '<leader>n', OpenNetrw, { noremap = true, silent = true, desc = 'Open file explorer' })
--
-- -- Close File Explorer
-- function CloseNetrwAndReturn()
--   if prev_buf and vim.api.nvim_buf_is_valid(prev_buf) then
--     local buf_before = vim.api.nvim_get_current_buf()
--     vim.cmd("b" .. prev_buf)
--     local buf_after = vim.api.nvim_get_current_buf()
--     if buf_before == buf_after then -- If they are equal, we didn't leave netrw
--       vim.cmd("bd")
--     end
--   else
--     vim.cmd("bd") -- In case there is no prev_buf, we just close this
--   end
-- end
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "netrw",
--   callback = function()
--     vim.keymap.set("n", "q", ":lua CloseNetrwAndReturn()<cr>", { noremap = true, buffer = true, silent = true, nowait = true, desc = "Close file explorer" })
--     vim.bo.buflisted = false -- Make netrw buffer not listed
--   end
-- })

-- ────────────────────────────────────────────────
-- Terminal
-- ────────────────────────────────────────────────
vim.keymap.set('n', '<leader>tn', ":term<cr>", { noremap = true, silent = true, desc = "New terminal"})
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    -- Send commands with enter from normal mode
    vim.keymap.set('n', '<cr>', [[i<Cr><C-\><C-n>]], { noremap = true, silent = true, buffer = true, desc = "Execute command" })
    -- Create new terminals on splits
    vim.keymap.set('n', '<C-w>v', ':vsplit | term<cr>', { noremap = true, silent = true, buffer = true, desc = "Vertical split new terminal" })
    vim.keymap.set('n', '<C-w>s', ':split | term<cr>', { noremap = true, silent = true, buffer = true, desc = "Horizontal split new terminal" })
  end,
})
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], { remap = true, silent = true, desc = "Toggle terminals tab"}) -- remap = true allows to execute other keymaps
vim.keymap.set('t', '<C-y>', [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Copy mode" })

local showTerminals = function()
  local tab_count = vim.fn.tabpagenr('$')
  if tab_count == 1 then
    vim.cmd("tabnew")
    vim.cmd("term")
  elseif tab_count == 2 then
    vim.cmd("tabnext")
  else
    print("You're using more than two tabs!")
  end
end
vim.keymap.set('n', '<A-t>', showTerminals, { noremap = true, silent = true, desc = "Toggle terminals tab"})
vim.keymap.set('t', '<A-t>', [[<C-\><C-n>:tabnext<cr>]], { noremap = true, silent = true, desc = "Toggle terminals tab"})


wk.add({
  { '<leader>t', group = 'Terminal', mode = 'n' }
})

-- ────────────────────────────────────────────────
-- Indentation in Visual Mode
-- ────────────────────────────────────────────────
-- Maintain visual selection when indenting/outdenting.
vim.keymap.set('v', '<S-tab>', '<gv', { noremap = true, silent = true, desc = 'Outdent line(s) and reselect' })
vim.keymap.set('v', '<tab>', '>gv', { noremap = true, silent = true, desc = 'Indent line(s) and reselect' })
