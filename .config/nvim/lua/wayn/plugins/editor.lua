---@diagnostic disable: missing-fields, undefined-global
return {
    -- Which Key
    {
        "folke/which-key.nvim",
        config = function()
            local wk = require("which-key")
            wk.setup {}
            wk.register {
                ['<leader>e'] = { name = '[E]xplorer' },
                ['<leader>c'] = { name = '[C]ode' },
                ['<leader>b'] = { name = '[B]uffer' },
                ['<leader>f'] = { name = '[F]ind' },
                ['<leader>d'] = { name = '[D]debug' },
                ['<leader>g'] = { name = '[G]it' },
                ['<leader>h'] = { name = '[H]arpoon' },
                ['<leader>t'] = { name = '[T]erminal' },
                ['<leader>u'] = { name = '[U]ser Interface' },
                ['<leader>l'] = { name = '[L]SP' },
            }
        end
    },

    -- file explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        keys = {
            {
                "<C-n>",
                function()
                    require("neo-tree.command").execute({ position = "left", toggle = true })
                end,
                desc = "[E]xplorer NeoTree",
            },
            {
                "<leader>eb",
                function()
                    require("neo-tree.command").execute({ source = "buffers", toggle = true })
                end,
                desc = "[B]uffers Explorer ",
            },
            {
                "<leader>eg",
                function()
                    require("neo-tree.command").execute({ source = "git_status", toggle = true })
                end,
                desc = "[G]it Explorer ",
            },
            -- Open the file under cursor
            {
                "<leader>ef",
                function()
                    local f = vim.fn.expand("%:p")
                    require("neo-tree.command").execute({
                        position = "float",
                        reveal_file = f,
                        reveal_force_cwd = true,
                    })
                end,
                desc = " [F]ile Explorer",
            },
        },
        deactivate = function() vim.cmd([[Neotree close]]) end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            close_if_last_window = true,
            sources = { "filesystem", "buffers", "git_status", "document_symbols" },
            open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline", "edgy" },
            enable_git_status = true,
            enable_diagnostics = false,
            enable_normal_mode_for_inputs = false,
            git_status_async_options = {
                batch_size = 1000,
                batch_delay = 10,
                max_lines = 10000,
            },

            source_selector = {
                winbar = true,
                sources = {
                    { source = "filesystem" },
                    { source = "buffers" },
                    { source = "git_status" },
                    { source = "document_symbols" },
                },
            },

            default_component_configs = {
                icon = {
                    folder_closed = "🗀",
                    folder_open = "",
                    folder_empty = "󱧹",
                    folder_empty_open = "󱧹",
                },
                modified = {
                    symbol = " ",
                    highlight = "NeoTreeModified",
                },
                name = { trailing_slash = true },
                git_status = {
                    symbols = {
                        -- Change type
                        added     = "", -- redundant due to colored name
                        modified  = "",
                        deleted   = "D",
                        renamed   = "R",
                        -- Status type
                        untracked = "󰰧 ",
                        unstaged  = " ",
                        staged    = " ",
                        conflict  = " ",
                        ignored   = "",
                    },
                },
                symlink_target = { enabled = false },
                -- Extra metrics
                file_size = { enabled = false },
                type = { enabled = false },
                created = { enabled = false },
                last_modified = {
                    enabled = true,
                    required_width = 70,
                },
            },
            filesystem = {
                follow_current_file = {
                    enabled = false,
                    leave_dirs_open = true,
                },
                group_empty_dirs = false,
                use_libuv_file_watcher = true,
                find_by_full_path_words = false,
                window = {
                    mappings = {
                        ["o"] = "system_open", -- Open the current file by the OS' default tool.
                        ["i"] = "run_command", -- Expand file on cmd line
                        ["D"] = "diff_files",  -- Diff two files
                        ["t"] = "trash",
                        ["/"] = "noop",
                        ["<leader>/"] = "filter_as_you_type",
                        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = false } },
                    },
                },
                commands = {
                    system_open = function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        vim.fn.jobstart({ "xdg-open", path }, { detach = true })
                    end,
                    run_command = function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        vim.api.nvim_input(": " .. path .. "<Home>")
                    end,
                    diff_files = function(state)
                        local node = state.tree:get_node()
                        local log = require("neo-tree.log")
                        state.clipboard = state.clipboard or {}
                        if diff_Node and diff_Node ~= tostring(node.id) then
                            local current_Diff = node.id
                            require("neo-tree.utils").open_file(state, diff_Node, open)
                            vim.cmd("vert diffs " .. current_Diff)
                            log.info("Diffing " .. diff_Name .. " against " .. node.name)
                            diff_Node = nil
                            current_Diff = nil
                            state.clipboard = {}
                            require("neo-tree.ui.renderer").redraw(state)
                        else
                            local existing = state.clipboard[node.id]
                            if existing and existing.action == "diff" then
                                state.clipboard[node.id] = nil
                                diff_Node = nil
                                require("neo-tree.ui.renderer").redraw(state)
                            else
                                state.clipboard[node.id] = { action = "diff", node = node }
                                diff_Name = state.clipboard[node.id].node.name
                                diff_Node = tostring(state.clipboard[node.id].node.id)
                                log.info("Diff source file " .. diff_Name)
                                require("neo-tree.ui.renderer").redraw(state)
                            end
                        end
                    end,
                    trash = function(state)
                        local inputs = require("neo-tree.ui.inputs")
                        local path = state.tree:get_node().path
                        local msg = "Are you sure you want to trash " .. path
                        inputs.confirm(msg, function(confirmed)
                            if not confirmed then
                                return
                            end
                            vim.fn.system({ "trash", vim.fn.fnameescape(path) })
                            require("neo-tree.sources.manager").refresh(state.name)
                        end)
                    end,
                },
                filtered_items = {
                    always_show = {
                        ".gitignored",
                        "CMakePresets.json",
                        ".vscode",
                    },
                },
                components = {
                    harpoon_index = function(config, node, state)
                        local Marked = require("harpoon.mark")
                        local path = node:get_id()
                        local succuss, index = pcall(Marked.get_index_of, path)
                        if succuss and index and index > 0 then
                            return {
                                text = string.format("%d ", index), -- <-- Add your favorite harpoon like arrow here
                                highlight = config.highlight or "NeoTreeDirectoryIcon",
                            }
                        else
                            return {}
                        end
                    end,
                },
                renderers = {
                    file = {
                        { "indent" },
                        { "icon" },
                        {
                            "container",
                            content = {
                                {
                                    "name",
                                    zindex = 10
                                },
                                {
                                    "symlink_target",
                                    zindex = 10,
                                    highlight = "NeoTreeSymbolicLinkTarget",
                                },
                                { "git_status",    zindex = 10, align = "right" },
                                { "modified",      zindex = 20, align = "right" },
                                { "harpoon_index", zindex = 10, align = "right" },
                                { "last_modified", zindex = 10, align = "right" },
                                { "file_size",     zindex = 10, align = "right" },
                                { "type",          zindex = 10, align = "right" },
                                { "created",       zindex = 10, align = "right" },
                            },
                        },
                    },
                },
            },
        },
    },

    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        keys = {
            { "<leader>ff", function() return require("telescope.builtin").find_files() end,               desc = "Files" },
            { "<leader>fa", function() return require('telescope').extensions.live_grep_args.live_grep_args() end,          desc = "With Args" },
            { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",                 desc = "Buffers" },
            { "<leader>fw", function() return require("telescope.builtin").live_grep({
                cwd = require("telescope.utils").buffer_dir()
            }) end,                desc = 'Words' },
            { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<cr>",                                desc = "Current Buffer" },
            { "<leader>fl", function() return require("telescope.builtin").resume() end,                   desc = "Resume" },
            { "<leader>fh", function() return require("telescope.builtin").help_tags() end,                desc = "Help" },
            { "<leader>fm", function() return require("telescope.builtin").man_pages() end,                desc = 'Man pages' },
            { "<leader>fr", function() return require("telescope.builtin").oldfiles() end,                 desc = "Recently opened" },
            { "<leader>fR", function() return require("telescope.builtin").registers() end,                desc = "Registers" },
            { "<leader>fk", function() return require("telescope.builtin").keymaps() end,                  desc = "Keymaps" },
            { "<leader>fc", function() return require("telescope.builtin").commands() end,                 desc = "Commands" },
            { "<leader>fC", function() return require("telescope.builtin").command_history() end,          desc = "Command history" },

            { "<leader>fd", function() return require("telescope.builtin").diagnostics({ bufnr = 0 }) end, desc = "Document diagnostics" },
            { "<leader>fD", function() return require("telescope.builtin").diagnostics() end,              desc = "Workspace diagnostics" },
            { "<leader>fs", function() return require("telescope.builtin").lsp_document_symbols() end,     desc = "Document symbols" },

            { "<leader>go", function() return require("telescope.builtin").git_status() end,               desc = "Seach through changed files" },
            { "<leader>gb", function() return require("telescope.builtin").git_branches() end,             desc = "Search through git branches" },
            { "<leader>gc", function() return require("telescope.builtin").git_commits() end,              desc = "Search and checkout git commits" },
            { "<leader>gO", function() return require("telescope.builtin").git_stash() end,                desc = "Search through stash" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                config = function()
                    require("telescope").load_extension("fzf")
                end,
            },
            {
                "nvim-telescope/telescope-live-grep-args.nvim",
                version = "^1.0.0",
            }
        },
        opts = function()
            -- File and text search in hidden files and directories
            local ts_conf = require("telescope.config")
            -- Clone the default Telescope configuration
            local vimgrep_arguments = { unpack(ts_conf.values.vimgrep_arguments) }
            local actions = require("telescope.actions")
            require("telescope").load_extension("live_grep_args")

            -- I want to search in hidden/dot files.
            table.insert(vimgrep_arguments, "--hidden")
            -- I don't 'ant to search in the `.git` directory.
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!**/.git/*")

            return {
                defaults = {
                    prompt_prefix = " ",
                    selection_caret = " ",
                    mappings = {
                        n = { ['q'] = actions.close }
                    },
                    vimgrep_arguments = vimgrep_arguments,
                    path_display = { "smart" },
                    file_ignore_patterns = { ".git/" },
                    layout_strategy = "horizontal",
                    layout_config = { prompt_position = "top" },
                    sorting_strategy = "ascending",
                },
                pickers = { find_files = { find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" } } },
            }
        end,
    },

    -- Buffer Management
    {
        "ThePrimeagen/harpoon",
        keys = {
            {
                "<leader>ha",
                function() require("harpoon.mark").add_file() end,
                desc = "Harpoon [A]dd",
            },
            {
                "<leader>hq",
                function() require("harpoon.ui").toggle_quick_menu() end,
                desc = "[Q]uick Menu",
            },
            {
                "[h",
                function() require("harpoon.ui").nav_next() end,
                desc = "Harpoon Next File"
            },
            {
                "]h",
                function() require("harpoon.ui").nav_prev() end,
                desc = "Harpoon Next File"
            },
            {
                "<leader>hf",
                ":Telescope harpoon marks<cr>",
                desc = "[H]arpoon Finder",
            },
            {
                "<leader>h1",
                function ()
                    require("harpoon.ui").nav_file(1)
                end,
                desc = "[H]arpoon Goto 1",
            },
            {
                "<leader>h2",
                function ()
                    require("harpoon.ui").nav_file(2)
                end,
                desc = "[H]arpoon Goto 2",
            },
            {
                "<leader>h3",
                function ()
                    require("harpoon.ui").nav_file(3)
                end,
                desc = "[H]arpoon Goto 3",
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("telescope").load_extension('harpoon')
        end
    },

    -- Terminal
    {
        "akinsho/nvim-toggleterm.lua",
        cmd = { "ToggleTerm" },
        keys = {
            { "<leader>th", "<cmd>ToggleTerm direction=horizontal size=10<cr>", desc = "Terminal Vertical" },
            { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>",   desc = "Terminal Vertical" },
            { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",              desc = "Terminal Float" },
        },
        config = function()
            require("toggleterm").setup({
                open_mapping = [[<c-\>]],
                size = 10,
                hide_numbers = true,
                shell = vim.o.shell,
                shade_terminals = true,
                shading_factor = -20,
                persist_size = true,
                start_in_insert = true,
                close_on_exit = true,
                float_opts = { border = "curved" },
            })
        end,
    },

    -- Enhanced t, T, f, F motions
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        vscode = true,
        opts = {
            mode = "fuzzy"
        },
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        },
    },

    -- Surround
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function() require("nvim-surround").setup {} end,
    },

    -- Highlight other
    {
        "RRethy/vim-illuminate",
        opts = {
            delay = 750,
            large_filie_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" },
            },
            min_count_to_highlight = 2,
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
            vim.keymap.set("n", "[r", function()
                require("illuminate").goto_prev_reference()
            end, { desc = "Prev Reference" })
            vim.keymap.set("n", "]r", function()
                require("illuminate").goto_next_reference()
            end, { desc = "Next Reference" })
        end,
    }

}
