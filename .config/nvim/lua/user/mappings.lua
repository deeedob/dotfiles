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
    -- ["<C-l>"] = { function() vim.cmd.tabnext() end, desc = "Next tab" },
    -- ["<C-h>"] = { function() vim.cmd.tabprevious() end, desc = "Previous tab" },
    ["<leader>b"] = { name = "Buffers" },
    ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
    ["<leader>u"] = { "<cmd>MundoToggle<cr>", desc = "Undo History Toggle" },

    ["<leader>c"] = {
      function() vim.opt.colorcolumn = { 80, 100 } end,
      desc = "Colorcolumn On",
    },
    ["<leader>co"] = {
      function() vim.opt.colorcolumn = {} end,
      desc = "Colorcolumn Off",
    },

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
        vim.cmd(
          string.format("OpenBrowser " .. "https://duckduckgo.com/%s", clean_text)
        )
      end,
    },
  },
}
