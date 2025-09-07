-- ~/.config/nvim/lua/config/security.lua
-- Security best practices implementation

local M = {}

-- API Key validation
M.validate_api_keys = function()
  local required_keys = {
    'ANTHROPIC_API_KEY',
    'OPENAI_API_KEY', 
    'PERPLEXITY_API_KEY'
  }

  local missing_keys = {}
  for _, key in ipairs(required_keys) do
    if not os.getenv(key) or os.getenv(key) == '' then
      table.insert(missing_keys, key)
    end
  end

  if #missing_keys > 0 then
    vim.notify(
      'Missing API keys: ' .. table.concat(missing_keys, ', ') .. 
      '\nPlease set them in your environment variables.',
      vim.log.levels.WARN
    )
  end
end

-- API request logging for audit trails
M.log_ai_request = function(provider, prompt_preview)
  local log_file = vim.fn.stdpath('data') .. '/ai_audit.log'
  local timestamp = os.date('%Y-%m-%d %H:%M:%S')
  local entry = string.format('[%s] Provider: %s | Prompt: %s\n', 
    timestamp, provider, prompt_preview:sub(1, 50) .. '...')

  local file = io.open(log_file, 'a')
  if file then
    file:write(entry)
    file:close()
  end
end

-- Rate limiting for API calls
M.rate_limiter = {
  requests = {},
  limits = {
    anthropic = { count = 0, limit = 50, window = 3600 }, -- 50/hour
    openai = { count = 0, limit = 100, window = 3600 },   -- 100/hour
    perplexity = { count = 0, limit = 200, window = 3600 } -- 200/hour
  }
}

M.check_rate_limit = function(provider)
  local now = os.time()
  local limit_data = M.rate_limiter.limits[provider]

  if not limit_data then return true end

  -- Reset counter if window expired
  if not M.rate_limiter.last_reset or 
     (now - M.rate_limiter.last_reset) > limit_data.window then
    limit_data.count = 0
    M.rate_limiter.last_reset = now
  end

  if limit_data.count >= limit_data.limit then
    vim.notify(
      string.format('Rate limit exceeded for %s. Try again later.', provider),
      vim.log.levels.ERROR
    )
    return false
  end

  limit_data.count = limit_data.count + 1
  return true
end

-- Secure file access restrictions
M.setup_file_restrictions = function()
  -- Restrict MCP filesystem access to project directories
  vim.g.mcp_allowed_dirs = {
    vim.fn.getcwd(),
    vim.fn.expand('~/Projects'),
    vim.fn.expand('~/Development'),
  }
end

-- Initialize security measures
M.setup = function()
  M.validate_api_keys()
  M.setup_file_restrictions()

  -- Set secure defaults
  vim.opt.modeline = false -- Disable modelines for security
  vim.opt.exrc = false     -- Disable automatic sourcing of .nvimrc files
end

return M
