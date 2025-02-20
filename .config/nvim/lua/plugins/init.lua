return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'jmcantrell/vim-diffchanges', -- diff changes to buffer since last write
  'AndrewRadev/linediff.vim', -- diff two visual selections
  'will133/vim-dirdiff', -- diff directory hierarchies

  {
    'tomtom/ttodo_vim',          -- todo.txt support
    dependencies = {
      'tomtom/tlib_vim'           -- required for ttodo_vim
    },
    config = function()
      vim.cmd [[
        let g:ttodo#dirs = ['~/']
        let g:ttodo#sort = 'done,-next,-overdue,pri,due,lists,tags,idx'
        let g:ttodo#ftplugin#add_at_eof = 'false'
        ]]
    end
  },

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
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }
      
      -- require('mini.align').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}

