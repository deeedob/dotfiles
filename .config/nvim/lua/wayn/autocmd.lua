local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
    return vim.api.nvim_create_augroup("wayn_" .. name, { clear = true })
end

-- Quick close
autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = { "help", "man", "lspinfo", "checkhealth", "qf", "query", "notify" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- Remove trailing whitespaces
autocmd("BufWritePre", { group = augroup("trailing_space"), command = "%s/\\s\\+$//e" })

-- Rebalance window
autocmd("VimResized", {
    group = augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- Never insert line as a comment when using 'o' to enter insert mode
autocmd("BufWinEnter", {
    group = augroup("no_comment_on_o"),
    command = "setlocal formatoptions-=o"
})

-- Rebalance window
autocmd("VimResized", {
    group = augroup("resize_splits"),
    command = "tabdo wincmd =",
})

-- Fancy yank
autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank({
            timeout = 225,
        })
    end,
})

-- Never insert line as a comment when using 'o' to enter insert mode
autocmd("BufWinEnter", { group = augroup("no_comment_on_o"), command = "setlocal formatoptions-=o" })

-- Go to the last loc when opening a buffer
autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function(event)
        local exclude = { "gitcommit", "NeogitCommitMessage" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
            return
        end
        vim.b[buf].last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Check if the file needs to be reloaded when it's changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    command = "checktime"
})

-- Add filetypes
vim.filetype.add({
    extension = { rasi = "rasi" },
    pattern = {
        [".*/waybar/config"] = "jsonc",
        [".*/mako/config"] = "dosini",
        [".*/kitty/*.conf"] = "bash",
    },
})

-- only highlight when searching
vim.api.nvim_create_autocmd("CmdlineEnter", {
   callback = function()
      local cmd = vim.v.event.cmdtype
      if cmd == "/" or cmd == "?" then
         vim.opt.hlsearch = true
      end
   end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
   callback = function()
      local cmd = vim.v.event.cmdtype
      if cmd == "/" or cmd == "?" then
         vim.opt.hlsearch = false
      end
   end,
})
