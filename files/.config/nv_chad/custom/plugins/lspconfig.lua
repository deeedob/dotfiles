-- custom.plugins.lspconfig
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "jsonls", "clangd", "cmake", "pyright", "qmlls", "tailwindcss", "sumneko_lua"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- for clangd setup
lspconfig.clangd.setup {
  cmd = {

    "clangd",

    "--background-index",

    "--suggest-missing-includes",

    "--clang-tidy",

    "--query-driver=/usr/bin/clang++"

  },
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  },
  on_attach = on_attach,
  capabilities = capabilities,
}
