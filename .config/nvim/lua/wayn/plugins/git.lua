return {
    -- Git
    {
        "lewis6991/gitsigns.nvim",
        init = function()
            -- load gitsigns only when a git file is opened
            vim.api.nvim_create_autocmd({ 'BufRead' }, {
                group = vim.api.nvim_create_augroup('GitSignsLazyLoad', { clear = true }),
                callback = function()
                    vim.fn.system('git -C ' .. '"' .. vim.fn.expand('%:p:h') .. '"' .. ' rev-parse')
                    if vim.v.shell_error == 0 then
                        vim.api.nvim_del_augroup_by_name('GitSignsLazyLoad')
                        vim.schedule(function()
                            require('lazy').load({ plugins = { 'gitsigns.nvim' } })
                        end)
                    end
                end,
            })
        end,
        ft = 'gitcommit',
        keys = {
            { "<leader>ugb", ":Gitsigns toggle_current_line_blame<cr>",                   "[G]it [B]lame Word" },
            { "<leader>ugh", ":Gitsigns toggle_linehl<cr>",                               "[G]it [L]ine Hl" },
            { "<leader>ugl", ":Gitsigns toggle_word_diff<cr>",                            "[G]it [W]ord Diff" },
            { ']g',          function() return require('gitsigns').next_hunk() end,       desc = 'Next hunk' },
            { '[g',          function() return require('gitsigns').prev_hunk() end,       desc = 'Previous hunk' },
            { '<leader>gl',  function() return require('gitsigns').blame_line() end,      desc = 'Open git blame' },
            { '<leader>gp',  function() return require('gitsigns').preview_hunk() end,    desc = 'Preview the hunk' },
            { '<leader>gr',  function() return require('gitsigns').reset_hunk() end,      mode = { 'n', 'v' },      desc = 'Reset the hunk' },
            { '<leader>gR',  function() return require('gitsigns').reset_buffer() end,    desc = 'Reset the buffer' },
            { '<leader>gs',  function() return require('gitsigns').stage_hunk() end,      mode = { 'n', 'v' },      desc = 'Stage the hunk' },
            { '<leader>gS',  function() return require('gitsigns').stage_buffer() end,    desc = 'Stage the buffer' },
            { '<leader>gu',  function() return require('gitsigns').undo_stage_hunk() end, desc = 'Unstage the hunk' },
            { '<leader>gd',  function() return require('gitsigns').diffthis() end,        desc = 'Open a diff' },
        },
        opts = {
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
                virt_text_priority = 100,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d>',
            max_file_length = 40000,
            attach_to_untracked = true,
        }
    },

    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit",
        keys = {
            { "<leader>gg", ":LazyGit<cr>",                  "LazyGit",  { desc = "Open Lazy Git" } },
            { "<leader>gf", ":LazyGitFilterCurrentFile<cr>", "LazyGit",  { desc = "Lazy Git Current File" } },
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
}
