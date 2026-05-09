return {
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        require('nvim-treesitter.config').setup({
          ensure_installed = { 'c', 'lua', 'python', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline' },
          auto_install = true,

          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
          textobjects = {
            select = {
              enable = true,

              -- Automatically jump forward to textobj, similar to targets.vim
              lookahead = true,

              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = { query = "@function.outer" },
                ["if"] = { query = "@function.inner" },
                ["ac"] = { query = "@class.outer" },
                -- You can optionally set descriptions to the mappings (used in the desc parameter of
                -- nvim_buf_set_keymap) which plugins like which-key display
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
              },
              -- You can choose the select mode (default is charwise 'v')
              selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                -- ['@function.outer'] = 'V', -- linewise
                -- ['@class.outer'] = '<c-v>', -- blockwise
              },
              include_surrounding_whitespace = false,
            },
          },
        })
      end
    },


    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      dependencies = 'nvim-treesitter/nvim-treesitter'
    },
}
