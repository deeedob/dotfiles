-- our package manager
-- https://github.com/wbthomason/packer.nvim#specifying-plugins
return {
  -- Syntax highlighting
  -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = {
      ensure_installed = { "cpp", "c", "cmake", "bash", "comment", "css", "diff",
        "gitattributes", "gitignore", "glsl", "html", "javascript", "json", "markdown",
        "ninja", "python", "qmljs", "regex", "rust", "scss", "sxhkdrc", "toml", "yaml", "lua" },
    },
  },
  -- install lspservers, formatters, linters, debug adapters
  -- https://github.com/williamboman/mason.nvim#configuration
  ["williamboman/mason.nvim"] = {
    override_options = {
      ensure_installed = {
        --  c++
        "clangd",
        "cpplint",
        "clang-format",
        -- cmake
        "cmake-language-server",
        "cmakelang",
        -- bash
        "bash-language-server",
        "shellharden",
        "shellcheck",
        "shfmt",
        -- python
        "python-lsp-server",
        "flake8",
        "mypy",
        -- lua
        "lua-language-server",
        "luacheck",
        -- text / md
        "alex",
        "markdownlint",
        "misspell",
        "proselint",
        "write-good",
      },
    },
  },

  -- Language-Server configs
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.configs.lspconfig"
    end,
  },
  -- LSP disgnostics, code actions, formatting, hover, completions
  -- https://github.com/jose-elias-alvarez/null-ls.nvim
  -- https://github.com/dense-analysis/ale/blob/master/supported-tools.md
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
       require "custom.plugins.configs.null-ls"
    end,
  },

  -- https://github.com/p00f/clangd_extensions.nvim
  -- ["p00f/clangd_extensions.nvim"] = {
  --   config = function()
  --     require "custom.plugins.configs.clangd_extensions"
  --   end,
  -- },

  ["cdelledonne/vim-cmake"] = {},

  -- Markdown Preview
  -- https://github.com/iamcco/markdown-preview.nvim
  ["iamcco/markdown-preview.nvim"] = {
    ft = { "markdown" },
    run = "cd app && yarn install",
    setup = function ()
      local g = vim.g
      g.mkdp_auto_start = 0
      g.mkdp_auto_close = 0
      g.mkdp_page_title = "${name}.md"
    end,
  },

  ['Pocco81/auto-save.nvim'] = {
    config = function()
      require("auto-save").setup {
        -- your config goes here
        -- or just leave it empty :)
      }
    end,
  },

  -- Override plugin definition options
  ["goolord/alpha-nvim"] = {
    disable = false,
    cmd = "Alpha",
  },
}
