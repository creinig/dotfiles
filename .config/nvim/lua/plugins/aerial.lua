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
    keys = {
      { "<leader>co", "<cmd>AerialNavToggle<cr>", desc = "Toggle Quick [O]utline" },
      { "<leader>cO", "<cmd>AerialToggle<cr>", desc = "Toggle [O]utline" },
    }
  }
}