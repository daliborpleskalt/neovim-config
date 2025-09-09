-- ~/.config/nvim/lua/plugins/ui.lua
-- UI enhancements - SAFE which-key configuration

return {
  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'catppuccin',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          globalstatus = true,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {
            {
              'filename',
              file_status = true,
              path = 1,
            }
          },
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        extensions = {'neo-tree', 'lazy', 'mason'}
      })
    end,
  },

  -- Indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'lazy',
          'mason',
        },
      },
    },
  },

  -- Better notifications
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({
        background_colour = '#000000',
        fps = 30,
        icons = {
          DEBUG = '',
          ERROR = '',
          INFO = '',
          TRACE = '✎',
          WARN = ''
        },
        level = 2,
        minimum_width = 50,
        render = 'default',
        stages = 'fade_in_slide_out',
        timeout = 5000,
        top_down = true
      })
      vim.notify = require('notify')
    end,
  },

  -- Better UI components
  {
    'stevearc/dressing.nvim',
    opts = {
      input = {
        enabled = true,
        border = 'rounded',
        relative = 'cursor',
      },
      select = {
        enabled = true,
        backend = { 'telescope', 'fzf_lua', 'builtin' },
      },
    },
  },
}
