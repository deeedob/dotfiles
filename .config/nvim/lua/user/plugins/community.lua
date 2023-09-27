local home = os.getenv "HOME"

-- https://github.com/AstroNvim/astrocommunity
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.code-runner.sniprun" },
  { import = "astrocommunity.debugging.telescope-dap-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  {
    "trouble.nvim",
    keys = {
      { "<leader>q" .. "X", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>q" .. "x", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>q" .. "l", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>q" .. "q", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    },
  },
  { import = "astrocommunity.editing-support.chatgpt-nvim" },
  { import = "astrocommunity.editing-support.multicursors-nvim" },
  { import = "astrocommunity.editing-support.telescope-undo-nvim" }, -- TODO: leader fu not working
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  -- { import = "astrocommunity.editing-support.vim-move" },
  { import = "astrocommunity.fuzzy-finder.telescope-zoxide" }, -- TODO: needed?
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.lsp.inc-rename-nvim" },
  { import = "astrocommunity.lsp.lsp-inlayhints-nvim" },
  { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.media.vim-wakatime" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.scrolling.vim-smoothie" },
  { import = "astrocommunity.search.sad-nvim" },

  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.cmake" },

  { import = "astrocommunity.pack.cpp" },
  -- https://github.com/Civitasv/cmake-tools.nvim#balloon-configuration
  {
    "Civitasv/cmake-tools.nvim",
    opts = {
      -- cmake_kits_path = home .. "/Dotfiles/.config/nvim/cmake-kits.json",
      cmake_dap_configuration = { -- debug settings for cmake
        name = "cpp",
        type = "cppdbg",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
        console = "integratedTerminal",
      },
      cmake_executor = {
        -- name = "quickfix" (default)
        -- name = "overseer", opts={}
        -- name = "terminal" (integrated terminal)
        name = "terminal",
        -- opts = {}
      }
    },
  },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.proto" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.html-css" },
}
