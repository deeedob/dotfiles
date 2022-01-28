require("default_config")
require("plugins/setup")
require("plugins/configs/lsp")
require("plugins/configs/style")
require("plugins/configs/nvim-tree")
require("keymapping")


-- auto update 
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins/setup.lua source <afile> | PackerCompile
  augroup end
]])


