-- Toplevel plugin configuration, containing multiple small plugin definitions.
-- More complex definitions should be in their own file.
--
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

  {
    "wtfox/jellybeans.nvim",
    priority = 1000,
    config = function()
      require("jellybeans").setup()
      vim.cmd.colorscheme("jellybeans")
    end,
  },

  {
    "szw/vim-maximizer",
    keys = {
      { "<F3>", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
    },
  },

  -- Highlight todo, notes, etc in comments
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = { signs = false },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
}

