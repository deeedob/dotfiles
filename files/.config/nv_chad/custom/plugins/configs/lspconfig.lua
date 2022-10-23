-- custom.plugins.lspconfig
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "clangd", "cmake", "bashls", "qmlls", "pylsp", "sumneko_lua"
}

for _, lsp in ipairs(servers) do
  if lsp == "qmlls" then
    lspconfig[lsp].setup {
      cmd = {"/usr/lib/qt6/bin/qmlls"},
      filetypes = { 'qml', 'qmljs' },
      on_attach = on_attach,
      capabilities = capabilities,
    }
    goto continue
  end
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  ::continue::
end
