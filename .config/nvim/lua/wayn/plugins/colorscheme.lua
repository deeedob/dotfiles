local scheme = require("wayn.config").colorscheme

return {
    {
        "sainnhe/gruvbox-material",
        cond = scheme == "gruvbox-material",
        config = function()
            vim.cmd("colorscheme gruvbox-material")
        end
    },
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        cond = scheme == "kanagawa",
        config = function()
            require("kanagawa").setup({
                colors = {
                    colors = {
                        theme = {
                            all = {
                                ui = {
                                    bg_gutter = "none",
                                },
                            },
                        },
                    },
                },
                overrides = function(colors)
                    local cols = require("kanagawa.colors").setup()
                    local pal = colors.palette
                    local theme = cols.theme
                    return {
                        CursorLine = { bg = "None" },
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },

                        -- Save an hlgroup with dark background and dimmed foreground
                        -- so that you can use it where your still want darker windows.
                        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                        -- Popular plugins that open floats will link to NormalFloat by default;
                        -- set their background accordingly if you wish to keep them dark and borderless
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                        TelescopeTitle = { fg = theme.ui.special, bold = true },
                        TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                        TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                        TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                        TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                        TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

                        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                        PmenuSbar = { bg = theme.ui.bg_m1 },
                        PmenuThumb = { bg = theme.ui.bg_p2 },
                        CmpItemAbbrDeprecated = { fg = theme.syn.comment, strikethrough = false },

                        -- TODO: add nvim support: https://github.com/loctvl842/monokai-pro.nvim/blob/master/lua/monokai-pro/theme/plugins/neo-tree.lua
                        NeoTreeDirectoryIcon = { fg = pal.dragonAsh },
                        NeoTreeGitAdded = { fg = pal.dragonOrange },
                        NeoTreeDirectoryName = { fg = theme.ui.fg_dim },
                    }
                end,
            })
            vim.cmd("colorscheme kanagawa-dragon")
        end,
    },

    {
        "sainnhe/everforest",
        cond = scheme == "everforest",
        config = function()
            vim.cmd("colorscheme everforest")
        end,
    }

}
