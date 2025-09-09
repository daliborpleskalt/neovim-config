-- lua/plugins/ai/mcphub.lua
-- MCPHub configuration for tool integration

return {
  "ravitemer/mcphub.nvim",
  cmd = { "MCPHub", "MCPHubStart", "MCPHubStop" },
  build = "npm install -g mcp-hub@latest",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("mcphub").setup({
      port = 3000,
      config = vim.fn.expand("~/mcpservers.json"),
      shutdown_delay = 0,
      log = {
        level = vim.log.levels.WARN,
        to_file = false,
      },
    })
  end,
}