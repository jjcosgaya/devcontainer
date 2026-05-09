return {
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    opts = {
      org_agenda_files = '~/orgfiles/**/*',
      org_default_notes_file = '~/orgfiles/refile.org',
      org_todo_keywords = {'TODO(t)', '|', 'DONE'},
      win_split_mode = 'auto',
      win_border = 'none',
      org_startup_folded = 'overview',
      org_archive_location = '~/orgfiles/archive.org',
      org_hide_leading_stars = true, -- This is not working because I set the bg color to none
      org_hide_emphasis_markers = true,
      org_ellipsis = ' ᚾᚾ',
      org_adapt_indentation = true,
      org_id_link_to_org_use_id = true,
      calendar_week_start_day = 1,

      mappings = {
        org_return_uses_meta_return = false,
        org = {
          org_open_at_point = false
        },
      }
    },
    config = function(_, opts)
      require('orgmode').setup(opts)

      vim.keymap.set('n', '<leader>oo', ':e ~/orgfiles/index.org<CR>', { noremap = true, desc = "Open index.org" })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'org',
        callback = function()
          vim.keymap.set('i', '<<CR>', '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
            silent = true,
            buffer = true,
          })
          vim.keymap.set('n', '<bs>', '<C-o>', { buffer = true, })
          vim.keymap.set('n', '<CR>', function()
            local cursorPos = vim.api.nvim_win_get_cursor(0)
            local row = cursorPos[1]
            local col = cursorPos[2]

            local pattern = vim.regex('\\[\\[[^\\[\\]]*\\]\\[[^\\[\\]]*\\]\\]')
            local lineContent = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]

            local startIndex, endIndex = pattern:match_str(lineContent)

            -- print(string.sub(lineContent, startIndex, endIndex))
            if startIndex and col >= startIndex and col < endIndex then
              local org = require('orgmode')
              -- org.action("org_mappings.insert_link")
              org.action("org_mappings.open_at_point")
              return
            end
          end , {
          silent = true,
          buffer = true,
        })
        vim.keymap.set('i', '<s<tab>', '#+begin_src<CR><CR>#+end_src<up>i<esc>==A<bs>', {
          silent = true,
          buffer = true,
        })
      end,
    })


    local wk_ok, wk = pcall(require, "which-key")
    if not wk_ok then
      return
    end

    wk.add({
      mode = { 'n' },
      { '<leader>o', group = 'Org' },
    })
  end
},
{
  'nvim-orgmode/org-bullets.nvim',
  event = 'VeryLazy',
  config = function()
    -- Define bold highlight group with optional color
    vim.api.nvim_set_hl(0, 'Rune', { bold = true }) -- set fg color as needed

    -- Setup your org-bullets or similar plugin
    require("org-bullets").setup {
      -- concealcursor = true,
      symbols = {
        list = '•',
        headlines = {
          { "ᚱ", "Rune" },
          { "ᛟ", "Rune" },
          { "ᛝ", "Rune" },
          { "ᚦ", "Rune" },
          { "ᛠ", "Rune" },
          { "ᛡ", "Rune" },
          { "ᛢ", "Rune" },
        },
        checkboxes = {
          half = { '', '@org.checkbox.halfchecked' },
          done = { 'x', '@org.keyword.done' },
          todo = { ' ', '@org.keyword.todo' },
        }
      }
    }
  end
}
}
