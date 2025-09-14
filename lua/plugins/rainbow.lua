return {
  'HiPhish/rainbow-delimiters.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    local rainbow_delimiters = require('rainbow-delimiters')
    
    -- Default highlights for delimiter levels
    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
        javascript = 'rainbow-delimiters',
        typescript = 'rainbow-delimiters',
        rust = 'rainbow-blocks',
        java = 'rainbow-delimiters',
      },
      highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterOrange',
        'RainbowDelimiterYellow',
        'RainbowDelimiterGreen',
        'RainbowDelimiterBlue',
        'RainbowDelimiterViolet',
      },
    }

    -- Define highlight groups to match your Catppuccin Mocha theme
    vim.api.nvim_set_hl(0, 'RainbowDelimiterRed',    { fg = '#ed8796' }) -- mocha red
    vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#eed49f' }) -- mocha peach
    vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#eed49f' }) -- mocha yellow
    vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen',  { fg = '#a6da95' }) -- mocha green
    vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue',   { fg = '#8aadf4' }) -- mocha blue
    vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#f5bde6' }) -- mocha mauve

    -- Enable rainbow delimiters extension for nvim-treesitter
    require('nvim-treesitter.configs').setup {
      rainbow = {
        enable = true,
        extended_mode = true, -- Highlight also non-bracket delimiters like html tags
        max_file_lines = nil, -- No file length limit
        -- colors defined above in vim.g.rainbow_delimiters.highlight
      }
    }
  end,
}
