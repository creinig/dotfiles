return {
  {
    'stevearc/aerial.nvim',
    opts = {
      nav = {
        preview = true,
      },
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    init = function()
      vim.keymap.set("n", "<leader>co", "<cmd>AerialNavToggle<cr>", { desc = "Toggle Quick [O]utline" })
      vim.keymap.set("n", "<leader>cO", "<cmd>AerialToggle<cr>", { desc = "Toggle [O]utline" })
    end
  }
}
