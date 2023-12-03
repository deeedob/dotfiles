return {
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>lf",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        config = function()
            local conform = require("conform")
            local default_clang = "file"
            local has_local_clang = vim.fn.filereadable(".clang-format") == 1
            if not has_local_clang then
                default_clang = "file:" .. os.getenv("HOME") .. "/.config/clangd/.clang-format"
            end
            conform.setup({
                formatters = {
                    clang_format = {
                        args = {
                            "-assume-filename",
                            "$FILENAME",
                            "-style",
                            default_clang,
                        },
                    },
                },
                formatters_by_ft = {
                    cpp = { "clang_format" },
                    cmake = { "cmake_format" },
                    lua = { "stylua" },
                    python = { "isort", "black" },
                    sh = { "shellharden" },

                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                    html = { "prettier" },
                },
            })
        end,
    },
}
