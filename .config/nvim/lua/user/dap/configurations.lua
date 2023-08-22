local dap = require "dap"
require('dap.ext.vscode').load_launchjs('.vscode/launch.json', { lldb = { 'c', 'cpp', 'rust' } })

return {
  -- dap {
  --   configuration {
  --     cpp = {
  --       {
  --         name = "Launch file",
  --         type = "codelldb",
  --         request = "launch",
  --         program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
  --         cwd = "${workspaceFolder}",
  --         stopOnEntry = true,
  --         terminal = "integrated",
  --       },
  --     },
  --   },
  -- },
}
