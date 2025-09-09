-- lua/config/ai-providers.lua
-- Centralized AI provider configurations with validation

local M = {}

-- Common model configurations
local MODELS = {
  claude = "claude-sonnet-4-20250514",
  openai = "gpt-5-2025-08-07",
  perplexity = "sonar-pro",
}

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

-- Security and rate limiting helper
local function create_security_config()
  return {
    rate_limit = {
      anthropic = { requests_per_hour = 50 },
      openai = { requests_per_hour = 100 },
      perplexity = { requests_per_hour = 200 },
    },
    audit = {
      enabled = true,
      log_file = vim.fn.stdpath("data") .. "/ai_audit.log",
    },
  }
end

-- Avante.nvim configuration
function M.get_avante_config()
  return {
    provider = "claude",
    auto_suggestions_provider = "claude",

    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = MODELS.claude,
        api_key_name = "ANTHROPIC_API_KEY",
        extra_request_body = {
          temperature = 0,
          max_tokens = 8192,
        },
      },
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = MODELS.openai,
        api_key_name = "OPENAI_API_KEY",
        extra_request_body = {
          temperature = 0.1,
          max_tokens = 8192,
        },
      },
      perplexity = {
        __inherited_from = "openai",
        api_key_name = "PERPLEXITY_API_KEY",
        endpoint = "https://api.perplexity.ai/chat/completions",
        model = MODELS.perplexity,
        extra_request_body = {
          temperature = 0.2,
          max_tokens = 8192,
        },
      },
    },

    -- Buffer settings (fixes modifiable issues)
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = false, -- We handle keymaps manually
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      auto_focus_sidebar = false,
    },

    windows = {
      position = "right",
      wrap = true,
      width = 30,
      sidebar_header = {
        align = "center",
        rounded = true,
      },
      edit = {
        border = "rounded",
        start_insert = false,
      },
    },

    mappings = {
      ask = "<leader>aa",
      edit = "<leader>ae",
      chat = "<leader>ac",
      toggle = {
        default = "<leader>at",
      },
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
    },

    hints = { enabled = true },
    highlights = {
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },

    -- Security configuration
    security = create_security_config(),
  }
end

-- CodeCompanion.nvim configuration
function M.get_codecompanion_config()
  return {
    strategies = {
      chat = { adapter = "anthropic" },
      inline = { adapter = "anthropic" },
    },

    adapters = {
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = { api_key = "ANTHROPIC_API_KEY" },
          schema = {
            model = {
              default = MODELS.claude,
              choices = { MODELS.claude, "claude-3-5-haiku-20241022" }
            }
          },
        })
      end,
      openai = function()
        return require("codecompanion.adapters").extend("openai", {
          env = { api_key = "OPENAI_API_KEY" },
          schema = {
            model = {
              default = MODELS.openai,
              choices = { MODELS.openai, "gpt-4o", "gpt-4o-mini" }
            }
          },
        })
      end,
      perplexity = function()
        return require("codecompanion.adapters").extend("openai", {
          env = { api_key = "PERPLEXITY_API_KEY" },
          url = "https://api.perplexity.ai/chat/completions",
          schema = {
            model = {
              default = MODELS.perplexity,
              choices = { MODELS.perplexity, "sonar", "sonar-small" }
            }
          },
        })
      end,
    },

    -- UI configuration
    display = {
      action_palette = {
        width = 95,
        height = 10,
      },
      chat = {
        window = {
          layout = "vertical",
          border = "rounded",
          height = 0.8,
          width = 0.45,
        },
      },
    },

    -- Security configuration
    security = create_security_config(),
  }
end

-- Parrot.nvim configuration
function M.get_parrot_config()
  return {
    providers = {
      anthropic = {
        name = "anthropic",
        api_key = get_api_key("ANTHROPIC_API_KEY"),
        endpoint = "https://api.anthropic.com/v1/messages",
        model = MODELS.claude,
        topic = {
          model = MODELS.claude,
          params = { max_tokens = 8192, temperature = 0.7 },
        },
        command = {
          model = MODELS.claude,
          params = { max_tokens = 8192, temperature = 0.1 },
        },
      },

      openai = {
        name = "openai",
        api_key = get_api_key("OPENAI_API_KEY"),
        endpoint = "https://api.openai.com/v1",
        model = MODELS.openai,
        topic = {
          model = MODELS.openai,
          params = { max_tokens = 8192, temperature = 0.7 },
        },
        command = {
          model = MODELS.openai,
          params = { max_tokens = 8192, temperature = 0.1 },
        },
      },

      perplexity = {
        name = "perplexity",
        api_key = get_api_key("PERPLEXITY_API_KEY"),
        endpoint = "https://api.perplexity.ai/chat/completions",
        model = MODELS.perplexity,
        topic = {
          model = MODELS.perplexity,
          params = { max_tokens = 8192, temperature = 0.2 },
        },
        command = {
          model = MODELS.perplexity,
          params = { max_tokens = 4096, temperature = 0.1 },
        },
      },
    },

    -- UI styling
    style_popup_border = "rounded",
    command_auto_select_response = true,

    -- Chat configuration
    chat = {
      welcome_message = "🤖 Welcome to Parrot AI chat! How can I assist you today?",
      prompt_prefix = "🗨️ ",
      user_prefix = "👤 You: ",
      assistant_prefix = "🤖 Assistant: ",
      max_context_length = 8000,
    },

    -- Security configuration
    security = create_security_config(),
  }
end

-- Utility functions for AI management

-- Check if all API keys are configured
function M.validate_api_keys()
  local required_keys = {
    "ANTHROPIC_API_KEY",
    "OPENAI_API_KEY",
    "PERPLEXITY_API_KEY"
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

-- Get current model configurations
function M.get_models()
  return MODELS
end

-- Update model for a specific provider
function M.set_model(provider, model)
  MODELS[provider] = model
  vim.notify(
    string.format("Updated %s model to: %s", provider, model),
    vim.log.levels.INFO,
    { title = "AI Configuration" }
  )
end

-- Initialize AI providers (called during setup)
function M.init()
  -- Validate API keys on startup
  vim.defer_fn(function()
    M.validate_api_keys()
  end, 1000)

  -- Create user commands for AI management
  vim.api.nvim_create_user_command("AIStatus", function()
    M.validate_api_keys()
  end, { desc = "Check AI provider status" })

  vim.api.nvim_create_user_command("AIModels", function()
    local models = M.get_models()
    local status = { "🤖 Current AI Models:" }
    for provider, model in pairs(models) do
      table.insert(status, string.format("   %s: %s", provider, model))
    end
    vim.notify(table.concat(status, "\n"), vim.log.levels.INFO)
  end, { desc = "Show current AI models" })
end

return M

