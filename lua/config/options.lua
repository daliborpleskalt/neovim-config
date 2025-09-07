-- ~/.config/nvim/lua/config/options.lua
-- Core Neovim options optimized for performance

local opt = vim.opt

-- Performance optimizations
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath('data') .. '/undo'
opt.updatetime = 100
opt.timeoutlen = 300
opt.ttimeoutlen = 10

-- UI optimizations
opt.termguicolors = true
opt.signcolumn = 'yes'
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.cmdheight = 1
opt.laststatus = 3 -- Global statusline
opt.showmode = false

-- Search optimizations
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Memory optimizations
opt.history = 1000
opt.synmaxcol = 240
opt.redrawtime = 10000

-- File handling
opt.autowrite = true
opt.autoread = true
opt.confirm = true

-- Performance for large files
opt.maxmempattern = 1000

-- Disable builtin plugins for performance
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
