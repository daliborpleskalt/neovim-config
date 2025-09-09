-- ~/.config/nvim/init.lua
-- Ultimate AI-Powered Neovim Configuration
-- Performance-optimized for macOS

-- Set leader key early
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load core configuration
require('config.options')
require('config.keymaps')
require('config.lazy')
require('config.security')
require('config.typescript-linters-formatters-config').init()

-- Performance optimization
vim.opt.updatetime = 100
vim.opt.timeoutlen = 300
