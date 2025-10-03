return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git" },
    keys = {
      -- See also diffview.lua for more mappings
      { "<leader>gs", ":Git<cr>", { desc = "[G]it status" }},
      { "<leader>ga", ":Git add %", { desc = "[G]it [a]dd" }},
      { "<leader>gc", ":Git commit -v -c HEAD --reset-author<cr>", { desc = "[G]it [commit] (prefill last msg)" }},
      { "<leader>gC", ":Git commit --amend<cr>", { desc = "[G]it [c]ommit (amend)" }},
      { "<leader>gp", ":Git push<space>", { desc = "[G]it [p]ush" }},
      { "<leader>gf", ":Git fetch<space>", { desc = "[G]it [f]etch" }},
      { "<leader>gl", ":Git pull<space>", { desc = "[G]it pul[l]" }},
      -- { "<leader>gd", ":Gvdiffsplit<cr>", { desc = "[G]it [d]iff" }},
      -- TODO: add bindings for hunk operations (from gitsigns.nvim)
    },
  },
}