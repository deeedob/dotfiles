return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.indent = { enabled = false }
    opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
      -- general
      "vim",
      "fish",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "json",
      "markdown",
      "markdown_inline",
      "regex",
      "supercollider",
      "toml",
      "yaml",
      "qmldir",
      "comment",
      "html",
      "diff",
      -- langs
      "c",
      "arduino",
      "cmake",
      "cpp",
      "glsl",
      "lua",
      "ninja",
      "python",
      "qmljs",
      "css",
      "javascript",
      "bash",
      "rust",
    })
  end,
}
