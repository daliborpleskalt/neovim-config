-- lua/plugins/ai/avante.lua
-- Avante.nvim configuration with buffer issue fixes

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  cmd = { "AvanteAsk", "AvanteEdit", "AvanteChat", "AvanteToggle" },
  keys = {
    { "<leader>aa", "<cmd>AvanteAsk<cr>",    desc = "Avante Ask" },
    { "<leader>ae", "<cmd>AvanteEdit<cr>",   mode = "v", desc = "Avante Edit" },
    { "<leader>ac", "<cmd>AvanteChat<cr>",   desc = "Avante Chat" },
    { "<leader>at", "<cmd>AvanteToggle<cr>", desc = "Avante Toggle" },
  },
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  config = function()
  local providers_config = require("config.ai-providers").get_avante_config()
  require("avante").setup(providers_config)

  -- Buffer fix configuration for modifiable issues
  -- vim.api.nvim_create_augroup("AvanteBufferFix", { clear = true })

  -- Ensure Avante buffers are modifiable
  -- vim.api.nvim_create_autocmd("FileType", {
  -- group = "AvanteBufferFix",
  -- pattern = { "Avante", "avante" },
  -- callback = function()
  -- vim.bo.modifiable = true
  -- vim.bo.readonly = false
  -- end,
  -- })

  -- Helper function to ensure buffer is modifiable
  -- local function ensure_modifiable()
  -- if vim.bo.buftype == "" and not vim.bo.readonly then
  -- vim.bo.modifiable = true
  -- end
  -- end

  -- Safe wrapper functions with buffer fixes
  -- vim.keymap.set("n", "<leader>aa", function()
  -- ensure_modifiable()
  -- vim.cmd("AvanteAsk")
  -- end, { desc = "Avante Ask (safe)" })

  -- vim.keymap.set("v", "<leader>ae", function()
  -- ensure_modifiable()
  -- vim.cmd("AvanteEdit")
  -- end, { desc = "Avante Edit (safe)" })

  -- vim.keymap.set("n", "<leader>ac", function()
  -- ensure_modifiable()
  -- vim.cmd("AvanteChat")
  --end, { desc = "Avante Chat (safe)" })
  end,
}
