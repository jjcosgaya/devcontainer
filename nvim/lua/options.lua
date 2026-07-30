-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- BASIC CONFIGURATION (Core settings and leader keys)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Set leader keys for custom mappings.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- UI & APPEARANCE (Settings affecting the visual aspects of the editor)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- ────────────────────────────────────────────────
-- Line numbers
-- ────────────────────────────────────────────────
vim.opt.number = true           -- Show absolute line numbers.
vim.opt.relativenumber = true   -- Show relative line numbers from the cursor (aids vertical motion).

-- ────────────────────────────────────────────────
-- Search highlighting
-- ────────────────────────────────────────────────
vim.opt.hlsearch = true         -- Highlight all occurrences of the current search pattern.

-- ────────────────────────────────────────────────
-- Status line and information display
-- ────────────────────────────────────────────────
vim.opt.showcmd = true          -- Display partial commands being typed.

-- Status line visibility
vim.opt.laststatus = 3          -- 0: Never show status line, 1: Only if >1 window, 2: Always show, 3: Global status line

local statusline = {
  -- '%{&filetype}',
  -- ☰, 󰠞
  ' ',
  -- "%{toupper(mode())}%*",  -- Current mode (I/C/V etc)
  ' %f',
  ' %m%h%r%w',
  '%=',
  '%=',
  -- '𐤀 %B',
  '󰳂 %l:%c',
  ' | ',
  ' %L',
  ' | ',
  '▰ %p%% ',
}

vim.o.statusline = table.concat(statusline, '')
vim.opt.cmdheight = 1;

-- vim.opt.ruler = true            -- Display cursor position (line/column) in the status line.
-- vim.opt.rulerformat = '%80(%= %f | 󰳂 %l:%c | %p%% %m%)' -- Configure ruler to show filename and position
-- vim.opt.showmode = true         -- Show the current mode (e.g., INSERT, VISUAL) at the bottom.

-- ────────────────────────────────────────────────
-- Tabs
-- ────────────────────────────────────────────────
vim.opt.showtabline = 0;

-- ────────────────────────────────────────────────
-- Cursor display
-- ────────────────────────────────────────────────
vim.opt.cursorline = true       -- Highlight the line where the cursor is currently located.

-- ────────────────────────────────────────────────
-- Termguicolors
-- ────────────────────────────────────────────────
vim.opt.termguicolors = false


-- ────────────────────────────────────────────────
-- Folding & Conceal
-- ────────────────────────────────────────────────
vim.opt.foldlevel = 99          -- Set a high fold level to ensure code is not folded by default on opening.
vim.opt.foldenable = true

vim.opt.foldmethod = 'expr'
vim.g.vimwiki_folding = 'syntax'

-- Optional: Display a fold column
vim.opt_local.foldcolumn = '1'

-- Conceal
vim.opt.conceallevel = 2
-- vim.opt.concealcursor = 'n'           -- Conceal under cursor in normal mode


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- EDITING BEHAVIOR (Settings that modify how text editing works)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- ────────────────────────────────────────────────
-- Indentation and Tabs
-- ────────────────────────────────────────────────
vim.opt.expandtab = true        -- Use spaces instead of tab characters.
vim.opt.tabstop = 2             -- Number of visual spaces a tab character represents.
vim.opt.shiftwidth = 2          -- Number of spaces used for autoindentation and shift commands (e.g., >>, <<).
vim.opt.autoindent = true       -- Copy indentation from the previous line when starting a new line.
vim.opt.breakindent = true      -- Preserve indentation for wrapped lines.

-- ────────────────────────────────────────────────
-- Undo history
-- ────────────────────────────────────────────────
vim.opt.undofile = true         -- Enable persistent undo; saves undo history across sessions.

-- ────────────────────────────────────────────────
-- Buffer handling
-- ────────────────────────────────────────────────
vim.opt.hidden = true           -- Allow buffers to be hidden (remain in memory) without being saved when switching.

