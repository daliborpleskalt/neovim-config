local M = {}

-- Store autocmd group IDs
local lint_augroup_id = nil
local format_augroup_id = nil

-- Setup function for linters and formatters
function M.setup()
  -- Configure diagnostics display
  vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = 'if_many',
      prefix = '●',
    },
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '✘',
        [vim.diagnostic.severity.WARN] = '▲',
        [vim.diagnostic.severity.HINT] = '⚑',
        [vim.diagnostic.severity.INFO] = '»',
      },
    },
  })

  -- Enhanced formatting function with multiple fallbacks
  M.format_buffer = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local ft = vim.bo[bufnr].filetype

    local prettier_fts = {
      'javascript', 'typescript', 'javascriptreact', 'typescriptreact',
      'html', 'css', 'scss', 'json', 'jsonc', 'yaml', 'markdown'
    }

    if not vim.tbl_contains(prettier_fts, ft) then
      -- Use LSP formatting for non-prettier file types
      vim.lsp.buf.format({ bufnr = bufnr })
      return
    end

    -- Try conform.nvim first
    local conform_ok, conform = pcall(require, 'conform')
    if conform_ok then
      local success = conform.format({
        bufnr = bufnr,
        timeout_ms = 5000,
        quiet = true,
      })

      if success then
        vim.notify('✨ Formatted with conform.nvim', vim.log.levels.INFO)
        return
      else
        vim.notify('⚠️ conform.nvim failed, trying fallbacks...', vim.log.levels.WARN)
      end
    end

    -- Fallback to manual prettier
    M.format_with_prettier_fallback(bufnr)
  end

  -- Fallback formatting function using direct prettier commands
  M.format_with_prettier_fallback = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)

    if filename == '' then
      vim.notify('Buffer not saved, cannot format', vim.log.levels.WARN)
      return
    end

    -- Find project root
    local project_root = vim.fn.finddir('node_modules', '.;')
    if project_root ~= '' then
      project_root = vim.fn.fnamemodify(project_root, ':h')
    else
      project_root = vim.fn.getcwd()
    end

    -- Try different prettier commands
    local commands = {
      { 'npx', 'prettier', '--write', filename },
      { 'prettier', '--write', filename },
      { project_root .. '/node_modules/.bin/prettier', '--write', filename },
    }

    local success = false
    for _, cmd in ipairs(commands) do
      -- Check if command exists
      if vim.fn.executable(cmd[1]) == 1 or cmd[1]:match('^/') then
        local result = vim.fn.system(cmd)
        if vim.v.shell_error == 0 then
          vim.cmd('checktime') -- Reload buffer
          vim.notify('✨ Formatted with ' .. cmd[1], vim.log.levels.INFO)
          success = true
          break
        end
      end
    end

    if not success then
      vim.notify('❌ All formatting methods failed. Is Prettier installed?', vim.log.levels.ERROR)
    end
  end

  -- Check formatting tools availability
  M.check_formatting_tools = function()
    local tools = {
      { 'prettierd', 'prettierd --version' },
      { 'prettier', 'prettier --version' },
      { 'npx prettier', 'npx prettier --version' },
    }

    local status = {}
    table.insert(status, '🎨 Formatting Tools Status:')
    table.insert(status, '')

    for _, tool in ipairs(tools) do
      local name, cmd = tool[1], tool[2]
      local result = vim.fn.system(cmd .. ' 2>/dev/null')
      if vim.v.shell_error == 0 then
        table.insert(status, '✅ ' .. name .. ': ' .. result:gsub('\n', ''))
      else
        table.insert(status, '❌ ' .. name .. ': Not available')
      end
    end

    -- Check conform.nvim status
    local conform_ok, conform = pcall(require, 'conform')
    if conform_ok then
      table.insert(status, '✅ conform.nvim: Loaded')

      -- Check configured formatters
      local ft = vim.bo.filetype
      local formatters = conform.list_formatters(0)
      if #formatters > 0 then
        table.insert(status, '📋 Available formatters for ' .. ft .. ':')
        for _, formatter in ipairs(formatters) do
          table.insert(status, '   • ' .. formatter.name .. (formatter.available and ' ✅' or ' ❌'))
        end
      else
        table.insert(status, '⚠️  No formatters configured for ' .. ft)
      end
    else
      table.insert(status, '❌ conform.nvim: Not loaded')
    end

    -- Check for prettier config
    local prettier_configs = { '.prettierrc', '.prettierrc.json', '.prettierrc.js', 'prettier.config.js' }
    local config_found = false

    for _, config in ipairs(prettier_configs) do
      if vim.fn.filereadable(config) == 1 then
        table.insert(status, '✅ Prettier config: Found ' .. config)
        config_found = true
        break
      end
    end

    if not config_found then
      table.insert(status, '⚠️ No Prettier config found (using defaults)')
    end

    vim.notify(table.concat(status, '\n'), vim.log.levels.INFO)
  end

  -- Install formatting tools
  M.install_formatting_tools = function()
    local project_root = vim.fn.finddir('package.json', '.;')
    if project_root == '' then
      vim.notify('No package.json found. Installing globally...', vim.log.levels.INFO)

      -- Install globally
      local cmd = { 'npm', 'install', '-g', 'prettier' }
      vim.fn.jobstart(cmd, {
        on_exit = function(_, code)
          if code == 0 then
            vim.notify('✅ Prettier installed globally!', vim.log.levels.INFO)
          else
            vim.notify('❌ Failed to install Prettier globally', vim.log.levels.ERROR)
          end
        end,
      })
      return
    end

    project_root = vim.fn.fnamemodify(project_root, ':h')

    vim.notify('Installing Prettier in project...', vim.log.levels.INFO)

    local cmd = { 'npm', 'install', '--save-dev', 'prettier' }
    vim.fn.jobstart(cmd, {
      cwd = project_root,
      on_exit = function(_, code)
        if code == 0 then
          vim.notify('✅ Prettier installed in project!', vim.log.levels.INFO)
        else
          vim.notify('❌ Failed to install Prettier in project', vim.log.levels.ERROR)
        end
      end,
    })
  end

  -- Test formatting on current buffer
  M.test_formatting = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.bo[bufnr].filetype

    vim.notify('🧪 Testing formatting for ' .. ft .. ' file...', vim.log.levels.INFO)

    -- Save original content
    local original_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    -- Try formatting
    M.format_buffer(bufnr)

    -- Check if content changed
    vim.defer_fn(function()
      local new_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local changed = not vim.deep_equal(original_lines, new_lines)

      if changed then
        vim.notify('✅ Formatting test successful - content was modified', vim.log.levels.INFO)
      else
        vim.notify('⚠️ Formatting test - no changes detected (file might already be formatted)', vim.log.levels.WARN)
      end
    end, 500)
  end

  -- Keep working Angular dependency functions
  M.check_angular_dependencies = function()
    local project_root = vim.fn.finddir('node_modules', '.;')
    if project_root == '' then
      vim.notify('No node_modules found. Run: npm install', vim.log.levels.WARN)
      return false
    end

    project_root = vim.fn.fnamemodify(project_root, ':h')
    local node_modules = project_root .. '/node_modules'

    local required_modules = {
      '@typescript-eslint/parser',
      '@typescript-eslint/eslint-plugin',
      '@angular-eslint/eslint-plugin',
      'eslint'
    }

    local missing_modules = {}
    local found_modules = {}

    for _, module in ipairs(required_modules) do
      if vim.fn.isdirectory(node_modules .. '/' .. module) == 1 then
        table.insert(found_modules, '✅ ' .. module)
      else
        table.insert(missing_modules, '❌ ' .. module)
      end
    end

    local status = {}
    table.insert(status, 'Project: ' .. project_root)
    table.insert(status, '')
    table.insert(status, 'Found dependencies:')
    for _, module in ipairs(found_modules) do
      table.insert(status, module)
    end

    if #missing_modules > 0 then
      table.insert(status, '')
      table.insert(status, 'Missing dependencies:')
      for _, module in ipairs(missing_modules) do
        table.insert(status, module)
      end
    end

    vim.notify(table.concat(status, '\n'), vim.log.levels.INFO)
    return #missing_modules == 0
  end

  -- Enhanced lint function (keep working version)
  M.lint_buffer = function()
    if not M.check_angular_dependencies() then
      return
    end

    local ok, lint = pcall(require, 'lint')
    if not ok then
      vim.notify('nvim-lint not available', vim.log.levels.WARN)
      return
    end

    local success, err = pcall(function()
      lint.try_lint('eslint_d')
    end)

    if success then
      vim.notify('🔍 Linting completed', vim.log.levels.INFO)
    else
      vim.notify('Linting error: ' .. tostring(err), vim.log.levels.ERROR)
    end
  end

  -- Format and save with better error handling
  M.format_and_save = function()
    local bufnr = vim.api.nvim_get_current_buf()

    -- Save original content to detect changes
    local original_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    M.format_buffer(bufnr)

    -- Wait a bit for formatting to complete, then save
    vim.defer_fn(function()
      local new_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local changed = not vim.deep_equal(original_lines, new_lines)

      vim.cmd('write')

      if changed then
        vim.notify('💾 Formatted and saved', vim.log.levels.INFO)
      else
        vim.notify('💾 Saved (no formatting changes)', vim.log.levels.INFO)
      end
    end, 200)
  end

  -- Other functions (keep existing working versions)
  M.disable_auto_lint = function()
    pcall(function()
      vim.api.nvim_clear_autocmds({ 
        event = { 'BufEnter', 'BufWritePost', 'InsertLeave' },
        pattern = { '*.js', '*.ts', '*.jsx', '*.tsx' }
      })
    end)
    vim.notify('🚫 Auto-linting disabled', vim.log.levels.INFO)
  end

  M.show_line_diagnostics = function()
    vim.diagnostic.open_float({
      border = 'rounded',
      source = 'always',
      header = '',
      scope = 'line',
    })
  end

  M.goto_next_diagnostic = function()
    vim.diagnostic.goto_next({ border = 'rounded' })
  end

  M.goto_prev_diagnostic = function()
    vim.diagnostic.goto_prev({ border = 'rounded' })
  end

  M.ai_fix_diagnostics = function()
    local diagnostics = vim.diagnostic.get(0)
    if #diagnostics == 0 then
      vim.notify('No diagnostics found', vim.log.levels.INFO)
      return
    end

    local line = vim.api.nvim_get_current_line()
    local line_diagnostics = {}
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1] - 1

    for _, diagnostic in ipairs(diagnostics) do
      if diagnostic.lnum == cursor_line then
        table.insert(line_diagnostics, diagnostic.message)
      end
    end

    if #line_diagnostics > 0 then
      local prompt = string.format([[
Fix this Angular/TypeScript issue:

Code: %s

Errors/Warnings:
%s

Please provide corrected code and explanation.
]], line, table.concat(line_diagnostics, '\n'))

      local ok = pcall(vim.cmd, 'AvanteAsk ' .. vim.fn.shellescape(prompt))
      if not ok then
        vim.notify('Avante not available for AI assistance.', vim.log.levels.WARN)
      end
    else
      vim.notify('No diagnostics on current line', vim.log.levels.INFO)
    end
  end

  M.setup_keybindings()
