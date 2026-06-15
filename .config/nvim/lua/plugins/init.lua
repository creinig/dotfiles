-- Toplevel plugin configuration, containing multiple small plugin definitions.
-- More complex definitions should be in their own file.
--
return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'jmcantrell/vim-diffchanges', -- diff changes to buffer since last write
  'nvim-tree/nvim-web-devicons', -- dependency for others. Hopefully specifying it here will stop it from updating despite the lock
  'b0o/schemastore.nvim', -- schema storage for LSPs

  {
    'AndrewRadev/linediff.vim', -- diff two visual selections
    cmd = "Linediff",
  },

  {
    'will133/vim-dirdiff', -- diff directory hierarchies
    init = function()
      vim.g.DirDiffExcludes = "CVS,.git,node_modules,*.class,*.exe,.*.swp,*.war,*.jar"
    end
  },

  {
    "dstein64/nvim-scrollview",
    lazy = false,
    opts = {
      current_only = true,
    },
  },

  {
    'unblevable/quick-scope', -- hints for f/t motions
    init = function()
      -- Trigger a highlight in the appropriate direction when pressing these keys:
      vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
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
    lazy = false,
    priority = 1000,
    opts = {
      on_highlights = function(hl, _)
        hl.DiffAdd = { bold = true,   fg = "none", bg = "#2e4b2e" }
        hl.DiffDelete = { bold = true, fg = "none", bg = "#4c1e15" }
        hl.DiffText = { reverse = true,  fg = "none", bg = "#996d74" }
        hl.DiffChange = { bold = true, fg = "none", bg = "#45565c" }
        hl.RenderMarkdownH1Bg ={ fg = '#b0d0f0', bg='#23273b' }
        hl.RenderMarkdownH2Bg ={ fg = '#c6b6ee', bg='#2d282c' }
        hl.RenderMarkdownH3Bg ={ fg = '#d2ebbe', bg='#252c2c' }
        hl.RenderMarkdownChecked = { fg = '#55ff55' }
        hl.RenderMarkdownRejected = { fg = '#ff5370' }
        hl.RenderMarkdownInProgress = { fg = '#89ddff' }
        hl.RenderMarkdownImportant = { fg = '#ffcc00' }
      end
    },
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme jellybeans]])
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
    'junegunn/gv.vim',
    dependencies = {
      "tpope/vim-fugitive"
    },
    cmd = "GV",
    keys = {
      { "<leader>gv", ":GV -n 1000<cr>", {desc = "[G]it [v]iew log" }},
      { "<leader>gv", ":GV -n 1000<cr>", {desc = "[G]it [v]iew log", mode = "v" }},
      { "<leader>gV", ":GV! -n 1000<cr>", {desc = "[G]it [v]iew log (this file)" }},
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {},
  },

  {
    "junegunn/vim-easy-align",
    keys = {
      {"ga", "<Plug>(EasyAlign)", mode = "x", desc = "EasyAlign"},
      {"ga", "<Plug>(EasyAlign)", mode = "v", desc = "EasyAlign"},
      {"ga", "<Plug>(EasyAlign)", mode = "n", desc = "EasyAlign"},
    },
  },
  
  {
    'MagicDuck/grug-far.nvim',
    cmd = { "GrugFar", },
    keys = {
      {"<leader>ur", "<cmd>GrugFar<cr>", desc = "Search / [R]eplace in files" },
    }
  },

}