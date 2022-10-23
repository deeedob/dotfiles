-- First read our docs (completely) then check the example_config repo

local M = {}
-- local plugOv = require "custom.plugins.override"
--
-- M.options = {
--   nvChad = {
--     update_url = "https://github.com/NvChad/NvChad",
--     update_branch = "main",
--   },
-- }
--
M.ui = {
  theme_toggle = { "kanagawa", "onedark" },
  theme = "onedark",
  transparency = true,
}

M.plugins = require "custom.plugins"

-- M.plugins = {
--   user = require "custom.plugins.init",
-- --
-- --   options = {
-- --     lspconfig = {
-- --       setup_lspconf = "custom.plugins.lspconfig",
-- --     },
-- --   },
--
--   override = {
--     ["nvim-treesitter/nvim-treesitter"] = plugOv.treesitter,
-- --     ["kyazdani42/nvim-tree.lua"] = plugin_conf.nvimtree,
-- --     ["NvChad/nvterm"] = plugin_conf.nvterm,
-- --     ["tzachar/cmp-tabnine"] = plugin_conf.tabnine,
-- --     ["hrsh7th/nvim-cmp"] = plugin_conf.cmp,
--   }
-- }

M.mappins = require "custom.mappings"

return M
