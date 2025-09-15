return {
  'akinsho/bufferline.nvim',
  event = { 'BufAdd', 'BufEnter', 'TabEnter' },
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  config = function()
    local bufferline = require('bufferline')

    bufferline.setup({
      options = {
        numbers = "buffer_id",
        close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil,            -- can be a string | function, see "Mouse actions"
        indicator = {
          icon = '▎', -- this should be omitted if indicator style is not 'icon'
          style = 'icon', -- can also be 'underline' | 'none'
        },
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 18,
        diagnostics = 'nvim_lsp', -- or "coc"
        diagnostics_update_in_insert = false,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            highlight = 'Directory',
            text_align = 'left',
            separator = true,
          }
        },
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        separator_style = 'thin', -- can be 'slant' | 'slope' | 'thick' | 'thin' | { 'any', 'any' }
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' }
        },
      }
    })

    -- Keymaps for buffer navigation
    local map = vim.keymap.set
    map('n', '<leader>bn', ':BufferLineCycleNext<CR>', { desc = 'Bufferline next buffer' })
    map('n', '<leader>bp', ':BufferLineCyclePrev<CR>', { desc = 'Bufferline previous buffer' })

    -- Ensure neo-tree stays on the left when buffers are switched
    local augroup = vim.api.nvim_create_augroup('NeotreePosition', { clear = true })
    vim.api.nvim_create_autocmd('BufEnter', {
      group = augroup,
      callback = function()
        -- Small delay to ensure window positioning is stable
        vim.defer_fn(function()
          local neo_tree_wins = vim.tbl_filter(function(win)
            local buf = vim.api.nvim_win_get_buf(win)
            local ok, ft = pcall(vim.api.nvim_buf_get_option, buf, 'filetype')
            return ok and ft == 'neo-tree'
          end, vim.api.nvim_list_wins())
          
          if #neo_tree_wins > 0 then
            local neo_win = neo_tree_wins[1]
            local win_pos = vim.api.nvim_win_get_position(neo_win)
            -- If neo-tree is not at the leftmost position, move it
            if win_pos[2] > 0 then
              vim.api.nvim_set_current_win(neo_win)
              vim.cmd('wincmd H')
            end
          end
        end, 10)
      end,
    })
  end,
}
