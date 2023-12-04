-- Lazy is our plugin manager of choice
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("wayn.options")
require("wayn.mappings")
require("wayn.autocmd")
require("wayn.usercmd")

-- Load all lua/plugins/*.lua
local lazy_opts = {
    ui = {
        size = { width = 0.8, height = 0.7 },
        border = "single"
    },
    change_detection = {
        enabled = false,
        notify = false,
    },
}
require("lazy").setup("wayn.plugins", lazy_opts)

-- Clear deprecated highlights (had problems in C code with typedef)
-- vim.cmd [[
--     hi! clear DiagnosticDeprecated
-- ]]
