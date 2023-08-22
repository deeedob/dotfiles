return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astronvim.utils.status"
      -- TODO: improve with mouse interaction, colors etc.
      local component = {
        provider = function()
          local cmake = require "cmake-tools"
          if cmake.is_cmake_project() then
            local out = ""
            local build_type = cmake.get_build_type()
            local launch_target = cmake.get_launch_target()
            local build_target = cmake.get_build_target()
            if build_target then out = out .. "[" .. build_type .. "] " end
            if launch_target then out = out .. "  " .. "[" .. launch_target .. "] " end
            if build_target then out = out .. "  " .. "[" .. build_target .. "]" end
            return out
          else
            return ""
          end
        end,
      }
      opts.statusline = {
        -- statusline
        hl = { fg = "fg", bg = "bg" },
        status.component.mode(),
        status.component.git_branch(),
        status.component.file_info { filetype = {}, filename = false, file_modified = false },
        status.component.git_diff(),
        status.component.diagnostics(),
        component,
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.treesitter(),
        status.component.nav(),
        status.component.mode { surround = { separator = "right" } },
      }
      return opts
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      render = "compact",
      stages = "static",
      level = "ERROR",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            },
          },
        },
      }
      require("telescope").load_extension "ui-select"
    end,
  },
}
