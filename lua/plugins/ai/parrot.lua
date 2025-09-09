-- lua/plugins/ai/parrot.lua
-- Parrot.nvim configuration for multi-provider AI

return {
  "frankroeder/parrot.nvim",
  cmd = { 
    "ParrotChatNew", 
    "ParrotRewrite", 
    "ParrotAsk", 
    "ParrotImplement",
    "ParrotToggle"
  },
  keys = {
    { "<leader>pp", "<cmd>ParrotChatNew<cr>", desc = "Parrot Chat" },
    { "<leader>pr", "<cmd>ParrotRewrite<cr>", mode = "v", desc = "Parrot Rewrite" },
    { "<leader>pa", "<cmd>ParrotAsk<cr>", desc = "Parrot Ask" },
    { "<leader>pi", "<cmd>ParrotImplement<cr>", mode = "v", desc = "Parrot Implement" },
  },
  dependencies = { 
    "ibhagwan/fzf-lua", 
    "nvim-lua/plenary.nvim" 
  },
  config = function()
    local config = require("config.ai-providers").get_parrot_config()
    require("parrot").setup(config)
  end,
}