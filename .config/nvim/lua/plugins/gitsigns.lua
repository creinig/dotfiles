return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    -- See `:help gitsigns` to understand what the configuration keys do
    lazy = false,
    keys = {
      { "<leader>gB", ":Gitsigns blame<cr>", { desc = "[G]it [b]lame" }},
      { "<leader>gb", ":Gitsigns blame_line<cr>", { desc = "[G]it [b]lame (line)" }},
    },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },
}