return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        "grammarly-languageserver",
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        "prettier",
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    enabled = true,
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        "codelldb",
        "cppdbg",
        "bash-debug-adapter",
      })
      opts.handlers = {
        function(config)
          -- Keep original functionality
          require('mason-nvim-dap').default_setup(config)
        end,
        -- https://github.com/vadimcn/codelldb/blob/master/MANUAL.md
        codelldb = function(config)
          config.configurations = {
            {
              name = "LLDB: Launch",
              type = "codelldb",
              request = "launch",
              program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
              args = {},
            },
            {
              name = "LLDB: Attach",
              type = "codelldb",
              request = "attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
              args = {},
            }
          }
          require('mason-nvim-dap').default_setup(config)
        end,
        cppdbg = function(config)
          config.configurations = {
            {
              name = "GDB: Launch",
              type = "cppdbg",
              request = "launch",
              program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
              cwd = "${workspaceFolder}",
              stopAtEntry = false,
              args = {},
              setupCommands = {
                {
                  description = "Enable pretty-printing for gdb",
                  text = "-enable-pretty-printing",
                  ignoreFailures = false,
                },
              },
            },
            {
              name = "GDB: Attach",
              type = "cppdbg",
              request = "attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
              stopAtEntry = false,
              args = {},
              setupCommands = {
                {
                  description = "Enable pretty-printing for gdb",
                  text = "-enable-pretty-printing",
                  ignoreFailures = false,
                },
              },
            }
          }

          require('mason-nvim-dap').default_setup(config)
        end,
      }
    end,
  },
}
