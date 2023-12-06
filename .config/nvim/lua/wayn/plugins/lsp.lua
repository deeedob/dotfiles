local servers = {
    "clangd",
    "neocmake",
    "pyright",
    "lua_ls",
    "bashls",
    "marksman",
    "bufls"
}

-- LSP-related key mappings
local lsp_mappings = {
    { 'n', '<leader>lr',  ":Lspsaga rename<cr>",                                  '[R]ename' },
    { 'n', '<leader>lci', ":Lspsaga incoming_calls<cr>",                          '[I]ncoming Calls' },
    { 'n', '<leader>lco', ":Lspsaga outgoing_calls<cr>",                          '[O]outgoing Calls' },
    { 'n', '<leader>la',  ":Lspsaga code_action<cr>",                             'Code [A]ctions' },
    { 'n', '<leader>ls',  ":Lspsaga outline<cr>",                                 '[S]ymbols' },
    { 'n', '<leader>lF',  ":Lspsaga finder<cr>",                                  '[F]inder' },
    { 'n', '[d',          ":Lspsaga diagnostic_jump_prev<cr>",                    'Diagnostic Prev' },
    { 'n', ']d',          ":Lspsaga diagnostic_jump_next<cr>",                    'Diagnostic Next' },
    { 'n', 'K',           ":Lspsaga hover_doc<cr>",                               'Hover Doc' },
    { 'n', 'gp',          ":Lspsaga peek_definition<cr>",                         'Peek Definition' },
    { 'n', 'gP',          ":Lspsaga peek_type_definition<cr>",                    'Peek Type Definition' },
    { 'n', 'gd',          ":Lspsaga goto_definition<cr>",                         'Goto Definition' },
    { 'n', 'gdv',         ":vsplit | lua vim.lsp.buf.definition()<CR>",           'Goto Definition' },
    { 'n', 'gdh',         ":belowright split | lua vim.lsp.buf.definition()<CR>", 'Goto Definition' },
    { 'n', 'gD',          ":Lspsaga goto_type_definition<cr>",                    'Goto Type Definition' },
    -- { 'n', '<C-k>',       ":lua vim.lsp.buf.signature_help()<cr>", '[S]ignature' },
    -- { 'n', '<leader>li', ":lua require('telescope.builtin').lsp_implementations()<cr>", '[I]mplementation' },
    -- { 'n', "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", 'Lsp [R]eferences' },
    -- { 'n', "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", 'Goto [D]eclaration' },
}

