return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  dependencies = {
    'hrsh7th/nvim-cmp',
  },
  config = function()
    local autopairs = require('nvim-autopairs')
    local cmp = require('cmp')
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')

    -- Setup autopairs with custom configuration
    autopairs.setup({
      check_ts = true, -- Enable treesitter integration
      ts_config = {
        lua = { 'string' }, -- Don't add pairs in lua string treesitter nodes
        javascript = { 'template_string' },
        java = false, -- Don't check treesitter on java
      },
      
      -- Performance optimizations
      disable_filetype = { "TelescopePrompt", "vim", "guihua", "guihua_rust", "clap_input" },
      disable_in_macro = true, -- Disable when recording or executing a macro
      disable_in_visualblock = false, -- Disable when insert after visual block mode
      disable_in_replace_mode = true,
      
      -- Pair behavior configuration
      ignored_next_char = "[%w%.]", -- Will ignore alphanumeric and `.` symbol
      enable_moveright = true,
      enable_afterquote = true, -- Add bracket pairs after quote
      enable_check_bracket_line = true, -- Check bracket in same line
      enable_bracket_in_quote = true, -- Add bracket pairs in quote
      enable_abbr = false, -- Trigger abbreviation
      break_undo = true, -- Switch for basic rule break undo sequence
      
      -- Custom map configuration
      map_cr = true,
      map_bs = true, -- Map the <BS> key
      map_c_h = false, -- Map the <C-h> key to delete a pair
      map_c_w = false, -- Map <c-w> to delete a pair if possible
      
      -- Fast wrap configuration
      fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'PmenuSel',
        highlight_grey = 'LineNr'
      },
    })

    -- Integration with nvim-cmp
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    -- Custom rules for specific filetypes
    local Rule = require('nvim-autopairs.rule')
    local cond = require('nvim-autopairs.conds')

    -- Add spaces in brackets for specific languages
    autopairs.add_rules({
      Rule(' ', ' ')
        :with_pair(function (opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({ '()', '[]', '{}' }, pair)
        end),
      Rule('( ', ' )')
        :with_pair(function() return false end)
        :with_move(function(opts)
          return opts.prev_char:match('.%)') ~= nil
        end)
        :use_key(')'),
      Rule('{ ', ' }')
        :with_pair(function() return false end)
        :with_move(function(opts)
          return opts.prev_char:match('.%}') ~= nil
        end)
        :use_key('}'),
      Rule('[ ', ' ]')
        :with_pair(function() return false end)
        :with_move(function(opts)
          return opts.prev_char:match('.%]') ~= nil
        end)
        :use_key(']')
    })

    -- Language-specific rules
    -- Remove single quote autopairs for Rust (lifetime syntax)
    autopairs.get_rules("'")[1].not_filetypes = { "rust" }

    -- HTML/JSX tag auto-closing (works with your treesitter config)
    autopairs.add_rules({
      Rule('>', '></' .. "!cursor!" .. '>')
        :with_pair(cond.not_before_regex("[%w]"))
        :with_move(function(opts) return opts.char == '>' end)
        :with_cr(cond.none())
        :with_del(cond.none())
        :only_cr(cond.before_regex('<[^>]*'))
        :set_end_pair_length(0)
        :replace_endpair(function()
          return '</' .. require('nvim-autopairs.ts-conds').is_ts_node({'tag_name'}) .. '>'
        end)
    })

    -- Add custom keymaps for toggling autopairs
    vim.keymap.set('n', '<leader>tp', function()
      if require('nvim-autopairs').state.disabled then
        require('nvim-autopairs').enable()
        vim.notify('Autopairs enabled', vim.log.levels.INFO)
      else
        require('nvim-autopairs').disable()
        vim.notify('Autopairs disabled', vim.log.levels.INFO)
      end
    end, { desc = 'Toggle autopairs' })
  end,
}
