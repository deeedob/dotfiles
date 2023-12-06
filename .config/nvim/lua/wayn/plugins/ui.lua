return {
    {
        "nvim-tree/nvim-web-devicons"
    },

    {
        "stevearc/dressing.nvim",
        event = "VeryLazy"
    },

    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
            { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>",          desc = "Delete other buffers" },
            { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete buffers to the right" },
            { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete buffers to the left" },
            { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
            { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
            { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
            { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
        },
        opts = {
            options = {
                separator_style = "slant",
                always_show_bufferline = false,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-Tree",
                        text_align = "center",
                        seperator = true
                    },
                },
            }
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            local cmake = require("cmake-tools")
            local icons = require("wayn.config").icons
            local col = require("wayn.config").colors.cmake_line
            local conditions = {
                buffer_not_empty = function()
                    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
                end,
                min_window_width = function(width)
                    return vim.fn.winwidth(0) > width
                end
            }
            local hide_cmake = 90
            return {
                options = {
                    theme = "auto",
                    globalstatus = true,
                    component_separators = '',
                    section_separators = { left = "", right = "" },
                    always_divide_middle = false,
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        {
                            "filename",
                            cond = conditions.buffer_not_empty,
                            color = { gui = "bold" },
                            -- padding = { left = 1, right = 2 }
                        },
                        {
                            function()
                                local b_target = cmake.get_build_target()
                                return (b_target and b_target or "X")
                            end,
                            cond = function()
                                return conditions.min_window_width(hide_cmake) and cmake.is_cmake_project()
                            end,
                            icon = icons.cmake.Gear,
                            color = { fg = col },
                            on_click = function(n, mouse)
                                if (n == 1) then
                                    if (mouse == "l") then
                                        vim.cmd("CMakeSelectBuildTarget")
                                    end
                                end
                            end
                        },
                        {
                            function()
                                local l_target = cmake.get_launch_target()
                                return (l_target and l_target or "X")
                            end,
                            icon = icons.cmake.Run,
                            cond = function()
                                return conditions.min_window_width(hide_cmake) and cmake.is_cmake_project()
                            end,
                            color = { fg = col },
                            on_click = function(n, mouse)
                                if (n == 1) then
                                    if (mouse == "l") then
                                        vim.cmd("CMakeSelectLaunchTarget")
                                    end
                                end
                            end
                        },
                        -- Middle
                        {
                            "%=",
                            cond = function()
                                return conditions.min_window_width(60)
                            end,
                        },

                        {
                            function()
                                local msg = 'No Active Lsp'
                                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                                local clients = vim.lsp.get_active_clients()
                                if next(clients) == nil then
                                    return msg
                                end
                                for _, client in ipairs(clients) do
                                    local filetypes = client.config.filetypes
                                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                        return client.name
                                    end
                                end
                                return msg
                            end,
                            icon = '',
                            color = { gui = 'bold' },
                            cond = function()
                                return conditions.min_window_width(60)
                            end,
                        }
                    },
                    lualine_x = {
                        {
                            function()
                                local kit = cmake.get_kit()
                                return (kit and kit or "X")
                            end,
                            icon = icons.cmake.Arch,
                            cond = function()
                                return conditions.min_window_width(hide_cmake) and cmake.is_cmake_project() and
                                    not cmake.has_cmake_preset()
                            end,
                            color = { fg = col },
                            on_click = function(n, mouse)
                                if (n == 1) then
                                    if (mouse == "l") then
                                        vim.cmd("CMakeSelectKit")
                                    end
                                end
                            end
                        },
                        {
                            function()
                                local c_preset = cmake.get_configure_preset()
                                return (c_preset and c_preset or "X")
                            end,
                            icon = icons.cmake.Build,
                            cond = function()
                                return conditions.min_window_width(hide_cmake) and cmake.is_cmake_project() and
                                    cmake.has_cmake_preset()
                            end,
                            color = { fg = col },
                            on_click = function(n, mouse)
                                if (n == 1) then
                                    if (mouse == "l") then
                                        vim.cmd("CMakeSelectConfigurePreset")
                                    end
                                end
                            end
                        },
                        {
                            function()
                                local type = cmake.get_build_type()
                                return " " .. (type and type or "")
                            end,
                            icon = icons.cmake.Build,
                            cond = function()
                                return conditions.min_window_width(hide_cmake) and cmake.is_cmake_project() and
                                    not cmake.has_cmake_preset()
                            end,
                            color = { fg = col },
                            on_click = function(n, mouse)
                                if (n == 1) then
                                    if (mouse == "l") then
                                        vim.cmd("CMakeSelectBuildType")
                                    end
                                end
                            end
                        },
                        {
                            function()
                                local b_preset = cmake.get_build_preset()
                                return (b_preset and b_preset or "X")
                            end,
                            cond = function()
                                return conditions.min_window_width(hide_cmake) and cmake.is_cmake_project() and
                                    cmake.has_cmake_preset()
                            end,
                            color = { fg = col },
                            on_click = function(n, mouse)
                                if (n == 1) then
                                    if (mouse == "l") then
                                        vim.cmd("CMakeSelectBuildPreset")
                                    end
                                end
                            end
                        },
                    },
                    lualine_y = {
                        {
                            "diagnostics",
                            symbols = {
                                error = icons.diagnostics.Error,
                                warn = icons.diagnostics.Warn,
                                info = icons.diagnostics.Info,
                                hint = icons.diagnostics.Hint,
                            },
                        },
                        {
                            "diff",
                            symbols = {
                                added = icons.git.added,
                                modified = icons.git.modified,
                                removed = icons.git.removed,
                            },
                            source = function()
                                local gitsigns = vim.b.gitsigns_status_dict
                                if gitsigns then
                                    return {
                                        added = gitsigns.added,
                                        modified = gitsigns.changed,
                                        removed = gitsigns.removed,
                                    }
                                end
                            end,
                        },
                    },
                    lualine_z = {
                        { "progress" },
                    },
                },
                extensions = { "toggleterm", "lazy", "neo-tree" }
            }
        end
    },
    -- Smoth scrolling
    {
        "psliwka/vim-smoothie",
        event = "BufRead",
    },

    -- enable noice cmdline if not in neovide
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        cond = not vim.g.neovide,
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            cmdline = {
                enabled = true,
                view = "cmdline_popup",
            },
            messages = { enabled = false, },
            popupmenu = { enabled = false, },
            notify = { enabled = false },
            lsp = {
                progress = { enabled = false, },
                hover = { enabled = false, },
                signature = { enabled = false, },
                message = { enabled = false },
            },
            views = {
                cmdline_popup = {
                    position = { row = 10, col = "50%", },
                    size = { width = 60, height = "auto", },
                },
                popupmenu = {
                    relative = "editor",
                    position = { row = 12, col = "50%", },
                    size = { width = 60, height = 10, },
                    border = { style = "rounded", padding = { 0, 1 }, },
                    win_options = {
                        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                    },
                },
            },
        }
    },
    -- enable fine cmdline if in neovide
    {
        "VonHeikemen/fine-cmdline.nvim",
        cond = function() return vim.g.neovide end,
        config = function() vim.api.nvim_set_keymap("n", ":", "<cmd>FineCmdline<CR>", { noremap = true }) end,
        dependencies = { "MunifTanjim/nui.nvim" },
        lazy = false,
    },

    {
        "mrjones2014/smart-splits.nvim",
        lazy = false,
        opts = { at_edge = "stop" },
        build = "./kitty/install-kittens.bash",
        keys = {
            { "<S-Left>",             function() require("smart-splits").resize_left() end },
            { "<S-Right>",             function() require("smart-splits").resize_right() end },
            { "<S-Up>",             function() require("smart-splits").resize_up() end },
            { "<S-Down>",             function() require("smart-splits").resize_down() end },
            -- moving between splits
            { "<C-h>",             function() require("smart-splits").move_cursor_left() end },
            { "<C-j>",             function() require("smart-splits").move_cursor_down() end },
            { "<C-k>",             function() require("smart-splits").move_cursor_up() end },
            { "<C-l>",             function() require("smart-splits").move_cursor_right() end },
            -- swapping buffers between windows
            { "<leader>bsh", function() require("smart-splits").swap_buf_left() end,    desc = "swap left" },
            { "<leader>bsj", function() require("smart-splits").swap_buf_down() end,    desc = "swap down" },
            { "<leader>bsk", function() require("smart-splits").swap_buf_up() end,      desc = "swap up" },
            { "<leader>bsl", function() require("smart-splits").swap_buf_right() end,   desc = "swap right" },

            { "<leader>bsh", ":sp<cr>",   desc = "split horiz" },
            { "<leader>bsv", ":vsp<cr>", desc = "split vertical" },
        },
    }

}
