-- ~/.config/nvim/lua/plugins/ai-core.lua
-- AI plugins - AVANTE BUFFER ISSUES FIXED

return {
  -- MCPHub for tool integration
  {
    'ravitemer/mcphub.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    build = 'npm install -g mcp-hub@latest',
    event = 'VeryLazy',
    config = function()
      require('mcphub').setup({
        port = 3000,
        config = vim.fn.expand('~/mcpservers.json'),
        shutdown_delay = 0,
        log = {
          level = vim.log.levels.WARN,
          to_file = false,
        },
      })
    end,
  },

  -- Avante.nvim - BUFFER ISSUES FIXED
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false,
    build = 'make',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
    opts = {
      provider = 'claude',
      auto_suggestions_provider = 'claude',

      providers = {
        claude = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-sonnet-4-20250514',
          extra_request_body = {
            temperature = 0,
            max_tokens = 8192,
          },
        },
        openai = {
          endpoint = 'https://api.openai.com/v1',
          model = 'gpt-5',
          extra_request_body = {
            temperature = 0.1,
            max_tokens = 8192,
          },
        },
        perplexity = {
          __inherited_from = 'openai',
          api_key_name = 'PERPLEXITY_API_KEY',
          endpoint = 'https://api.perplexity.ai/chat/completions',
          model = 'sonar-pro',
          extra_request_body = {
            temperature = 0.2,
            max_tokens = 8192,
          },
        },
      },

      -- BUFFER SETTINGS (fixes modifiable issues)
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        auto_focus_sidebar = false,
      },

      windows = {
        position = 'right',
        wrap = true,
        width = 30,
        sidebar_header = {
          align = 'center',
          rounded = true,
        },
        edit = {
          border = 'rounded',
          start_insert = false,
        },
      },

      mappings = {
        ask = '<leader>aa',
        edit = '<leader>ae',
        chat = '<leader>ac',
        toggle = {
          default = '<leader>at',
        },
        diff = {
          ours = 'co',
          theirs = 'ct',
          all_theirs = 'ca',
          both = 'cb',
          cursor = 'cc',
          next = ']x',
          prev = '[x',
        },
        suggestion = {
          accept = '<M-l>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
        submit = {
          normal = '<CR>',
          insert = '<C-s>',
        },
      },

      hints = { enabled = true },
      highlights = {
        diff = {
          current = 'DiffText',
          incoming = 'DiffAdd',
        },
      },
    },

    -- BUFFER FIX CONFIGURATION
    config = function(_, opts)
      require('avante').setup(opts)

      -- Create autocmds to fix buffer modifiable issues
      vim.api.nvim_create_augroup('AvanteBufferFix', { clear = true })

      -- Ensure Avante buffers are modifiable
      vim.api.nvim_create_autocmd('FileType', {
        group = 'AvanteBufferFix',
        pattern = { 'Avante', 'avante' },
        callback = function()
          vim.bo.modifiable = true
          vim.bo.readonly = false
        end,
      })

      -- Fix buffer before Avante operations
      local function ensure_modifiable()
        if vim.bo.buftype == '' and not vim.bo.readonly then
          vim.bo.modifiable = true
        end
      end

      -- Override default Avante keymaps with buffer fixes
      vim.keymap.set('n', '<leader>aa', function()
        ensure_modifiable()
        vim.cmd('AvanteAsk')
      end, { desc = 'Avante Ask (safe)' })

      vim.keymap.set('v', '<leader>ae', function()
        ensure_modifiable()
        vim.cmd('AvanteEdit')
      end, { desc = 'Avante Edit (safe)' })

      vim.keymap.set('n', '<leader>ac', function()
        ensure_modifiable()
        vim.cmd('AvanteChat')
      end, { desc = 'Avante Chat (safe)' })
    end,
  },

  -- CodeCompanion.nvim for conversational AI
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'hrsh7th/nvim-cmp',
      'nvim-telescope/telescope.nvim',
      'stevearc/dressing.nvim',
    },
    config = function()
      require('codecompanion').setup({
        strategies = {
          chat = { adapter = 'anthropic' },
          inline = { adapter = 'anthropic' },
        },
        adapters = {
          http = {
            anthropic = function()
              return require('codecompanion.adapters').extend('anthropic', {
                env = { api_key = 'ANTHROPIC_API_KEY' },
                schema = { model = { default = 'claude-3-5-sonnet-20241022' } },
              })
            end,
            openai = function()
              return require('codecompanion.adapters').extend('openai', {
                env = { api_key = 'OPENAI_API_KEY' },
                schema = { model = { default = 'gpt-4o' } },
              })
            end,
            perplexity = function()
              return require('codecompanion.adapters').extend('openai', {
                env = { api_key = 'PERPLEXITY_API_KEY' },
                url = 'https://api.perplexity.ai/chat/completions',
                schema = { model = { default = 'llama-3.1-sonar-large-128k-online' } },
              })
            end,
          },
        },
      })
    end,
  },

  -- Parrot.nvim for multi-provider AI
  {
    'frankroeder/parrot.nvim',
    dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
    config = function()
      require('parrot').setup({
        providers = {
          anthropic = {
            name = 'anthropic',
            api_key = os.getenv('ANTHROPIC_API_KEY'),
            endpoint = 'https://api.anthropic.com/v1/messages',
            model = 'claude-3-5-sonnet-20241022',
            topic = {
              model = 'claude-3-5-sonnet-20241022',
              params = { max_tokens = 8192, temperature = 0.7 },
            },
            command = {
              model = 'claude-3-5-sonnet-20241022',
              params = { max_tokens = 8192, temperature = 0.1 },
            },
          },
          openai = {
            name = 'openai',
            api_key = os.getenv('OPENAI_API_KEY'),
            endpoint = 'https://api.openai.com/v1',
            model = 'gpt-4o',
            topic = {
              model = 'gpt-4o',
              params = { max_tokens = 8192, temperature = 0.7 },
            },
            command = {
              model = 'gpt-4o',
              params = { max_tokens = 8192, temperature = 0.1 },
            },
          },
          perplexity = {
            name = 'perplexity',
            api_key = os.getenv('PERPLEXITY_API_KEY'),
            endpoint = 'https://api.perplexity.ai/chat/completions',
            model = 'llama-3.1-sonar-large-128k-online',
            topic = {
              model = 'llama-3.1-sonar-large-128k-online',
              params = { max_tokens = 8192, temperature = 0.2 },
            },
            command = {
              model = 'llama-3.1-sonar-small-128k-online',
              params = { max_tokens = 4096, temperature = 0.1 },
            },
          },
        },
        style_popup_border = 'rounded',
        command_auto_select_response = true,
      })
    end,
  },
}
