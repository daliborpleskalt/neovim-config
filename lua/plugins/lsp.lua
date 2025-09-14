-- ~/.config/nvim/lua/plugins/lsp.lua
-- LSP configuration - UPDATED to fix tsserver deprecation

return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({
        ui = {
          border = 'rounded',
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗'
          },
        },
      })
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'ts_ls', -- UPDATED: was 'typescript-language-server'
          'rust_analyzer',
          'angularls',
          'lua_ls',
          'jdtls', -- Java
        },
        automatic_installation = true,
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason.nvim',
      'mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local lspconfig = require('lspconfig')
      local cmp = require('cmp');
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Configure cmp to apply suggestions only on TAB
      cmp.setup({
        mapping = {
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        },
      })

      local on_attach = function(client, bufnr)
        -- Enable native LSP completion for Neovim 0.11+
        if client:supports_method('textDocument/completion') then
         vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = false })
        end

          -- Enhanced keymaps for auto imports
        local opts = { buffer = bufnr, silent = true }
        local opts_nowait = { buffer = bufnr, silent = true, nowait = true }
        
        -- Existing keymaps
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        
        -- Auto import keymaps
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts_nowait)
        vim.keymap.set('n', '<leader>ai', function()
          vim.lsp.buf.code_action({
            apply = true,
            context = {
              only = { 'source.addMissingImports.ts', 'source.addMissingImports' },
              diagnostics = {}
            }
          })
        end, { desc = 'Add missing imports', buffer = bufnr, nowait = true })
        
        vim.keymap.set('n', '<leader>oi', function()
          vim.lsp.buf.code_action({
            apply = true,
            context = {
              only = { 'source.organizeImports.ts', 'source.organizeImports' },
              diagnostics = {}
            }
          })
        end, { desc = 'Organize imports', buffer = bufnr, nowait = true })

        -- Auto-organize imports and add missing imports on save
        if client:supports_method('textDocument/codeAction') then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('AutoImports', { clear = true }),
            buffer = bufnr,
            callback = function()
              -- Add missing imports first
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { 'source.addMissingImports.ts', 'source.addMissingImports' },
                  diagnostics = {}
                }
              })
              
              -- Then organize imports
              vim.defer_fn(function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { 'source.organizeImports.ts', 'source.organizeImports' },
                    diagnostics = {}
                  }
                })
              end, 100)
            end,
          })
        end

        -- Format on save
        if client:supports_method('textDocument/formatting') then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('LspFormat', { clear = true }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end

      -- Angular
      lspconfig.angularls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern('angular.json', 'nx.json', 'project.json'),
        filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx' },
      })

      -- TypeScript/JavaScript - UPDATED: ts_ls instead of tsserver
      lspconfig.ts_ls.setup({
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
        end,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'nx.json'),
        settings = {
          ['typescript'] = {
            inlayHints = { includeInlayParameterNameHints = 'all' },
            preferences = {
              importModuleSpecifierPreference = 'relative',
              includeInlayParameterNameHints = 'all',
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              -- Automatic import suggestions
              includeCompletionsForImportStatements = true,
            },
          },
          ['typescript.tsserver'] = {
            codeActionsOnSave = {
              source = {
                organizeImports = true,
                addMissingImports = true,
              },
            },
          },
          ['javascript'] = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
        },
      })

      -- Rust
      lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          ['rust-analyzer'] = {
            diagnostics = { enable = true },
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
            },
            procMacro = { enable = true },
            checkOnSave = { command = 'clippy' },
          },
        },
      })

      -- Java
      lspconfig.jdtls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern('.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'),
      })

      -- Lua
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Configure diagnostics
      vim.diagnostic.config({
        virtual_text = {
          enabled = true,
          source = "if_many",
          prefix = "●",
          spacing = 4,
        },
        signs = {
          enabled = true,
          priority = 20,
          text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
          },
        },
        underline = {
          enabled = true,
          severity = vim.diagnostic.severity.ERROR,
        },
        update_in_insert = false,
        severity_sort = true,
        float = {
          enabled = true,
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- Add diagnostic keymaps
      vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show diagnostic error messages', nowait = true })
      vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list', nowait = true })
    end,
  },
}
