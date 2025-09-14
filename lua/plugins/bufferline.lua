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
  end,
}