end

-- Setup keybindings with enhanced formatting commands
function M.setup_keybindings()
  local opts = { noremap = true, silent = true }

  -- Enhanced formatting
  vim.keymap.set({ 'n', 'v' }, '<leader>cf', M.format_buffer, 
    vim.tbl_extend('force', opts, { desc = '🎨 Format buffer' }))
  vim.keymap.set('n', '<leader>cF', M.format_and_save, 
    vim.tbl_extend('force', opts, { desc = '💾 Format and save' }))

  -- Formatting diagnostics and tools
  vim.keymap.set('n', '<leader>cft', M.check_formatting_tools, 
    vim.tbl_extend('force', opts, { desc = '🔍 Check formatting tools' }))
  vim.keymap.set('n', '<leader>cfi', M.install_formatting_tools, 
    vim.tbl_extend('force', opts, { desc = '📦 Install formatting tools' }))
  vim.keymap.set('n', '<leader>cfx', M.test_formatting, 
    vim.tbl_extend('force', opts, { desc = '🧪 Test formatting' }))
  vim.keymap.set('n', '<leader>cfp', M.format_with_prettier_fallback, 
    vim.tbl_extend('force', opts, { desc = '🎨 Format with prettier fallback' }))

  -- Linting (keep working commands)
  vim.keymap.set('n', '<leader>cl', M.lint_buffer, 
    vim.tbl_extend('force', opts, { desc = '🔍 Lint buffer' }))
  vim.keymap.set('n', '<leader>cad', M.check_angular_dependencies, 
    vim.tbl_extend('force', opts, { desc = '📦 Check Angular dependencies' }))

  -- Linting controls
  vim.keymap.set('n', '<leader>cld', M.disable_auto_lint, 
    vim.tbl_extend('force', opts, { desc = '🚫 Disable auto-linting' }))

  -- Diagnostics navigation
  vim.keymap.set('n', ']d', M.goto_next_diagnostic, 
    vim.tbl_extend('force', opts, { desc = '➡️ Next diagnostic' }))
  vim.keymap.set('n', '[d', M.goto_prev_diagnostic, 
    vim.tbl_extend('force', opts, { desc = '⬅️ Previous diagnostic' }))
  vim.keymap.set('n', '<leader>cd', M.show_line_diagnostics, 
    vim.tbl_extend('force', opts, { desc = '🔍 Show diagnostics' }))

  -- AI-powered fixes
  vim.keymap.set('n', '<leader>cai', M.ai_fix_diagnostics, 
    vim.tbl_extend('force', opts, { desc = '🤖 AI fix diagnostics' }))
