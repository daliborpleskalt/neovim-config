-- ~/.config/nvim/lua/plugins/gitsigns.lua
-- Git integration with signs in the sign column

return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    signs = {
      add          = { text = '' },  -- Same as neo-tree added
      change       = { text = '' },  -- Same as neo-tree modified
      delete       = { text = '' },  -- Same as neo-tree deleted
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '' },  -- Same as neo-tree untracked
    },
    signs_staged = {
      add          = { text = '' },  -- Same as neo-tree staged
      change       = { text = '' },  -- Same as neo-tree staged
      delete       = { text = '' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(buffer)
      local gs = require('gitsigns')

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true, noremap = true })
      end

      -- Navigation - using ]h and [h to avoid conflicts
      map('n', ']h', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gs.nav_hunk('next')
        end
      end, 'Next Hunk')

      map('n', '[h', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gs.nav_hunk('prev')
        end
      end, 'Prev Hunk')

      -- Actions - using <leader>g prefix to avoid conflicts
      map('n', '<leader>gs', gs.stage_hunk, 'Stage Hunk')
      map('n', '<leader>gr', gs.reset_hunk, 'Reset Hunk')
      map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, 'Stage Hunk')
      map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, 'Reset Hunk')

      map('n', '<leader>gS', gs.stage_buffer, 'Stage Buffer')
      map('n', '<leader>gR', gs.reset_buffer, 'Reset Buffer')

      map('n', '<leader>gu', gs.undo_stage_hunk, 'Undo Stage Hunk')

      map('n', '<leader>gp', gs.preview_hunk, 'Preview Hunk')

      map('n', '<leader>gb', function() gs.blame_line { full = true } end, 'Blame Line')
      map('n', '<leader>gB', gs.toggle_current_line_blame, 'Toggle Line Blame')

      map('n', '<leader>gd', gs.diffthis, 'Diff This')
      map('n', '<leader>gD', function() gs.diffthis('~') end, 'Diff This ~')

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk')
    end,
    
    preview_config = {
      border = 'rounded',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
    
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 300,
      ignore_whitespace = false,
    },
    
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    
    word_diff = false,
    
    watch_gitdir = {
      follow_files = true
    },
    
    attach_to_untracked = true,
    
    sign_priority = 6,
    
    update_debounce = 100,
    
    status_formatter = nil,
    
    max_file_length = 40000,
    
    numhl = false,
    linehl = false,
  }
}