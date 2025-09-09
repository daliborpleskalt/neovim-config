-- lua/plugins/typescript.lua
-- Consolidated TypeScript/Angular configuration with optimizations

return {
  -- Mason for tool management
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = { border = "rounded" },
    },
  },

  -- Enhanced formatting with conform.nvim
  {
    "stevearc/conform.nvim",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "html", "css" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- Linting with nvim-lint
  {
    "mfussenegger/nvim-lint",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      -- Auto-lint on specific events
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- Tool installer integration
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "angular-language-server",
        "eslint_d",
        "prettierd",
        "prettier",
      },
      auto_update = false,
      run_on_start = false, -- Only install when needed
    },
  },
}