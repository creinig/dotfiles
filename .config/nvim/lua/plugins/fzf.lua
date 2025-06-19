return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    fzf_opts = {
      -- nullify fzf-lua's settings to inherit from FZF_DEFAULT_OPTS
      -- ["--info"] = false,
      ["--layout"] = false,
    },
  },
  keys = {
    {"<leader><leader>", ":FzfLua buffers<cr>",              desc = "{F]ind open buffers"},
    {"<leader>/",        ":FzfLua blines<cr>",               desc = "[F]ind in current buffer"},
    {"<leader>f/",       ":FzfLua lines<cr>",                desc = "[F]ind in open buffers"},
    {"<leader>fh",       ":FzfLua helptags<cr>",             desc = "[F]ind [H]elp"},
    {"<leader>fk",       ":FzfLua keymaps<cr>",              desc = "[F]ind [K]eymaps"},
    {"<leader>ff",       ":FzfLua files<cr>",                desc = "[F]ind [F]iles"},
    {"<leader>fs",       ":FzfLua builtin<cr>",              desc = "[F]ind [S]elect Picker"},
    -- {"<leader>fS", ':Telescope luasnip<cr>', desc = "[F]ind [S]nippets"}, -- https://gist.github.com/fira42073/c5bc8d4d1f60dc73722acbbf8ab55cb4 ?
    {"<leader>fg",       ":FzfLua live_grep<cr>",            desc = "[F]ind by [G]rep"},
    {"<leader>fG",       ":FzfLua git_files<cr>",            desc = "[F]ind files in [G]it"},
    {"<leader>fd",       ":FzfLua diagnostics_document<cr>", desc = "[F]ind [D]iagnostics"},
    {"<leader>fe",       ":FzfLua resume<cr>",               desc = "[F]ind resum[e]"},
    {"<leader>fr",       ":FzfLua registers<cr>",            desc = "[F]ind [r]egisters"},
    {"<leader>fy",       ":FzfLua registers<cr>",            desc = "[F]ind [y]ank history"},
    {"<leader>fm",       ":FzfLua marks<cr>",                desc = "[F]ind [M]arks"},
    {"<leader>fj",       ":FzfLua jumps<cr>",                desc = "[F]ind [J]umps"},
    {"<leader>f:",       ":FzfLua command_history<cr>",      desc = "[F]ind [:] command history"},
    {"<leader>ft",       ":FzfLua btags<cr>",                desc = "[F]ind [T]ags in current buffer"},
    {"<leader>fT",       ":FzfLua tags<cr>",                 desc = "[F]ind [T]ags in project"},
    -- {"<leader>fo", ':Telescope aerial<cr>', desc = "[F]ind in [O]utline"},
    {"<leader>f.",       ":FzfLua oldfiles<cr>",             desc = '[F]ind Recent Files ("." for repeat)'},

    {"<leader>fn", function() 
      FzfLua.files({ cwd = vim.fn.stdpath("config") })
    end, desc = "[F]ind [N]eovim config files"},

    {"<leader>fc", function ()
      FzfLua.git_files({ git_worktree = vim.fn.expand("~") })
    end, desc = "{F]ind [C]onfig files"},
  },
}