return {
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
    cond = function() return not vim.g.neovide end,
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
