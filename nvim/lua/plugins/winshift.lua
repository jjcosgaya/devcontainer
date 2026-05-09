return {
'sindrets/winshift.nvim',
config = function()
  vim.keymap.set('n', '<leader>wH', ':WinShift left<cr>', { noremap = true, silent = true, desc = 'Move window left' })
  vim.keymap.set('n', '<leader>wJ', ':WinShift down<cr>', { noremap = true, silent = true, desc = 'Move window down' })
  vim.keymap.set('n', '<leader>wK', ':WinShift up<cr>', { noremap = true, silent = true, desc = 'Move window up' })
  vim.keymap.set('n', '<leader>wL', ':WinShift right<cr>', { noremap = true, silent = true, desc = 'Move window right' })
end
}
