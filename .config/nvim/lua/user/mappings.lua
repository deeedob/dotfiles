local utils = require "astronvim.utils"
local get_icon = utils.get_icon
local is_available = utils.is_available
local ui = require "astronvim.utils.ui"

local maps = require("astronvim.utils").empty_map_table()

local sections = {
  x = { desc = get_icon("Terminal", 1, true) .. "CMake" },
}
-- TODO
if is_available "cmake-tools" then
  maps.n["<leader>x"] = sections.x
  maps.n ["<leader>xs"] = { "<cmd>CMakeStop<cr>", desc = "CMakeStop" }
  maps.n ["<leader>xf"] = { "<cmd>CMakeClean<cr>", desc = "CMakeClean" }
  maps.n ["<leader>xc"] = { "<cmd>CMakeClose<cr>", desc = "CMakeClose" }

  maps.n ["<leader>xr"] = { "<cmd>CMakeRun<cr>", desc = "CMakeRun" }
  maps.n ["<leader>b"] = { "<cmd>CMakeBuild<cr>", desc = "CMakeBuild" }
  maps.n ["<leader>xd"] = { "<cmd>CMakeDebug<cr>", desc = "CMakeDebug" }

  maps.n ["<leader>xG"] = { "<cmd>CMakeGenerate<cr>", desc = "CMakeGenereate" }
  maps.n ["<leader>xP"] = { "<cmd>CMakeSelectConfigurePreset<cr>", desc = "CMakeSelectConfigurePreset" }
  maps.n ["<leader>xB"] = { "<cmd>CMakeSelectBuildTarget<cr>", desc = "CMakeSelectBuildTarget" }
  maps.n ["<leader>xT"] = { "<cmd>CMakeSelectLaunchTarget<cr>", desc = "CMakeSelectLaunchTarget" }
  maps.n ["<leader>xR"] = { "<cmd>CMakeQuickRun<cr>", desc = "CMakeQuickRun" }
  maps.n ["<leader>xQ"] = { "<cmd>CMakeQuickBuild<cr>", desc = "CMakeQuickBuild" }
  maps.n ["<leader>xD"] = { "<cmd>CMakeQuickDebug<cr>", desc = "CMakeQuickDebug" }
end

return {
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", desc = "Beginning of line" },
    ["<C-e>"] = { "<End>", desc = "End of line" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", desc = "Move left" },
    ["<C-l>"] = { "<Right>", desc = "Move right" },
    ["<C-j>"] = { "<Down>", desc = "Move down" },
    ["<C-k>"] = { "<Up>", desc = "Move up" },
  },
  n = {
    ["<C-ö>"] = { "^:", desc = "New tab" },
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    ["<C-n>"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
    ["<leader>."] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<leader>,"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    ["<leader>b"] = { name = "Buffers" },
    ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
    ["<leader>u"] = { "<cmd>MundoToggle<cr>", desc = "Undo History Toggle" },

    ["<leader>lo"] = {
      function () vim.lsp.buf.outgoing_calls() end,
      desc = "LSP outgoing calls"
    },
    ["<leader>le"] = {
      function () vim.lsp.buf.incoming_calls() end,
      desc = "LSP incoming calls"
    },
    -- ["<leader>c"] = {
    --   function() vim.opt.colorcolumn = { 80, 100 } end,
    --   desc = "Colorcolumn On",
    -- },
    -- ["<leader>co"] = {
    --   function() vim.opt.colorcolumn = {} end,
    --   desc = "Colorcolumn Off",
    -- },

    -- Search in browser
    ["KQ"] = {
      function()
        local current_word = vim.fn.expand "<cword>"
        vim.cmd(
          string.format("OpenBrowser https://doc.qt.io/qt-6/search-results.html?q=%s", current_word)
        )
      end,
      desc = "Open Qt symbol in qt6 online docs",
    },
    ["KR"] = {
      function()
        local current_word = vim.fn.expand "<cword>"
        local escaped_word = vim.fn.fnameescape(current_word)
        local url = string.format(
          "https://en.cppreference.com/mwiki/index.php?title=Special%%3ASearch&search=%s",
          escaped_word
        )
        vim.cmd("OpenBrowser " .. url)
        --vim.cmd(string.format("OpenBrowser https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search=%s", current_word))
      end,
      desc = "Open symbol in cppreference-online docs",
    },
    ["KK"] = {
      function()
        local current_word = vim.fn.expand "<cword>"
        local escaped_word = vim.fn.fnameescape(current_word)
        vim.cmd("Cppman " .. escaped_word)
      end,
    },
    ["<leader>K"] = {
      function()
        local current_register = "+"
        local yanked_text = vim.fn.eval("@" .. current_register)
        local clean_text = string.gsub(tostring(yanked_text), '"', '\\"')
        print(clean_text)
        vim.cmd(string.format("OpenBrowser " .. "https://duckduckgo.com/%s", clean_text))
      end,
    },
  },
  v = {
    ["y"] = { "may`a<esc>", desc = "Yank no jump-back" },
  }
}
