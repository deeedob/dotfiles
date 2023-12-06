---@diagnostic disable: missing-fields
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Get lua user config directory
local nvim_config_path = vim.fn.stdpath("config")

return {
    -- Completion
    -- {
    --     "zbirenbaum/copilot.lua",
    --     cmd = "Copilot",
    --     build = ":Copilot auth",
    --     opts = function()
    --         vim.cmd('imap <silent><script><expr> <C-CR> copilot#Accept("\\<CR>")')
    --         vim.g.copilot_no_tab_map = true
    --         return
    --         {
    --             suggestion = { enabled = false },
    --             panel = { enabled = false },
    --             filetypes = {
    --                 markdown = true,
    --                 help = true,
    --             },
    --         }
    --     end
    -- },
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = "InsertEnter",
        dependencies = {
            "onsails/lspkind.nvim", -- icons
            "neovim/nvim-lspconfig",

            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer",

            -- "zbirenbaum/copilot-cmp",

            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "p00f/clangd_extensions.nvim",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require('lspkind')
            -- Icons
            require('luasnip.loaders.from_vscode').lazy_load()
            luasnip.config.setup({
                history = true,
                update_events = "TextChanged,TextChangedI"
            })
            -- Copilot Cmp
            -- require("copilot").setup({
            --     suggestion = { enabled = false },
            --     panel = { enabled = false },
            -- })
            -- lspkind.init({ symbol_map = { Copilot = "", } })
            -- vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#787575" })
            -- require("copilot_cmp").setup()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                completion = {
                    completeopt = "menu,menuone,noinsert",
                    -- autocomplete = false
                },
                view = { entries = "custom" },
                mapping = {
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ["<C-CR>"] = function(fallback)
                        cmp.abort()
                        fallback()
                    end,
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                window = {
                    completion = cmp.config.window.bordered({
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Cursor,Search:None",
                        side_padding = 0,
                    }),
                    documentation = cmp.config.window.bordered({
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Cursor,Search:None",
                    })
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind = require("lspkind").cmp_format({
                            mode = "symbol_text", maxwidth = 50
                        })(entry, vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. " "
                        kind.menu = "    (" .. (strings[2] or "") .. ")"
                        return kind
                    end
                },
                sources = {
                    {
                        name = "nvim_lsp",
                        -- entry_filter = function(entry) return entry.kind ~= "Text" end,
                    },
                    { name = "luasnip" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "path",                   option = { trailing_slash = true } },
                    -- { name = 'copilot' },
                },
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.recently_used,
                        require("clangd_extensions.cmp_scores"),
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                experimental = {
                    ghost_text = {
                        hl_group = "Comment",
                    },
                },
            })

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path', option = { trailing_slash = true } }
                }, {
                    { name = 'cmdline' }
                })
            })
        end
    },

    {
        "Civitasv/cmake-tools.nvim",
        ft = { "cmake", "cpp" },
        keys = {
            { "<leader>cb",  ":CMakeBuild<CR>",              desc = "CMake Build" },
            { "<leader>cfb", ":CMakeBuild!<CR>",             desc = "CMake Force Build" },
            { "<leader>cg",  ":CMakeGenerate<CR>",           desc = "CMake Configure" },
            { "<leader>cfg", ":CMakeGenerate!<CR>",          desc = "CMake Force Configure" },
            { "<leader>cr",  ":CMakeRun<CR>",                desc = "CMake Run" },
            { "<leader>cd",  ":CMakeDebug<CR>",              desc = "CMake Debug" },
            { "<leader>ck",  ":CMakeStop<CR>",               desc = "CMake Kill" },
            { "<leader>cc",  ":CMakeClean<CR>",              desc = "CMake Clean" },

            { "<leader>csr", ":CMakeSelectLaunchTarget<CR>", desc = "CMake Select Run Target" },
            { "<leader>csb", ":CMakeSelectBuildTarget<CR>",  desc = "CMake Select Build Target" },
            { "<leader>cst", ":CMakeSelectBuildType<CR>",    desc = "CMake Select Build Type" },
            { "<leader>csk", ":CMakeSelectKit<CR>",          desc = "CMake Select Kit" },
            { "<leader>csf", ":CMakeShowTargetFiles<CR>",    desc = "CMake Show Target's files" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("cmake-tools").setup {
                cmake_command = "cmake",
                cmake_regenerate_on_save = true,
                -- cmake_generate_options = { "" },
                cmake_build_options = { "-j4" },
                cmake_build_directory = "cmake-build/${variant:buildType}",
                cmake_soft_link_compile_commands = false,
                cmake_compile_commands_from_lsp = true,
                cmake_kits_path = nvim_config_path .. "/cmake-kits.json",
                cmake_dap_configuration = {
                    name = "cpp",
                    type = "codelldb",
                    request = "launch",
                    stopOnEntry = false,
                    runInTerminal = true,
                    console = "integratedTerminal",
                },
                cmake_executor = {
                    name = "quickfix",
                    opts = {},
                    default_opts = {
                        quickfix = {
                            show = "always",         -- "always", "only_on_error"
                            position = "belowright", -- "bottom", "top"
                            size = 10,
                        },
                        terminal = {},
                    },
                },
                cmake_terminal = {
                    name = "terminal",
                    opts = {
                        name = "Main Terminal",
                        prefix_name = "[CMake]: ",
                        split_direction = "horizontal", -- "horizontal", "vertical"
                        split_size = 11,

                        -- Window handling
                        single_terminal_per_instance = true,  -- Single viewport, multiple windows
                        single_terminal_per_tab = true,       -- Single viewport per tab
                        keep_terminal_static_location = true, -- Static location of the viewport if avialable

                        -- Running Tasks
                        start_insert_in_launch_task = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
                        start_insert_in_other_tasks = false, -- If you want to enter terminal with :startinsert upon launching all other cmake tasks in the terminal. Generally set as false
                        focus_on_main_terminal = false,      -- Focus on cmake terminal when cmake task is launched. Only used if executor is terminal.
                        focus_on_launch_terminal = false,    -- Focus on cmake launch terminal when executable target in launched.
                    },
                },
                cmake_notifications = {
                    enabled = false,
                }
            }
        end,
    },

    {
        "gauteh/vim-cppman",
        ft = { "c", "cpp", "objc", "objcpp", "cuda" },
        keys = {
            {
                "KK",
                function()
                    local word = vim.fn.expand("<cword>")
                    local escaped_word = vim.fn.fnameescape(word)
                    vim.cmd("Cppman " .. escaped_word)
                end,
                desc = "Open cppman",

            }
        },
    },

    -- Comment Lines with gcc, gcb (line, block)
    {
        "numToStr/Comment.nvim",
        opts = {
            ignore = '^$',
            mappings = {
                basic = true,
                extra = false,
            }
        }
    },

    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },

    {
        "m4xshen/autoclose.nvim",
        opts = {
            options = {
                disabled_filetypes = { "text" },
                pair_spaces = true,
            },

            keys = {
                ["'"] = {
                    escape = true,
                    close = true,
                    pair = "''",
                    disabled_filetypes = { "markdown" },
                },
                ["`"] = { escape = false, close = true, pair = "``" },
                ["<"] = {
                    escape = false,
                    close = true,
                    pair = "<>",
                    enabled_filetypes = { "cpp" },
                },
            },

        }
    },
    {
        "lukas-reineke/virt-column.nvim",
        opts = {},
    },
}
