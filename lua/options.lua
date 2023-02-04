local opt = vim.opt

vim.g.mapleader = ' '
vim.o.completeopt = 'menuone,noinsert,noselect'

vim.cmd('language en_US')

opt.number = true
opt.relativenumber = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

opt.smartcase = true
opt.ignorecase = true

opt.cmdheight = 2

opt.backup = false
opt.writebackup = false

opt.updatetime = 300

opt.undolevels = 1000
opt.undofile = true

opt.termguicolors = true
vim.cmd('colorscheme tokyonight')

opt.cursorline = true

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
