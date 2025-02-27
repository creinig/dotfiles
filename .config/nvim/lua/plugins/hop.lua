return {
  { -- easier motion
    'smoka7/hop.nvim',
    version = "*",
    opts = {
      keys = 'etovxqpdygfblzhckisuran'
    },
    config = function()
      -- place this in one of your configuration file(s)
      require('hop').setup()
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection
      vim.keymap.set('', '<leader>mf', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, {remap=true, desc = "Hop forward like [f]"})
      vim.keymap.set('', '<leader>mF', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, {remap=true, desc = "Hop backward like [F]"})
      vim.keymap.set('', '<leader>mt', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, {remap=true, desc = "Hop forward [t]o char"})
      vim.keymap.set('', '<leader>mT', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, {remap=true, desc = "Hop backward [T]o char" })
      vim.keymap.set('', '<leader>mw', function() hop.hint_words({ }) end, {remap=true, desc = "Hop to [w]ord"})
      vim.keymap.set('', '<leader>mb', '<cmd>HopChar2<cr>' , {remap=true, desc = "Hop to [b]igram"})
      vim.keymap.set('', '<leader>mp', '<cmd>HopPattern<cr>' , {remap=true, desc = "Hop to search [p]attern"})
      vim.keymap.set('', '<leader>mv', '<cmd>HopVertical<cr>' , {remap=true, desc = "Hop [v]ertically"})
      vim.keymap.set('', '<leader>ml', '<cmd>HopLineStart<cr>' , {remap=true, desc = "Hop to [l]ine"})
    end
  }
}
