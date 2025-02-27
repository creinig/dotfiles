return {
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    init = function()
      vim.keymap.set("n", "<leader>co", "<cmd>AerialToggle<cr>", { desc = "Toggle [O]utline" })
    end
  }
}
