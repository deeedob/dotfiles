return {
  -- AstroVim updater
  updater = {
    remote = "origin",
    channel = "stable", -- "stable" or "nightly"
    version = "latest",
    branch = "nightly",
    commit = nil,
    pin_plugins = nil,
    skip_prompts = false,
    show_changelog = true,
    auto_quit = false,
  },

  -- Set colorscheme to use
  colorscheme = "gruvbox",

  -- LSP diagnostics
  diagnostics = {
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
  },

  lsp = require "user.lsp",

  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  -- This function is run last
  polish = function()
    vim.filetype.add {
      extension = {
        qml = "qml",
        tidal = "tidal",
        qdoc = "qdoc",
        vert = "glsl",
        frag = "glsl",
      },
      filename = {
        ["qmldir"] = "qmldir",
      },
    }
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      pattern = { "*" },
      callback = function(ev)
        local save_cursor = vim.fn.getpos "."
        vim.cmd [[%s/\s\+$//e]]
        vim.fn.setpos(".", save_cursor)
      end,
    })
    -- Show LSP diagnostics on cursor-hold
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          severity_sort = true,
          border = "rounded",
          source = "always",
          prefix = " ",
          scope = "line",
        }
        vim.diagnostic.open_float(nil, opts)
      end,
    })
    -- Neovide integration
    if vim.g.neovide == true then
      vim.api.nvim_set_keymap(
        "n",
        "<C-+>",
        ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>",
        { silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-->",
        ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>",
        { silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-0>",
        ":lua vim.g.neovide_scale_factor = 1<CR>",
        { silent = true }
      )
    end
  end,
}
