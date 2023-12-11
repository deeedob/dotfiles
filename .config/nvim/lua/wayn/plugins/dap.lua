return {
    "mfussenegger/nvim-dap",

    dependencies = {

        -- fancy UI for the debugger
        {
            "rcarriga/nvim-dap-ui",
            -- stylua: ignore
            keys = {
                { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
                { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
            },
            opts = {
                expand_lines = true,
                mappings = {
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                windows = { indent = 1 },
                render = {
                    max_type_length = nil,
                },
            },
            config = function(_, opts)
                -- setup dap config by VsCode launch.json file
                require("dap.ext.vscode").load_launchjs()
                local dap = require("dap")
                local dapui = require("dapui")
                local lsp_hover_augroup = vim.api.nvim_create_augroup("config_lsp_hover", { clear = false })
                local keymap_restore = {}

                dapui.setup(opts)
                dap.listeners.after.event_initialized["dapui_config"] = function()
                    dapui.open({})
                end
                dap.listeners.before.event_terminated["dapui_config"] = function()
                    dapui.close({})
                end
                dap.listeners.before.event_exited["dapui_config"] = function()
                    dapui.close({})
                end
                dap.listeners.after['event_initialized']['me'] = function()
                    -- TODO: Sync with lsp.lua
                    for _, buf in pairs(vim.api.nvim_list_bufs()) do
                        vim.api.nvim_clear_autocmds({
                            buffer = buf,
                            group = lsp_hover_augroup
                        })

                        local keymaps = vim.api.nvim_buf_get_keymap(buf, 'n')
                        for _, keymap in pairs(keymaps) do
                            if keymap.lhs == "K" then
                                table.insert(keymap_restore, keymap)
                                vim.api.nvim_buf_del_keymap(buf, 'n', 'K')
                            end
                        end
                    end
                    vim.api.nvim_set_keymap(
                        'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
                end

                dap.listeners.after['event_terminated']['me'] = function()
                    -- TODO: Sync with lsp.lua
                    for _, buf in pairs(vim.api.nvim_list_bufs()) do
                        vim.api.nvim_create_autocmd("CursorHold", {
                            callback = function()
                                for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                                    if vim.api.nvim_win_get_config(winid).relative ~= "" then return end
                                end
                                vim.diagnostic.open_float()
                            end,
                            group = lsp_hover_augroup,
                            buffer = buf
                        })
                    end
                    for _, keymap in pairs(keymap_restore) do
                        vim.api.nvim_buf_set_keymap(
                            keymap.buffer,
                            keymap.mode,
                            keymap.lhs,
                            keymap.rhs,
                            { silent = keymap.silent == 1 }
                        )
                    end
                    keymap_restore = {}
                end
            end,
        },

        -- virtual text for the debugger
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {},
        },

        -- mason.nvim integration
        {
            "jay-babu/mason-nvim-dap.nvim",
            dependencies = "mason.nvim",
            cmd = { "DapInstall", "DapUninstall" },
            opts = {
                automatic_installation = true,
                -- see mason-nvim-dap README for more information
                handlers = {
                    function(config)
                        require("mason-nvim-dap").default_setup(config);
                    end,
                    cppdbg = function(config)
                        local pickers = require("telescope.pickers")
                        local finders = require("telescope.finders")
                        local conf = require("telescope.config").values
                        local actions = require("telescope.actions")
                        local action_state = require("telescope.actions.state")
                        config.configurations = {
                            {
                                name = "GDB: Attach",
                                type = "cppdbg",
                                request = "attach",
                                cwd = "${workspaceFolder}",
                                -- processId = require('dap.utils').pick_process,
                                stopOnEntry = true,
                                setupCommands = {
                                    {
                                        text = '-enable-pretty-printing',
                                        description = 'enable pretty printing',
                                        ignoreFailures = false
                                    },
                                },
                            },
                            {
                                name = "GDB: Launch",
                                type = "codelldb",
                                request = "launch",
                                cwd = "${workspaceFolder}",
                                program = function()
                                    return coroutine.create(function(coro)
                                        local opts = {}
                                        pickers
                                            .new(opts, {
                                                prompt_title = "Path to executable",
                                                finder = finders.new_oneshot_job(
                                                    { "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
                                                sorter = conf.generic_sorter(opts),
                                                attach_mappings = function(buffer_number)
                                                    actions.select_default:replace(function()
                                                        actions.close(buffer_number)
                                                        coroutine.resume(coro, action_state.get_selected_entry()[1])
                                                    end)
                                                    return true
                                                end,
                                            })
                                            :find()
                                    end)
                                end,
                                setupCommands = {
                                    {
                                        text = '-enable-pretty-printing',
                                        description = 'enable pretty printing',
                                        ignoreFailures = false
                                    },
                                },
                            },

                        }
                        require("mason-nvim-dap").default_setup(config)
                    end,
                    -- https://github.com/vadimcn/codelldb/blob/master/MANUAL.md
                    codelldb = function(config)
                        local pickers = require("telescope.pickers")
                        local finders = require("telescope.finders")
                        local conf = require("telescope.config").values
                        local actions = require("telescope.actions")
                        local action_state = require("telescope.actions.state")
                        config.configurations = {
                            {
                                name = "LLDB: Attach",
                                type = "codelldb",
                                request = "attach",
                                pid = require('dap.utils').pick_process,
                                args = {},
                                stopOnEntry = false,
                                env = function()
                                    local variables = {}
                                    for k, v in pairs(vim.fn.environ()) do
                                        table.insert(variables, string.format("%s=%s", k, v))
                                    end
                                    return variables
                                end,
                            },
                            {
                                name = "LLDB: Launch",
                                type = "codelldb",
                                request = "launch",
                                cwd = "${workspaceFolder}",
                                program = function()
                                    return coroutine.create(function(coro)
                                        local opts = {}
                                        pickers
                                            .new(opts, {
                                                prompt_title = "Path to executable",
                                                finder = finders.new_oneshot_job(
                                                    { "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
                                                sorter = conf.generic_sorter(opts),
                                                attach_mappings = function(buffer_number)
                                                    actions.select_default:replace(function()
                                                        actions.close(buffer_number)
                                                        coroutine.resume(coro, action_state.get_selected_entry()[1])
                                                    end)
                                                    return true
                                                end,
                                            })
                                            :find()
                                    end)
                                end,
                            },
                        }
                        require("mason-nvim-dap").default_setup(config)
                    end,
                },
                ensure_installed = {
                    "codelldb", "cppdbg", "bash-debug-adapter"
                },
            },
        },
    },

    -- stylua: ignore
    keys = {
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
        { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
        { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
        { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
        { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
        { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
        { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
        { "<F11>",      function() require("dap").step_into() end,                                            desc = "Step Into" },
        { "<F10>",      function() require("dap").step_over() end,                                            desc = "Step Over" },
        { "<F9>",       function() require("dap").step_out() end,                                             desc = "Step Out" },
        { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
        { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
        { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    },

    config = function()
        local sc = vim.api.nvim_get_hl(0, { name = "SignColumn", create = false })
        local ap = vim.api.nvim_get_hl(0, { name = "PreProc", create = false })

        vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
        vim.api.nvim_set_hl(0, "DapIconGutter", { fg = ap.fg , bg = sc.bg })
        local icons = require("wayn.config").icons

        for name, sign in pairs(icons.dap) do
            sign = type(sign) == "table" and sign or { sign }
            vim.fn.sign_define(
                "Dap" .. name,
                { text = sign[1], texthl = sign[2] or "DapIconGutter", linehl = "", numhl = "" }
            )
        end
    end,
}