return {
    -- Lsp Installer
    {
        "williamboman/mason.nvim",
        build = function()
            pcall(function()
                require("mason-registry").refresh()
            end)
        end
    },
    { "williamboman/mason-lspconfig.nvim" },


    -- Richer UI for LSP
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        config = function()
            require('lspsaga').setup({
                lightbulb = {
                    enable = false,
                },
                symbol_in_winbar = {
                    enable = false,
                    color_mode = false,
                    folder_level = 2,
                },
                outline = {
                    left_width = 0.7,
                    win_width = 50,
                    close_after_jump = true,
                },
            })
        end,
    },

    -- Diagnostic List
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = { "TroubleToggle" },
        keys = {
            { "<leader>lt", "<cmd>TroubleToggle<cr>", desc = "[T]rouble Toggle" },
        },
    },

    -- Easy lua-nvim-lsp setup
    {
        "folke/neodev.nvim",
        lazy = true
    },

    -- Enhanced clangd
    {
        "p00f/clangd_extensions.nvim",
        keys = {
            { "<leader>cs", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
        },
        lazy = true,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
        },
        config = function()
            require("mason").setup()
            local mason_lspconfig = require('mason-lspconfig')
            require("neodev").setup()

            -- Diagnostic style
            if require("wayn.config").lsp.icon_sign then
                for type, icon in pairs(require("wayn.config").icons.diagnostics) do
                    local hl = "DiagnosticSign" .. type
                    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
                end
            else -- Highlight with icons in sign column
                for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
                    vim.fn.sign_define("DiagnosticSign" .. diag, {
                        text = "",
                        texthl = "DiagnosticSign" .. diag,
                        linehl = "",
                        numhl = "DiagnosticSign" .. diag,
                    })
                end
            end

            -- Attach function for LSP
            local on_attach_default = function(client, bufnr)
                for _, mapping in ipairs(lsp_mappings) do
                    vim.keymap.set(mapping[1], mapping[2], mapping[3], { desc = mapping[4] })
                end

                if require("wayn.config").lsp.hover_diagnostic then
                    local lsp_hover_augroup = vim.api.nvim_create_augroup("config_lsp_hover", { clear = false })
                    vim.api.nvim_clear_autocmds({
                        buffer = bufnr,
                        group = lsp_hover_augroup
                    })

                    vim.api.nvim_create_autocmd("CursorHold", {
                        callback = function()
                            for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                                if vim.api.nvim_win_get_config(winid).relative ~= "" then return end
                            end
                            vim.diagnostic.open_float()
                        end,
                        group = lsp_hover_augroup,
                        buffer = bufnr
                    })
                end
                require("clangd_extensions").setup({
                    inlay_hints = { inline = false },
                    ast = {
                        -- requires codicons
                        role_icons = {
                            type = "",
                            declaration = "",
                            expression = "",
                            specifier = "",
                            statement = "",
                            ["template argument"] = "",
                        },
                        kind_icons = {
                            Compound = "",
                            Recovery = "",
                            TranslationUnit = "",
                            PackExpansion = "",
                            TemplateTypeParm = "",
                            TemplateTemplateParm = "",
                            TemplateParamObject = "",
                        },
                    }
                })
            end

            -- Handlers
            -- Better refresh in nvim 0.10
            vim.lsp.handlers['workspace/diagnostic/refresh'] = function(_, _, ctx)
                local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
                local bufnr = vim.api.nvim_get_current_buf()
                vim.diagnostic.reset(ns, bufnr)
                return true
            end
            -- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
            -- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

            -- Diagnostics config
            vim.diagnostic.config({
                underline = true,
                virtual_text = false,
                signs = true,
                update_in_insert = true,
                severity_sort = true,
                float = {
                    scope = "line",
                    border = "rounded",
                    header = "",
                    prefix = " ",
                    focusable = false,
                    source = "always"
                }
            })

            vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
                contents = vim.lsp.util._normalize_markdown(contents, {
                    width = vim.lsp.util._make_floating_popup_size(contents, opts),
                })

                vim.bo[bufnr].filetype = "markdown"
                vim.treesitter.start(bufnr)
                vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)

                return contents
            end

            mason_lspconfig.setup {
                ensure_installed = servers,
                automatic_installation = true,
            }

            -- Capabilities for auto-completion
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            mason_lspconfig.setup_handlers {
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach_default,
                        filetypes = (servers[server_name] or {}).filetypes,
                    }
                end,
                ["clangd"] = function()
                    local lspconfig = require("lspconfig")
                    local capacopy = vim.deepcopy(capabilities)
                    capacopy.offsetEncoding = { "utf-16" }
                    lspconfig.clangd.setup {
                        capabilities = capacopy,
                        on_attach = on_attach_default,
                        on_new_config = function(conf, dir)
                            local status, cmake = pcall(require, "cmake-tools")
                            if status then cmake.clangd_on_new_config(conf) end
                        end,
                        filetypes = { "c", "cpp", "objc", "objcpp" },
                        cmd = {
                            "clangd",
                            "--background-index",
                            "--clang-tidy",
                            "--header-insertion=never",
                            "--completion-style=detailed",
                            "--function-arg-placeholders",
                            "--cross-file-rename",
                            "--enable-config",
                            "-j=2"
                        },
                        init_options = {
                            usePlaceholders = true,
                            completeUnimported = true,
                            clangdFileStatus = true,
                        }
                    }
                end,
                -- ["neocmake"] = function()
                --     local lspconfig = require("lspconfig.configs")
                --     lspconfig.cmake.setup {
                --         capabilities = capabilities,
                --         on_attach = on_attach_default,
                --         root_dir = function(fname)
                --             return lspconfig.util.find_git_ancestor(fname)
                --         end,
                --         single_file_support = true,
                --     }
                -- end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        on_attach = on_attach_default,
                        settings = {
                            Lua = {
                                workspace = { checkThirdParty = false },
                            },
                        },
                    }
                end,
            }
            require("lspconfig").qmlls.setup({
                -- root_dir =
            })
        end
    },

}
