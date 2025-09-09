-- lua/plugins/ai/init.lua
-- AI plugins main entry point with lazy loading

return {
  { import = "plugins.ai.avante" },
  { import = "plugins.ai.codecompanion" },
  { import = "plugins.ai.parrot" },
  { import = "plugins.ai.mcphub" },
}