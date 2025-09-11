-- ~/.config/nvim/lua/config/security.lua
-- Centralized security configurations for AI providers and other plugins

local M = {}

-- API key validation with user-friendly messages
local function get_api_key(key_name)
  local key = os.getenv(key_name)
  if not key or key == "" then
    vim.notify(
      string.format("⚠️  Missing API key: %s\nPlease set it in your environment variables.", key_name),
      vim.log.levels.WARN,
      { title = "AI Configuration" }
    )
    return nil
  end
  return key
end

-- Check if all API keys are configured
function M.validate_api_keys()
  local required_keys = {
    "ANTHROPIC_API_KEY",
    "OPENAI_API_KEY",
    "PERPLEXITY_API_KEY",
    "GEMINI_API_KEY",
  }

  local missing_keys = {}
  local valid_keys = {}

  for _, key in ipairs(required_keys) do
    if get_api_key(key) then
      table.insert(valid_keys, key)
    else
      table.insert(missing_keys, key)
    end
  end

  local status = {}
  table.insert(status, "🔑 API Key Status:")
  table.insert(status, "")

  for _, key in ipairs(valid_keys) do
    table.insert(status, "✅ " .. key .. ": Configured")
  end

  for _, key in ipairs(missing_keys) do
    table.insert(status, "❌ " .. key .. ": Missing")
  end

  if #missing_keys > 0 then
    table.insert(status, "")
    table.insert(status, "💡 Set missing keys in your environment variables:")
    table.insert(status, "   export API_KEY_NAME=\"your-key-here\"")
  end

  vim.notify(
    table.concat(status, "\n"),
    #missing_keys > 0 and vim.log.levels.WARN or vim.log.levels.INFO,
    { title = "AI Configuration" }
  )

  return #missing_keys == 0
end

-- API request logging for audit trails
function M.log_ai_request(provider, prompt_preview)
  local log_file = vim.fn.stdpath("data") .. "/ai_audit.log"
  local timestamp = os.date("%Y-%m-%d %H:%M:%S")
  local entry = string.format("[%s] Provider: %s | Prompt: %s\n", timestamp, provider, prompt_preview:sub(1, 50) .. "...")

  local file = io.open(log_file, "a")
  if file then
    file:write(entry)
    file:close()
  end
end

-- Security and rate limiting configuration for AI plugins
function M.get_security_config()
  return {
    rate_limit = {
      anthropic = { requests_per_hour = 3000 },
      openai = { requests_per_hour = 30000 },
      perplexity = { requests_per_hour = 300 },
      gemini = { requests_per_hour = 900 },
    },
    audit = {
      enabled = true,
      log_file = vim.fn.stdpath("data") .. "/ai_audit.log",
    },
  }
end

-- Initialize security checks (called during setup)
function M.init()
  -- Validate API keys on startup
  vim.defer_fn(function()
    M.validate_api_keys()
  end, 1000)

  -- Create user commands for security management
  vim.api.nvim_create_user_command("AIKeyStatus", function()
    M.validate_api_keys()
  end, { desc = "Check AI provider API key status" })
end

return M
