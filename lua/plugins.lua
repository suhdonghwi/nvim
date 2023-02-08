-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  print('Installed packer.nvim; now close and reopen neovim')
end

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

local function req(name)
  return string.format("require('config/%s')", name)
end

return packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Have packer manage itself
  use 'nvim-lua/popup.nvim' -- An implementation of the Popup API from vim in Neovim
  use 'nvim-lua/plenary.nvim' -- Useful lua functions used by lots of plugins
  use 'tpope/vim-repeat' -- Make dot repeat possible in third-party plugins

  -- Appearances
  use 'folke/tokyonight.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = req('nvim-treesitter')
  }

  use 'nvim-tree/nvim-web-devicons'


  -- User Interface
  use {
    'nvim-lualine/lualine.nvim',
    config = req('lualine')
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = req('gitsigns')
  }

  -- Language server
  use {
    { 'williamboman/mason.nvim', config = req('mason') },
    'williamboman/mason-lspconfig.nvim',
    { 'neovim/nvim-lspconfig', config = req('nvim-lspconfig') },
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use {
    'hrsh7th/nvim-cmp',
    config = req('nvim-cmp')
  }

  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jose-elias-alvarez/typescript.nvim'

  use {
    'scalameta/nvim-metals',
    requires = { 'nvim-lua/plenary.nvim' },
    config = req('nvim-metals')
  }

  use 'onsails/lspkind.nvim'

  -- ETC
  use {
    'kyazdani42/nvim-tree.lua',
    config = req('nvim-tree')
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = req('telescope')
  }

  use {
    'ggandor/leap.nvim',
    config = req('leap')
  }

  use {
    'machakann/vim-sandwich',
    config = req('vim-sandwich')
  }

  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = req('diffview')
  }

  use {
    'folke/which-key.nvim',
    config = req('which-key')
  }

  use {
    'windwp/nvim-autopairs',
    config = req('nvim-autopairs')
  }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
