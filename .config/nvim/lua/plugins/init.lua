return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'jmcantrell/vim-diffchanges', -- diff changes to buffer since last write
  'AndrewRadev/linediff.vim', -- diff two visual selections

  {
    'will133/vim-dirdiff', -- diff directory hierarchies
    init = function()
      vim.g.DirDiffExcludes = "CVS,.git,node_modules,*.class,*.exe,.*.swp,*.war,*.jar"
    end
  },

  {
    'unblevable/quick-scope', -- hints for f/t motions
    init = function()
      -- Trigger a highlight in the appropriate direction when pressing these keys:
      vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
    end
  },

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

  { -- easily access & handle undo history
    'mbbill/undotree',
    init = function()
      vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle, { desc = "Toggle [U]ndo history" })
      vim.g.undotree_WindowLayout = 2
      vim.g.unditree_ShortIndicators = 1
      vim.g.undotree_DiffpanelHeight = 15
      vim.g.undotree_SetFocusWhenToggle = 1
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
      require('mini.move').setup()

      -- require('mini.align').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      -- local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      -- statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}