end

-- Enhanced auto-format on save
function M.setup_autoformat()
  local format_on_save_fts = {
    'javascript', 'typescript', 'javascriptreact', 'typescriptreact',
    'html', 'css', 'scss', 'json', 'jsonc'
  }

  format_augroup_id = vim.api.nvim_create_augroup('enhanced_format_on_save', { clear = true })

  vim.api.nvim_create_autocmd('BufWritePre', {
    group = format_augroup_id,
    pattern = '*.js,*.ts,*.jsx,*.tsx,*.html,*.css,*.scss,*.json',
    callback = function()
      local ft = vim.bo.filetype
      if vim.tbl_contains(format_on_save_fts, ft) then
        -- Use the enhanced format function
        M.format_buffer()
      end
    end,
    desc = 'Auto-format before save with fallbacks',
  })
end

-- Toggle auto-format on save
M.auto_format_enabled = true
function M.toggle_auto_format()
  M.auto_format_enabled = not M.auto_format_enabled
  if M.auto_format_enabled then
    M.setup_autoformat()
    vim.notify('✅ Auto-format enabled', vim.log.levels.INFO)
  else
    if format_augroup_id then
      vim.api.nvim_clear_autocmds({ group = format_augroup_id })
    end
    vim.notify('❌ Auto-format disabled', vim.log.levels.WARN)
  end
end

-- Initialize everything
function M.init()
  M.setup()
  if M.auto_format_enabled then
    M.setup_autoformat()
  end
end

return M
