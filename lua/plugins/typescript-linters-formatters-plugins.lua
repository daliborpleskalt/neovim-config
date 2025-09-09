return {
  -- Mason for managing external tools
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = '🔨 Mason' } },
    build = ':MasonUpdate',
    opts = {
      ensure_installed = {
        -- TypeScript/Angular linters and formatters
        'eslint_d',
        'prettierd',
        'prettier', -- Add regular prettier as fallback
        -- Additional useful tools
        'typescript-language-server',
        'angular-language-server',
        'html-lsp',
        'css-lsp',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          require('lazy.core.handler.event').trigger({
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  -- Enhanced formatting with conform.nvim and fallbacks
  {
    'stevearc/conform.nvim',
    dependencies = { 'mason.nvim' },
    lazy = true,
    cmd = 'ConformInfo',
    keys = {
      {
        '<leader>cf',
        function()
          local conform = require('conform')
          local success = conform.format({ 
            bufnr = vim.api.nvim_get_current_buf(),
            timeout_ms = 5000,
            quiet = false,
          })
          if success then
            vim.notify('✨ Formatted successfully', vim.log.levels.INFO)
          else
            vim.notify('⚠️ Formatting failed, trying fallback...', vim.log.levels.WARN)
            -- Fallback to manual prettier
            require('config.angular-typescript-linters-formatters-config').format_with_prettier_fallback()
          end
        end,
        mode = { 'n', 'v' },
        desc = '🎨 Format with Prettier',
      },
      {
        '<leader>cF',
        function()
          local conform = require('conform')
          local success = conform.format({ 
            bufnr = vim.api.nvim_get_current_buf(),
            timeout_ms = 5000,
            quiet = false,
          })
          if success then
            vim.cmd('write')
            vim.notify('✨ Formatted and saved', vim.log.levels.INFO)
          else
            vim.notify('⚠️ Formatting failed', vim.log.levels.ERROR)
          end
        end,
        mode = { 'n', 'v' },
        desc = '🎨 Format and save',
      },
    },
    config = function()
      local conform = require('conform')

      conform.setup({
        -- Define formatters with fallbacks
        formatters_by_ft = {
          javascript = { 'prettierd', 'prettier', stop_after_first = true },
          typescript = { 'prettierd', 'prettier', stop_after_first = true },
          javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
          typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
          html = { 'prettierd', 'prettier', stop_after_first = true },
          css = { 'prettierd', 'prettier', stop_after_first = true },
          scss = { 'prettierd', 'prettier', stop_after_first = true },
          json = { 'prettierd', 'prettier', stop_after_first = true },
          jsonc = { 'prettierd', 'prettier', stop_after_first = true },
          yaml = { 'prettierd', 'prettier', stop_after_first = true },
          markdown = { 'prettierd', 'prettier', stop_after_first = true },
        },
        -- Disable format_on_save here - we'll handle it manually
        format_on_save = nil,
        -- Enhanced formatters configuration
        formatters = {
          prettierd = {
            condition = function(self, ctx)
              -- Check if prettierd is available
              return vim.fn.executable('prettierd') == 1
            end,
            env = {
              PRETTIERD_DEFAULT_CONFIG = vim.fn.expand('~/.prettierrc'),
            },
            cwd = function(self, ctx)
              -- Find project root with prettier config
              local prettier_configs = {
                '.prettierrc', '.prettierrc.json', '.prettierrc.yml',
                '.prettierrc.yaml', '.prettierrc.js', 'prettier.config.js',
              }

              local current_dir = vim.fn.fnamemodify(ctx.filename, ':h')
              while current_dir ~= '/' and current_dir ~= '' do
                for _, config in ipairs(prettier_configs) do
                  if vim.fn.filereadable(current_dir .. '/' .. config) == 1 then
                    return current_dir
                  end
                end
                current_dir = vim.fn.fnamemodify(current_dir, ':h')
              end
              return vim.fn.getcwd()
            end,
          },
          prettier = {
            condition = function(self, ctx)
              -- Use as fallback when prettierd is not available
              return vim.fn.executable('prettier') == 1 or vim.fn.executable('npx') == 1
            end,
            command = function(self, ctx)
              -- Try npx prettier if prettier is not globally available
              if vim.fn.executable('prettier') == 1 then
                return 'prettier'
              else
                return 'npx'
              end
            end,
            args = function(self, ctx)
              local args = {}
              if vim.fn.executable('prettier') ~= 1 then
                table.insert(args, 'prettier')
              end

              -- Add prettier args
              vim.list_extend(args, {
                '--stdin-filepath', '$FILENAME',
                '--write', '$FILENAME'
              })

              return args
            end,
            cwd = function(self, ctx)
              -- Find project root
              local project_root = vim.fn.finddir('node_modules', '.;')
              if project_root ~= '' then
                return vim.fn.fnamemodify(project_root, ':h')
              end
              return vim.fn.getcwd()
            end,
          },
        },
        -- Logging for debugging
        log_level = vim.log.levels.DEBUG,
      })

      -- Use conform for gq command
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  -- Keep the linting configuration (working)
  {
    'mfussenegger/nvim-lint',
    dependencies = { 'mason.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require('lint')

      lint.linters_by_ft = {
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
      }

      -- Keep working eslint_d configuration
      lint.linters.eslint_d = {
        name = 'eslint_d',
        cmd = function()
          local executables = { 'eslint_d', 'npx eslint' }
          for _, exe in ipairs(executables) do
            if vim.fn.executable(exe) == 1 then
              return exe
            end
          end
          return 'eslint_d'
        end,
        stdin = true,
        append_fname = false,
        args = function()
          local project_root = vim.fn.finddir('node_modules', '.;')
          if project_root ~= '' then
            project_root = vim.fn.fnamemodify(project_root, ':h')
          else
            project_root = vim.fn.getcwd()
          end

          return {
            '--format', 'json',
            '--stdin',
            '--stdin-filename', vim.api.nvim_buf_get_name(0),
            '--resolve-plugins-relative-to', project_root,
          }
        end,
        stream = 'stdout',
        ignore_exitcode = true,
        env = function()
          local project_root = vim.fn.finddir('node_modules', '.;')
          if project_root ~= '' then
            project_root = vim.fn.fnamemodify(project_root, ':h')
            return {
              NODE_PATH = project_root .. '/node_modules',
            }
          end
          return {}
        end,
        parser = function(output, bufnr)
          if output == '' then
            return {}
          end

          if output:match('^Error:') or output:match('Cannot find module') then
            return {}
          end

          local ok, decoded = pcall(vim.json.decode, output)
          if not ok then
            return {}
          end

          if not decoded or not decoded[1] then
            return {}
          end

          local diagnostics = {}
          local messages = decoded[1].messages or {}

          for _, msg in ipairs(messages) do
            table.insert(diagnostics, {
              lnum = math.max(0, (msg.line or 1) - 1),
              col = math.max(0, (msg.column or 1) - 1),
              end_lnum = math.max(0, (msg.endLine or msg.line or 1) - 1),
              end_col = math.max(0, (msg.endColumn or msg.column or 1) - 1),
              severity = msg.severity == 2 and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
              message = msg.message,
              source = 'eslint_d',
              code = msg.ruleId,
            })
          end

          return diagnostics
        end,
      }

      -- Keep working autocmd
      local lint_augroup = vim.api.nvim_create_augroup('angular_lint', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          local ft = vim.bo.filetype
          local supported_fts = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }

          if not vim.tbl_contains(supported_fts, ft) then
            return
          end

          local eslint_configs = {
            '.eslintrc', '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.yaml', 
            '.eslintrc.yml', '.eslintrc.json'
          }

          local current_dir = vim.fn.expand('%:p:h')
          local has_eslint_config = false
          local project_root = nil

          while current_dir ~= '/' and current_dir ~= '' do
            for _, config in ipairs(eslint_configs) do
              if vim.fn.filereadable(current_dir .. '/' .. config) == 1 then
                has_eslint_config = true
                project_root = current_dir
                break
              end
            end

            if vim.fn.filereadable(current_dir .. '/package.json') == 1 then
              project_root = project_root or current_dir
            end

            if has_eslint_config then break end
            current_dir = vim.fn.fnamemodify(current_dir, ':h')
          end

          if has_eslint_config and project_root then
            local node_modules = project_root .. '/node_modules'
            local required_modules = {
              '@typescript-eslint/parser',
              '@angular-eslint/eslint-plugin',
              'eslint'
            }

            local missing_modules = {}
            for _, module in ipairs(required_modules) do
              if vim.fn.isdirectory(node_modules .. '/' .. module) == 0 then
                table.insert(missing_modules, module)
              end
            end

            if #missing_modules > 0 then
              if not vim.g.eslint_deps_warning_shown then
                vim.g.eslint_deps_warning_shown = true
              end
              return
            end

            vim.defer_fn(function()
              pcall(function()
                lint.try_lint('eslint_d')
              end)
            end, 300)
          end
        end,
      })
    end,
  },

  -- Enhanced diagnostics display
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'Trouble',
    keys = {
      { '<leader>cd', '<cmd>Trouble diagnostics toggle<cr>', desc = '🐛 Diagnostics (Trouble)' },
      { '<leader>cD', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = '🐛 Buffer Diagnostics' },
      { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = '🔍 Symbols (Trouble)' },
      { '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = '🔍 LSP Definitions' },
      { '<leader>cL', '<cmd>Trouble loclist toggle<cr>', desc = '📋 Location List' },
      { '<leader>cQ', '<cmd>Trouble qflist toggle<cr>', desc = '📋 Quickfix List' },
    },
    opts = {
      modes = {
        diagnostics = {
          auto_open = false,
          auto_close = true,
          auto_preview = true,
          auto_fold = false,
        },
      },
    },
  },

  -- Mason integration
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'mason.nvim' },
    cmd = { 'MasonToolsInstall', 'MasonToolsUpdate' },
    opts = {
      ensure_installed = {
        'eslint_d',
        'prettierd',
        'prettier', -- Add regular prettier as fallback
      },
      auto_update = false,
      run_on_start = true,
    },
  },
}
