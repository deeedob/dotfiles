local map = vim.keymap.set

-- Window navigation
-- map("n", "<C-h>", "<C-w>h", { desc = "GoTo left window", remap = true })
-- map("n", "<C-j>", "<C-w>j", { desc = "GoTo lower window", remap = true })
-- map("n", "<C-k>", "<C-w>k", { desc = "GoTo upper window", remap = true })
-- map("n", "<C-l>", "<C-w>l", { desc = "GoTo right window", remap = true })

-- Window resize
-- map("n", "<S-Up>", "<cmd>resize +3<cr>", { desc = "Increase window height" })
-- map("n", "<S-Down>", "<cmd>resize -3<cr>", { desc = "Decrease window height" })
-- map("n", "<S-Left>", "<cmd>vertical resize -3<cr>", { desc = "Decrease window width" })
-- map("n", "<S-Right>", "<cmd>vertical resize +3<cr>", { desc = "Increase window width" })

-- Better up/down (deals with word wrap)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
map("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move up" })
map("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move down" })
-- Stay in indent mode, move text up and down
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Terminal Mode Mappings
map("t", "jk", "<c-\\><c-n>", { desc = "Enter normal mode" })
map("t", "<esc>", "<c-\\><c-n>", { desc = "Enter normal mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "GoTo left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "GoTo lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "GoTo upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "GoTo right window" })

-- Lazy left/right
map('n', 'H', '^', { desc = "Lazy left" })
map('n', 'L', '$', { desc = "Lazy left" })

map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Quit neovim
map('n', '<leader>qq', '<cmd>qa<CR>', { desc = 'Quit the current file' })

-- Quick write
map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save the current file' })

-- Quick close buffer
map('n', 'Q', ':q<cr>', { desc = 'Save the current file' })

-- Fast escape using 'jk'
map("i", "jk", "<ESC>")

-- Classic remove word
map("i","<C-BS>","<C-W>", { noremap = true })

-- Delete into blackhole register
vim.keymap.set({ 'n', 'x' }, 'x', '"_x')
vim.keymap.set({ 'n', 'x' }, 'X', '"_d')

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Previous search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Previous search result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Previous search result' })

-- Better Space as leader key
map({ 'n', 'v' }, '<Space>', '<Nop>', { expr = true, silent = true })

local function search_in_qt_docs()
    local file_extension = vim.fn.expand('%:e')
    if file_extension == 'cpp' or file_extension == 'qml' then
        local current_word = vim.fn.expand('<cword>')
        local escaped_word = vim.fn.fnameescape(current_word)
        return string.format("https://doc.qt.io/qt-6/search-results.html?q=%s", escaped_word)
    end
end

local function search_in_cppreference()
    local file_extension = vim.fn.expand('%:e')
    if file_extension == 'cpp' or file_extension == 'c' then
        local current_word = vim.fn.expand('<cword>')
        local escaped_word = vim.fn.fnameescape(current_word)
        return string.format("https://en.cppreference.com/mwiki/index.php?title=Special%%3ASearch&search=%s",
            escaped_word)
    end
end

-- Set keybindings for searching in the documentation
map('n', '<leader>kq', function() vim.fn.jobstart({ "xdg-open", search_in_qt_docs() }, { detach = true }) end,
    { desc = "Open Qt docs", silent = true })
map('n', '<leader>kr', function() vim.fn.jobstart({ "xdg-open", search_in_cppreference() }, { detach = true }) end,
    { desc = "Open cppreference", silent = true })
