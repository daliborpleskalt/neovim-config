-- lua/config/ai-providers.lua
-- Centralized AI provider configurations with validation

local M = {}
local security = require("config.security")

-- Common model configurations
local MODELS = {
  claude = "claude-sonnet-4-20250514",
  openai = "gpt-5-2025-08-07",
  gemini = "gemini-2.5-flash",
  perplexity = "sonar-pro",
}

-- Avante.nvim configuration
function M.get_avante_config()
  return {
    mode = "legacy",
    provider = "openai",

    providers = {
      openai = {
        provider = "gpt-5", -- Use GPT-5 for best cost-performance balance
        api_key = "YOUR_OPENAI_API_KEY",
        extra_request_body = {
          max_tokens = 2048, -- Limit max tokens
          temperature = 0,   -- Lower temp for focused answers
        },
      },
      anthropic = {
        provider = "claude-sonnet-4",
        api_key = "YOUR_CLAUDE_API_KEY",
        extra_request_body = {
          max_tokens = 2048,
          temperature = 0.5,
        },
      },
      google = {
        provider = "gemini-2.5-pro",
        api_key = "YOUR_GOOGLE_API_KEY",
        extra_request_body = {
          max_tokens = 2048,
          temperature = 0.5,
        },
      }
    },

    behaviour = {
      auto_suggestions = false,                 -- Disable auto-suggestions to lower token usage
      enable_token_counting = true,             -- Enable token counting for monitoring
      auto_apply_diff_after_generation = false, -- Prefer manual application of generated code
    },

    dual_boost = {
      enabled = false, -- Disable dual boost to avoid tripling token usage
    },

    rag_service = {
      enabled = false, -- Disable retrieval service unless necessary
    },

    file = {
      -- Use selective file inclusion to avoid scanning entire codebase
      inclusion_patterns = { "**/*.ts", "**/*.js", "**/*.lua", "**/*.json" },
      exclusion_patterns = { "**/*.md", "**/*.png", "**/*.jpg", "**/*.mp4" }, -- Skip non-code binary or doc files
    },

    suggestion = {
      debounce = 1200, -- Increase debounce delay to reduce request frequency
      throttle = 1200, -- Increase throttle time to reduce request frequency
    },

    prompt_logger = {
      enabled = true, -- Log prompts for cost analysis and usage review
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
    security = security.get_security_config(),
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
    security = security.get_security_config(),
  }
end

-- Parrot.nvim configuration
function M.get_parrot_config()
  return {
    providers = {
      anthropic = {
        name = "anthropic",
        api_key = os.getenv("ANTHROPIC_API_KEY"),
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
        api_key = os.getenv("OPENAI_API_KEY"),
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
        api_key = os.getenv("PERPLEXITY_API_KEY"),
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
    security = security.get_security_config(),
  }
end

-- Utility functions for AI management

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
  -- Create user command for viewing AI models
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
