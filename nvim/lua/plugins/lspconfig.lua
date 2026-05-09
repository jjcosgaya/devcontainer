return {
  'neovim/nvim-lspconfig',
  config = function()
    vim.lsp.enable('basedpyright')
    vim.lsp.enable('ruff')
    vim.lsp.enable('ts_ls')

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true })
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { noremap = true })

    vim.diagnostic.config({
      virtual_text = true,
      virtual_lines = false,
      signs = false,
      update_in_insert = false
    })
  end
}
