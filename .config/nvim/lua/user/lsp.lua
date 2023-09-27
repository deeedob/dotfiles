return {
  -- setup_handlers = {
  --   clangd = function(_, opts) require("clangd_extensions").setup { server = opts } end,
  -- },
  servers = {
    "qmlls",
  },
  config = {
    clangd = {
      filetypes = { "c", "cpp", "cuda" },
      capabilities = {
        offsetEncoding = "utf-8",
      },
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--cross-file-rename",
        "--enable-config",
        "--header-insertion=iwyu",
        "--query-driver=/usr/bin/arm-none-eabi-g++",
        "-j=8",
        "--limit-references=0",
        "--limit-results=0",
      },
    },
    qmlls = function()
      local home = os.getenv "HOME"
      -- TODO: get build-dir by looking at compile_commands.json
      return {
        cmd = {
          "qmlls",
          "-l",
          home .. "/Temp/qmlls.log",
          "-b",
          "./build/debug",
        },
        filetypes = { "qml" },
        root_dir = require("lspconfig.util").root_pattern "compile_commands.json",
      }
    end,
    glsl = {
      cmd = { "glsl" },
      filetypes = { "glsl" },
    },
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
}
