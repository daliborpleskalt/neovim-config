-- ~/.config/nvim/lua/config/keymaps.lua
-- Ergonomic keybindings for maximum productivity

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Better window navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Resize windows with arrows
map('n', '<C-Up>', ':resize -2<CR>', opts)
map('n', '<C-Down>', ':resize +2<CR>', opts)
map('n', '<C-Left>', ':vertical resize -2<CR>', opts)
map('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Buffer navigation
map('n', '<S-l>', ':bnext<CR>', opts)
map('n', '<S-h>', ':bprevious<CR>', opts)
map('n', '<leader>bd', ':bdelete<CR>', opts)
map('n', '<leader>ba', ':%bdelete|edit #|normal `"<CR>', opts)

-- Better indenting
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Move text up and down
map('v', '<A-j>', ':move \'>+1<CR>gv=gv', opts)
map('v', '<A-k>', ':move \'<-2<CR>gv=gv', opts)
map('n', '<A-j>', ':move .+1<CR>==', opts)
map('n', '<A-k>', ':move .-2<CR>==', opts)

-- Clear search highlighting
map('n', '<leader>nh', ':noh<CR>', opts)

-- Save and quit
map('n', '<leader>w', ':w<CR>', opts)
map('n', '<leader>x', ':q<CR>', opts)
map('n', '<leader>Q', ':qa!<CR>', opts)

-- Telescope
map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', opts)
map('n', '<leader>fh', ':Telescope help_tags<CR>', opts)
map('n', '<leader>fr', ':Telescope oldfiles<CR>', opts)
map('n', '<leader>fc', ':Telescope colorscheme<CR>', opts)

-- Neo-tree
map('n', '<leader>e', ':Neotree toggle<CR>', opts)
map('n', '<leader>o', ':Neotree focus<CR>', opts)

-- AI Keymaps
map('n', '<leader>aa', ':AvanteAsk<CR>', opts)
map('v', '<leader>ar', ':AvanteRefactor<CR>', opts)
map('n', '<leader>ac', ':AvanteChat<CR>', opts)
map('v', '<leader>ae', ':AvanteExplain<CR>', opts)
map('v', '<leader>ao', ':AvanteOptimize<CR>', opts)

map('n', '<leader>cc', ':CodeCompanionChat<CR>', opts)
map('v', '<leader>ce', ':CodeCompanionEdit<CR>', opts)
map('n', '<leader>cm', ':CodeCompanionActions<CR>', opts)

map('n', '<leader>pp', ':ParrotChatNew<CR>', opts)
map('v', '<leader>pr', ':ParrotRewrite<CR>', opts)

-- LSP and Diagnostic keymaps (managed in lsp.lua)
-- gd, gD, gi, gr, K, <leader>rn, <leader>ca - defined in LSP on_attach
-- [d, ]d - diagnostic navigation (defined in LSP config)
-- <leader>de - diagnostic float, <leader>dq - diagnostic quickfix

-- Formatting
map('n', '<leader>lf', function() vim.lsp.buf.format({ async = true }) end, opts)
