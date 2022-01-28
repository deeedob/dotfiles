local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

-- Lua
require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

require('wlsample.bubble') 	-- windline
g.mapleader = "."
opt.clipboard = "unnamedplus"
opt.cmdheight = 1
opt.ruler = false
opt.hidden = true
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.number = true
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.termguicolors = true            -- True color support

opt.numberwidth = 2
opt.number = true                   -- Show line numbers
opt.relativenumber = false
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4                     -- Number of spaces tabs count for
opt.undofile = true
opt.wrap = true                    -- Disable line wrap


opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options (for deoplete)
opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.scrolloff = 4                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.sidescrolloff = 8               -- Columns of context
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode



cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'  -- disabled in visual mode
