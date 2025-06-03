return {
  {
    "tpope/vim-fugitive",
    config = function()
      -- See also diffview.lua for more mappings
      vim.keymap.set("n", "<leader>gg", ":Git<cr>", { desc = "[G]it status" })
      vim.keymap.set("n", "<leader>ga", ":Git add %", { desc = "[G]it [a]dd" })
      vim.keymap.set("n", "<leader>gc", ":Git commit -v -c HEAD --reset-author<cr>", { desc = "[G]it [commit] (prefill last msg)" })
      vim.keymap.set("n", "<leader>gC", ":Git commit --amend<cr>", { desc = "[G]it [c]ommit (amend)" })
      vim.keymap.set("n", "<leader>gp", ":Git push<space>", { desc = "[G]it [p]ush" })
      vim.keymap.set("n", "<leader>gf", ":Git fetch<space>", { desc = "[G]it [f]etch" })
      vim.keymap.set("n", "<leader>gl", ":Git pull<space>", { desc = "[G]it pul[l]" })
      vim.keymap.set("n", "<leader>gB", ":Gitsigns blame<cr>", { desc = "[G]it [b]lame" })
      vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<cr>", { desc = "[G]it [b]lame (line)" })
      -- vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit<cr>", { desc = "[G]it [d]iff" })
      vim.keymap.set("n", "<leader>gv", ":GV -n 1000<cr>", {desc = "Git [v]iew log" })
      vim.keymap.set("v", "<leader>gv", ":GV -n 1000<cr>", {desc = "Git [v]iew log" })
      vim.keymap.set("n", "<leader>gV", ":GV! -n 1000<cr>", {desc = "Git [v]iew log (this file)" })
      -- TODO: add bindings for hunk operations (from gitsigns.nvim)
    end
  },
}