-- ────────────────────────────────────────────────
-- Search behavior
-- ────────────────────────────────────────────────
vim.opt.ignorecase = true       -- Ignore case in search patterns.
vim.opt.smartcase = true        -- Override 'ignorecase' if the search pattern contains an uppercase letter.

-- ────────────────────────────────────────────────
-- Whitespace and special characters
-- ────────────────────────────────────────────────
vim.opt.list = true             -- Show invisible characters (tabs, trailing spaces, etc.).
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- Define how these characters are displayed.

-- ────────────────────────────────────────────────
-- Scrolling behavior
-- ────────────────────────────────────────────────
vim.opt.scrolloff = 5           -- Keep at least 5 lines visible above and below the cursor when scrolling.

-- ────────────────────────────────────────────────
-- Mouse support
-- ────────────────────────────────────────────────
vim.opt.mouse = 'a'             -- Enable mouse support in all modes (Normal, Visual, Insert, Command-line).

-- ────────────────────────────────────────────────
-- Virtual edit allowed in block mode
-- ────────────────────────────────────────────────
vim.opt.virtualedit = 'block'

-- ────────────────────────────────────────────────
-- Showing a split with the changes when using a command
-- ────────────────────────────────────────────────
vim.opt.inccommand = 'split'

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- BEHAVIOR
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- ────────────────────────────────────────────────
-- Window splitting behavior
-- ────────────────────────────────────────────────
vim.opt.splitright = true       -- New vertical splits will open to the right.
vim.opt.splitbelow = true       -- New horizontal splits will open below.

-- ────────────────────────────────────────────────
-- Netrw options
-- ────────────────────────────────────────────────
vim.g.netrw_liststyle = 3 -- Tree mode
-- vim.g.netrw_banner = 0

-- ────────────────────────────────────────────────
-- Marks
-- ────────────────────────────────────────────────
-- Use lowercase for global marks and uppercase for local marks.
local low = function(i) return string.char(97+i) end
local upp = function(i) return string.char(65+i) end

for i=0,25 do vim.keymap.set("n", "m"..low(i), "m"..upp(i)) end
for i=0,25 do vim.keymap.set("n", "m"..upp(i), "m"..low(i)) end
for i=0,25 do vim.keymap.set("n", "'"..low(i), "'"..upp(i)) end
for i=0,25 do vim.keymap.set("n", "'"..upp(i), "'"..low(i)) end


-- ────────────────────────────────────────────────
-- Terminal
-- ────────────────────────────────────────────────
-- Shell used by :terminal (falls back to $SHELL, then /bin/sh — be explicit).
vim.opt.shell = '/bin/bash'

local term_group = vim.api.nvim_create_augroup("Terminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  group = term_group,
  callback = function()
    vim.opt_local.number = true               -- Hide line numbers
    vim.opt_local.relativenumber = true       -- Hide relative line numbers
    vim.opt_local.cursorline = true           -- Not highlight current line
    vim.opt_local.scrollback = 100000          -- Scrollback buffer size
    vim.opt_local.list = false                -- Don't render listchars (»/·) over terminal output
  end,
})

-- Show line numbers when leaving terminal insert mode (i.e., going to normal mode)
vim.api.nvim_create_autocmd("TermLeave", {
  group = term_group,
  callback = function()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
    vim.opt_local.cursorline = true
  end,
})

-- When entering terminal insert-mode again, hide numbering
vim.api.nvim_create_autocmd("TermEnter", {
  group = term_group,
  callback = function(args)
    -- vim.opt_local.number = false
    -- vim.opt_local.relativenumber = false
  end,
})

-- Close the terminal when closing the window (if it's not floating)
vim.api.nvim_create_autocmd("WinClosed", {
  group = term_group,
  callback = function(event)
    local function is_floating(win)
      if not vim.api.nvim_win_is_valid(win) then return false end

      local config = vim.api.nvim_win_get_config(win)
      return config.relative ~= ""
    end

    local win = tonumber(event.match)
    local buf = tonumber(event.buf)

    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" and not is_floating(win) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end,
})
