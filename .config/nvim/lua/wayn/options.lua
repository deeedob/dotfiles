local opt = vim.opt
local g = vim.g

-- <space> as leader
g.mapleader = ' '
g.maplocalleader = ' '

-- Cursor highlighting
opt.cursorline = true
opt.cursorlineopt = "number"
opt.cursorcolumn = false

-- Pane splitting
opt.splitright = true
opt.splitbelow = true

-- Searching
opt.smartcase = true
opt.ignorecase = true
opt.hlsearch = false

-- Make terminal support truecolor
opt.termguicolors = true

-- Make neovim use the system clipboard
opt.clipboard = 'unnamedplus'

-- Disable old vim status
opt.showmode = false

-- Set relative line numbers
opt.number = true
opt.relativenumber = false
opt.numberwidth = 2

-- Tab config
opt.expandtab = true
opt.smartindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.shiftround = true

-- Code folding
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = '1'

-- Decrease update time
opt.updatetime = 250

-- Disable swapfile
opt.swapfile = false

-- Enable persistent undo
opt.undofile = true

-- Scrolloff
opt.scrolloff = 10
opt.sidescrolloff = 10

-- Disable wrapping
opt.wrap = false


-- Have the statusline only display at the bottom
opt.laststatus = 3

-- Confirm to save changed before exiting the modified buffer
opt.confirm = true

-- Hide the command line unless needed
opt.cmdheight = 0

-- Use ripgrep as the grep program for neovim
opt.grepprg = 'rg --vimgrep'
opt.grepformat = '%f:%l:%c:%m'

-- shortmess options
opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- Enable autowrite
opt.autowrite = true

-- <.<
opt.mouse = 'a'

-- Keep cursor to the same screen line when opening a split
opt.splitkeep = 'screen'

-- Set completion options
opt.completeopt = 'menu,menuone,noselect'

-- Set key timeout to 300ms
opt.timeoutlen = 300

-- Window config
opt.winwidth = 5
opt.winminwidth = 5
opt.equalalways = false

-- Always show the signcolumn
opt.signcolumn = 'yes'

-- Formatting options
opt.formatoptions = 'jcroqlnt'

-- Put the cursor at the start of the line for large jumps
opt.startofline = true

-- Allow cursor to move where this is no text is visual block mode
opt.virtualedit = 'block'

-- Command-line completion mode
opt.wildmode = 'longest:full,full'

-- Session save options
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }

-- Enable autowrite
opt.autowrite = true

-- Maximum number of undo changes
opt.undolevels = 10000

-- Disable lsp logging
vim.lsp.set_log_level('OFF')

-- Disable certain builtins
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_logipat = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_fzf = 1

-- Disable provider warnings in the healthcheck
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
