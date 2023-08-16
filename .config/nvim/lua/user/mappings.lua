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
    -- better buffer navigation
    ["]b"] = false,
    ["[b"] = false,
    ["<S-l>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-h>"] = {
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
    ["<leader>lS"] = {
      "<cmd>TagbarToggle<cr>",
      desc = "Tagbar toggle",
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
        -- check if the register looks like a url. If so, open it
        if string.match(yanked_text, "http") then
          vim.cmd("OpenBrowser " .. yanked_text)
          return
        end
        -- otherwise, search for it
        local clean_text = string.gsub(tostring(yanked_text), ' ', '+')
        clean_text = string.gsub(clean_text, '\n', '+')
        print(clean_text)
        vim.cmd(string.format("OpenBrowser " .. "https://duckduckgo.com/?t=h_&q=%s", clean_text))
      end,
    },
    -- CMake
    ["<leader>x"] = { desc = "󰏫 CMake" },
    ["<leader>xs"] = { "<cmd>CMakeStop<cr>", desc = "CMakeStop" },
    ["<leader>xf"] = { "<cmd>CMakeClean<cr>", desc = "CMakeClean" },
    ["<leader>xc"] = { "<cmd>CMakeClose<cr>", desc = "CMakeClose" },

    ["<leader>xr"] = { "<cmd>CMakeRun<cr>", desc = "CMakeRun" },
    ["<leader>xb"] = { "<cmd>CMakeBuild<cr>", desc = "CMakeBuild" },
    ["<leader>xd"] = { "<cmd>CMakeDebug<cr>", desc = "CMakeDebug" },

    ["<leader>xG"] = { "<cmd>CMakeGenerate<cr>", desc = "CMakeGenereate" },
    ["<leader>xP"] = { "<cmd>CMakeSelectConfigurePreset<cr>", desc = "CMakeSelectConfigurePreset" },
    ["<leader>xB"] = { "<cmd>CMakeSelectBuildTarget<cr>", desc = "CMakeSelectBuildTarget" },
    ["<leader>xT"] = { "<cmd>CMakeSelectLaunchTarget<cr>", desc = "CMakeSelectLaunchTarget" },
    ["<leader>xR"] = { "<cmd>CMakeQuickRun<cr>", desc = "CMakeQuickRun" },
    ["<leader>xQ"] = { "<cmd>CMakeQuickBuild<cr>", desc = "CMakeQuickBuild" },
    ["<leader>xD"] = { "<cmd>CMakeQuickDebug<cr>", desc = "CMakeQuickDebug" },
  },
  v = {
    ["y"] = { "may`a<esc>", desc = "Yank no jump-back" },
  }
}
