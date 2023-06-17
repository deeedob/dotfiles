return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,
  },

  -- Set colorscheme to use
  colorscheme = "astrodark",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    servers = {
      "qmlls",
    },
    config = {
      clangd = {
        capabilities = {
          offsetEncoding = "utf-8",
        },
      },
      qmlls = function()
        return {
          cmd = {
            "/usr/lib/qt6/bin/qmlls",
            "-l",
            "~/Temp/qmlls.log",
          },
          filetypes = { "qml" },
          root_dir = require("lspconfig.util").root_pattern "build",
        }
      end,
      glsl = function()
        return {
          cmd = { "glsl" },
          filetypes = { "glsl" },
        }
      end,
      grammarly = {
        filetypes = { "markdown", "text", "qdoc" },
      },
    },

    formatting = {
      format_on_save = {
        enabled = false,
      },
      timeout_ms = 1000, -- default format timeout
    },
  },
  plugins = {
    "p00f/clangd_extensions.nvim",
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "clangd" },
      },
    },
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- TODO: Vim autocmd VimEnter, VimLeavePre to sed alacritty win padding
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
