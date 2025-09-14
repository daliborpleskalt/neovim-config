-- ~/.config/nvim/lua/plugins/completion.lua
-- Enhanced completion with blink.cmp

return {
  {
    'saghen/blink.cmp',
    version = 'v0.*',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
    opts = {
      keymap = {
        preset = 'default',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lsp = { 
            name = 'LSP',
            module = 'blink.cmp.sources.lsp',
            score_offset = 100
          },
          path = {
            name = 'Path',
            module = 'blink.cmp.sources.path',
            score_offset = 3
          },
          buffer = {
            name = 'Buffer',
            module = 'blink.cmp.sources.buffer',
            score_offset = 5
          }
        }
      },
      snippets = {
        preset = 'luasnip'
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          border = 'rounded',
          draw = {
            treesitter = { 'lsp' }
          }
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = 'rounded'
          }
        },
        ghost_text = {
          enabled = true
        }
      },
      signature = {
        enabled = true,
        window = {
          border = 'rounded'
        }
      }
    },
    config = function(_, opts)
      require('luasnip.loaders.from_vscode').lazy_load()
      require('blink.cmp').setup(opts)
    end
  },
}