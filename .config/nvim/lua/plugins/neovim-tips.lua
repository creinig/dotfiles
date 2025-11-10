return {
  "saxon1964/neovim-tips",
  version = "*", -- Only update on tagged releases
  lazy = true,  -- Load lazily on keybinds
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- OPTIONAL: Choose your preferred markdown renderer (or omit for raw markdown)
    -- "MeanderingProgrammer/render-markdown.nvim", -- Clean rendering
    -- OR: "OXY2DEV/markview.nvim", -- Rich rendering with advanced features
  },
  opts = {
    -- OPTIONAL: Location of user defined tips (default value shown below)
    -- user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.md",
    -- OPTIONAL: Prefix for user tips to avoid conflicts (default: "[User] ")
    user_tip_prefix = "[User] ",
    -- OPTIONAL: Show warnings when user tips conflict with builtin (default: true)
    warn_on_conflicts = true,
    -- OPTIONAL: Daily tip mode (default: 1)
    -- 0 = off, 1 = once per day, 2 = every startup
    daily_tip = 0,
    -- OPTIONAL: Bookmark symbol (default: "🌟 ")
    bookmark_symbol = "🌟 ",
  },
  keys = {
    {"<leader>uto", ":NeovimTips<CR>", desc = "Neovim tips" },
    {"<leader>utr", ":NeovimTipsRandom<CR>", desc = "Show random tip" },
    {"<leader>utp", ":NeovimTipsPdf<CR>", desc = "Open Neovim tips PDF" },
  },
}