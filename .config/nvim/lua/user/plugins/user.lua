return {
  -- "ray-x/lsp_signature.nvim",
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
    "p00f/clangd_extensions.nvim",
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "clangd" },
      },
    },
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
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function() require("nvim-surround").setup {} end,
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
    config = function()
      vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true})
    end,
    dependencies = { "MunifTanjim/nui.nvim" },
    lazy = false,
  },

  {
    "crusj/bookmarks.nvim",
    keys = {
      { "<tab><tab>", mode = { "n" } },
    },
    branch = "main",
    dependencies = { "nvim-web-devicons" },
    config = function()
      require("bookmarks").setup()
      require("telescope").load_extension "bookmarks"
    end,
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
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function() require("flash").jump() end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function() require("flash").treesitter() end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function() require("flash").remote() end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc = "Flash Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc = "Toggle Flash Search",
      },
    },
  },

  {
    "preservim/tagbar",
    lazy = false,
  },

  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("chatgpt").setup({
        -- This requires a valid API key used and a configure pass
        api_key_cmd = "pass show dev/chatgpt"
      })
    end,
  },

  {
    "tidalcycles/vim-tidal",
    config = function()
      vim.g.tidal_target = "terminal"
      vim.g.tidal_sc_enable = 1
    end,
    ft = "tidal",
  },
}
