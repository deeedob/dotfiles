-- local conf = require "custom.plugins.configs"
-- our package manager
-- https://github.com/wbthomason/packer.nvim#specifying-plugins
return {
  -- install lspservers, formatters, linters, debug adapters
  -- https://github.com/williamboman/mason.nvim#configuration
  ["williamboman/mason.nvim"] = {
    override_options = {
      ensure_installed = {
    --  c++
        "clangd",
  --       "clang-format",
  --       "cpptools",
  --       "codelldb",
  --       "cpplint",
  --       -- config / text
  --       "yamllint",
  --       "yamlfmt",
  --       "misspell",
  --       "textlint",
  --       "actionlint",
  --       "gitlint",
  --       -- markdown
  --       "marksman",
  --       "markdownlint",
  --       "cbfmt",
  --       -- lua
  --       "lua-language-server",
  --       "stylua",
  --       "luacheck",
  --       "luaformatter",
  --       -- web
  --       "css-lsp",
  --       "html-lsp",
  --       "djlint",
  --       "json-lsp",
  --       "fixjson",
  --       "quick-lint-js",
  --       "prettier",
  --       -- shell
  --       "shfmt",
  --       "shellcheck",
  --       "shellharden",
  --       "beautysh",

  --       -- CMake
  --       "cmake-language-server",
  --       "cmakelang",
  --       "gersemi",
  --
  --       -- python
  --       "pyright",
  --       "debugpy",
  --       "mypy",
  --       "black",
      },
    },
  },

  -- Language-Server
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.configs.lspconfig"
    end,
  },

  -- ["jose-elias-alvarez/null-ls.nvim"] = {
  --   after = "nvim-lspconfig",
  --   config = function()
  --      require "custom.plugins.configs.null-ls"
  --   end,
  -- },

  -- Markdown Preview
  -- https://github.com/iamcco/markdown-preview.nvim
  ["iamcco/markdown-preview.nvim"] = {
    ft = { "markdown" },
    run = "cd app && yarn install",
    -- cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    config = function()
      require "custom.plugins.configs.markdown_preview"
    end,
  },


  --
  -- ['Pocco81/auto-save.nvim'] = {
  --   config = function()
  --     require("auto-save").setup {
  --       -- your config goes here
  --       -- or just leave it empty :)
  --     }
  --   end,
  -- },
  --

  --
  -- ["tzachar/cmp-tabnine"] = {
  --   after = "nvim-cmp",
  --   run = "./install.sh",
  --   config = conf.tabine,
  -- },
  --
  -- -- Override plugin definition options
  -- ["goolord/alpha-nvim"] = {
  --   disable = false,
  --   cmd = "Alpha",
  -- },
}
