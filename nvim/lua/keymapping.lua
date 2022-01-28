local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- keymapping

--lsp keymapping
map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

--nvim tree
map('n', '<C-n>', ':NvimTreeToggle <CR>')
map('n', '<leader>e', ':NvimTreeFocus <CR>')
map('n', '<C-r>', ':NvimTreeRefresh <CR>')

-- buffer mappings
local opts = { noremap = true, silent = true}
-- Move to previous/next
map('n', '<A-Tab>', ':BufferPrevious<CR>', opts)
map('n', '<Tab>', ':BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
map('n', '<A->>', ' :BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
map('n', '<A-8>',':BufferGoto 8<CR>', opts)
map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
map('n', '<A-0>', ':BufferLast<CR>', opts)
-- Close buffer
map('n', '<A-c>', ':BufferClose<CR>', opts)
map('n', '<C-p>', ':BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', opts)

-- remap split navigation to just CTRL + hjkl
map('', '<C-h>', '<C-w>h',opts)
map('', '<C-j>', '<C-w>j',opts)
map('', '<C-k>', '<C-w>k',opts)
map('', '<C-l>', '<C-w>l',opts)
map('', '<C-w>', '<C-w>q',opts)
-- open split terminal
-- close split window with : C-w + q
map('n', '<C-t>', ':vsplit term://zsh<CR>')
map('n', '<leader>t', ':split term://zsh<CR>')
map('n', '<C-Left>', ':vert resize +3<CR>');
map('n', '<C-Right>', ':vert resize -3<CR>');
map('n', '<C-Up>', ':resize +3<CR>');
map('n', '<C-Down>', ':resize -3<CR>');

-- config mappings
map("n", "<Esc>", ":noh <CR>")      -- no highliting
map('', '<leader>c', '"+y')       -- Copy to clipboard in normal, visual, select and operator modes
map('i', '<C-u>', '<C-g>u<C-u>')  -- Make <C-u> undo-friendly
map('i', '<C-w>', '<C-g>u<C-w>')  -- Make <C-w> undo-friendly
map('i', 'jj', '<Esc>')         -- press jj in insert mode to get to command mode

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
--map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

--   n normal mode
--   i insert mode
--   v visual mode
--  https://neovim.io/doc/user/intro.html#key-notation
--  <S-...> Shift
--  <C-...>  CTRL
--  <M-...>  alt/meta
--  <A-...>  alt/meta
--  <D-...>  super/"leader"
--
--
