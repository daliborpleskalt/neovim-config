-- lua/plugins/ai/codecompanion.lua
-- CodeCompanion.nvim configuration for conversational AI

return {
  "olimorris/codecompanion.nvim",
  cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat", "CodeCompanionToggle" },
  keys = {
    { "<leader>cc", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion Chat" },
    { "<leader>ce", "<cmd>CodeCompanionActions<cr>", mode = "v", desc = "CodeCompanion Actions" },
    { "<leader>cm", "<cmd>CodeCompanionToggle<cr>", desc = "CodeCompanion Toggle" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "stevearc/dressing.nvim",
  },
  config = function()
    local config = require("config.ai-providers").get_codecompanion_config()
    require("codecompanion").setup(config)
  end,
}