return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed.
    "ibhagwan/fzf-lua",              -- optional
  },
  cmd = { "Neogit" },
  opts = {
    disable_insert_on_commit = true,
    graph_style = "unicode",
    use_per_project_settings = false,
    console_timeout = 500,
  },
}