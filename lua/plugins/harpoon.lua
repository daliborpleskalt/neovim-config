-- ~/.config/nvim/lua/plugins/harpoon.lua
-- Harpoon for quick file navigation

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require('harpoon')
    
    -- Setup harpoon with default configuration
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
        mark_branch = true,
      }
    })

    -- Keymap setup using <leader>h prefix to avoid conflicts
    local opts = { silent = true, noremap = true, nowait = true }
    
    -- Core harpoon operations
    vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, 
      { desc = 'Harpoon Add File', silent = true, nowait = true })
    
    vim.keymap.set('n', '<leader>hh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, 
      { desc = 'Harpoon Menu', silent = true, nowait = true })
    
    -- Quick navigation to marked files (1-4)
    vim.keymap.set('n', '<leader>h1', function() harpoon:list():select(1) end, 
      { desc = 'Harpoon File 1', silent = true, nowait = true })
    vim.keymap.set('n', '<leader>h2', function() harpoon:list():select(2) end, 
      { desc = 'Harpoon File 2', silent = true, nowait = true })
    vim.keymap.set('n', '<leader>h3', function() harpoon:list():select(3) end, 
      { desc = 'Harpoon File 3', silent = true, nowait = true })
    vim.keymap.set('n', '<leader>h4', function() harpoon:list():select(4) end, 
      { desc = 'Harpoon File 4', silent = true, nowait = true })
    
    -- Navigate to next & previous marked files
    vim.keymap.set('n', '<leader>hn', function() harpoon:list():next() end, 
      { desc = 'Harpoon Next', silent = true, nowait = true })
    vim.keymap.set('n', '<leader>hp', function() harpoon:list():prev() end, 
      { desc = 'Harpoon Previous', silent = true, nowait = true })
    
    -- Clear harpoon list
    vim.keymap.set('n', '<leader>hc', function() harpoon:list():clear() end, 
      { desc = 'Harpoon Clear', silent = true, nowait = true })
    
    -- Remove current file from harpoon
    vim.keymap.set('n', '<leader>hr', function() harpoon:list():remove() end, 
      { desc = 'Harpoon Remove', silent = true, nowait = true })

    -- Telescope integration (if telescope is available)
    local has_telescope = pcall(require, 'telescope')
    if has_telescope then
      vim.keymap.set('n', '<leader>ht', ':Telescope harpoon marks<CR>', 
        { desc = 'Harpoon Telescope', silent = true, nowait = true })
    end
  end,
}