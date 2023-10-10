local utils = require "astronvim.utils"
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed =
          utils.list_insert_unique(opts.ensure_installed, { "bash", "markdown", "markdown_inline", "regex", "vim" })
      end
    end,
  },

  {
    "preservim/tagbar",
    lazy = false,
  },
  -- call hierarchy
  {
    "ldelossa/litee-calltree.nvim",
    dependencies = { "ldelossa/litee.nvim" },
    ft = { "cpp", "python", "lua" },
    config = function()
      require("litee.lib").setup()
      require("litee.calltree").setup()
    end,
  },
  -- Press 'KK' to open cpp docs
  {
    "gauteh/vim-cppman",
    ft = { "cpp" },
    lazy = true,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function() require("nvim-surround").setup {} end,
  },
  {
    "tyru/open-browser-github.vim",
    dependencies = { "tyru/open-browser.vim" },
    lazy = true,
    cmd = {
      "OpenBrowser",
      "OpenBrowserSearch",
      "OpenBrowserSmartSearch",
      "OpenGithubCommit",
      "OpenGithubFile",
      "OpenGithubIssue",
      "OpenGithubProject",
      "OpenGithubPullReq",
    },
  },
  -- enable noice cmdline if not in neovide
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    cond = not vim.g.neovide,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = function(_, opts)
      return utils.extend_tbl(opts, {
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
        },
        messages = { enabled = false, },
        popupmenu = { enabled = true, },
        notify = { enabled = false },
        lsp = {
          progress = { enabled = false, },
          hover = { enabled = false, },
          signature = { enabled = false, },
          message = { enabled = false },
        },
        presets = {
          inc_rename = utils.is_available "inc-rename.nvim",
        },
        views = {
          cmdline_popup = {
            position = { row = 10, col = "50%", },
            size = { width = 60, height = "auto", },
          },
          popupmenu = {
            relative = "editor",
            position = { row =  12, col = "50%", },
            size = { width = 60, height = 10, },
            border = { style = "rounded", padding = { 0, 1 }, },
            win_options = {
              winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            },
          },
        },
      })
    end,
  },
  -- enable fine cmdline if in neovide
  {
    "VonHeikemen/fine-cmdline.nvim",
    cond = function() return vim.g.neovide end,
    config = function() vim.api.nvim_set_keymap("n", ":", "<cmd>FineCmdline<CR>", { noremap = true }) end,
    dependencies = { "MunifTanjim/nui.nvim" },
    lazy = false,
  },
  -- TODO: Find bookmark plugin
  {
    "tidalcycles/vim-tidal",
    config = function()
      vim.g.tidal_target = "terminal"
      vim.g.tidal_sc_enable = 1
    end,
    ft = "tidal",
  },
  -- {
  --   "luckasRanarison/tree-sitter-hypr"
  -- }
}
