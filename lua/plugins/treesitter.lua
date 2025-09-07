-- ~/.config/nvim/lua/plugins/treesitter.lua
-- Tree-sitter configuration for syntax highlighting

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'typescript',
        'tsx',
        'javascript',
        'html',
        'css',
        'scss',
        'json',
        'rust',
        'java',
        'lua',
        'vim',
        'vimdoc',
        'markdown',
        'markdown_inline',
      },
      auto_install = true,
      sync_install = false,
      ignore_install = {},

      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
        disable = { 'yaml', 'python' },
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    })
  end,
}
