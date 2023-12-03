return {
    {
        "tidalcycles/vim-tidal",
        config = function()
            vim.g.tidal_target = "terminal"
            vim.g.tidal_sc_enable = 1
        end,
        ft = "tidal",
    },
}
