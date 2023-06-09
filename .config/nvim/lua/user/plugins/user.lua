return {
  -- "andweeb/presence.nvim",

  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
    lazy = true,
  },

  -- Undo tree visualizer
  {
    "simnalamburt/vim-mundo",
    cmd = { "MundoToggle" },
    lazy = true,
  },

  {
    "mg979/vim-visual-multi",
    lazy = false,
    init = function()
      vim.g.VM_theme = "paper"
      vim.g.VM_maps = {
        ["Select Cursor Down"] = "<M-C-Down>",
        ["Select Cursor Up"] = "<M-C-Up>",
      }
    end,
  },

  {
    "gauteh/vim-cppman",
    ft = { "cpp" },
    lazy = true,
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

  {
    "xiyaowong/virtcolumn.nvim",
    ft = { "python", "cpp", "cmake", "markdown", "lua" },
    lazy = true,
  },

  {
    "kylechui/nvim-surround",
    version = "*",     -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
      })
    end
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = { enabled = true },
      message = { enabled = false },
      popupmenu = { enabled = false },
      notify = { enabled = false },
      lsp = {
        progress = { enabled = false },
        hover = { enabled = false },
        signature = { enabled = false },
        message = { enabled = false },
      },
      health = { checker = false },
    },
    dependencies = { "MunifTanjim/nui.nvim" },
    lazy = true,
  },

  {
    "tidalcycles/vim-tidal",
    config = function()
      vim.g.tidal_target = "terminal"
      vim.g.tidal_sc_enable = 1
    end,
    ft = "tidal",
    lazy = true,
  },
}
