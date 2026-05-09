return {
  'rebelot/kanagawa.nvim',
  config = function()
    require('kanagawa').setup({})
    require("kanagawa").load("wave")
    local palette = require("custom.palette")

    -- Custom Highlight Group Overrides
    local hl = vim.api.nvim_set_hl
    -- These fine-tune the appearance of specific UI elements.
    hl(0, 'Normal', { bg = 'NONE' })
    hl(0, 'NormalNC', { bg = 'NONE' }) -- (NonCurrent)
    hl(0, 'NormalFloat', { bg = 'NONE' })
    hl(0, 'FloatBorder', { bg = 'NONE' })
    hl(0, 'CursorLine', { bg = 'NONE' })

    hl(0, 'WinSeparator', { fg = '#777777', bg = 'none' })

    -- vim.api.nvim_set_hl(0, 'Underlined', { fg = '#f9e2af', bg = 'NONE' })

    hl(0, 'CursorLineNr', { fg = palette.orange })
    hl(0, 'LineNr', { fg = palette.subtext0 })
    -- hl(0, 'SignColumn', { bg = 'None' })
    hl(0, 'FoldColumn', { bg = 'None' })

    hl(0, 'StatusLine', { bg = 'none', fg = '#cccccc' })
    hl(0, 'TelescopeBorder', { bg = 'none', fg = palette.subtext0 })

    -- Completion menu
    hl(0, 'Pmenu', { bg = 'None' })
    hl(0, 'PmenuSel', { fg = palette.highlight, bg = palette.surface0 })
    hl(0, 'PmenuSbar', { bg = palette.surface0 })
    hl(0, 'PmenuThumb', { bg = palette.surface2 })
    hl(0, 'BlinkCmpLabel', { bg = 'None', fg = palette.subtext0 })
    hl(0, 'BlinkCmpLabelMatch', { bg = 'None', fg = palette.text, bold = true })
    hl(0, 'BlinkCmpMenuSelection', { bg = palette.surface2, fg = palette.text, bold = true })

  end
}
