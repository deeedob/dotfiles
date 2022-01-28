local use = require('packer').use
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)

    -- ########### LSP #################
    use {
    -- 'https://github.com/neovim/nvim-lspconfig'
    -- 'https://github.com/williamboman/nvim-lsp-installer'
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer',
        --:LspInstall bashls cmake clangd csharp_ls cssls dockerls gopls html jdtls jsonls lua jedi_language_server tailwindcss vimls yamlls vuels jsonls lemminx quick_lint_js remark_ls taplo yamlls
    }
    use {
    -- 'https://github.com/peterhoeg/vim-qml'
      'peterhoeg/vim-qml'
    }
    use {
    -- 'https://github.com/shougo/deoplete.nvim'
    -- code completion plugin
      'shougo/deoplete.nvim'
    }
    use {
    -- 'https://github.com/shougo/deoplete-lsp'
      'shougo/deoplete-lsp'
    }
    use {
    -- 'https://github.com/onsails/lspkind-nvim'
    -- vsc like pictogramms for lsp
      'onsails/lspkind-nvim'
    }
    use {
    -- 'https://github.com/iamcco/markdown-preview.nvim'
    -- md preview
        'iamcco/markdown-preview.nvim'
    }
    -- #########Fuzzy finder ############
    use {
    -- 'https://github.com/junegunn/fzf'
      'junegunn/fzf'
    }
    use {
    --  'https://github.com/junegunn/fzf.vim'
      'junegunn/fzf.vim'
    }
    use {
    -- 'https://github.com/ojroques/nvim-lspfuzzy'
    -- maybe telescope ?
      'ojroques/nvim-lspfuzzy'
    }
    use {
    -- 'https://github.com/nvim-treesitter/nvim-treesitter'
    -- better syntax highliting
      'nvim-treesitter/nvim-treesitter'
    }

    use {
    -- 'https://github.com/kyazdani42/nvim-tree.lua'
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = function() require'nvim-tree'.setup {} end
    }

    -- 'https://github.com/nvim-telescope/telescope.nvim'
    --use {
    --    'nvim-telescope/telescope.nvim',
    --    requires = { {'nvim-lua/plenary.nvim'} }
    --}

    -- ########### Styling #################
    use {
        -- 'https://github.com/catppuccin/nvim'
        -- 'catppuccin/nvim'
        'navarasu/onedark.nvim'
    }
    use 'mfussenegger/nvim-dap'
    use 'ojroques/vim-oscyank'
    use 'windwp/windline.nvim'
    use 'yamatsum/nvim-cursorline'
    use 'kosayoda/nvim-lightbulb'
    use 'sunjon/shade.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use {
        'romgrk/barbar.nvim',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
    use 'glepnir/dashboard-nvim'

    if packer_bootstrap then
        require('packer').sync()
    end

    end)
