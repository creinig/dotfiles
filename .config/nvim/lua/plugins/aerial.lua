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
      { "<leader>vo", "<cmd>AerialNavToggle<cr>", desc = "[V]iew: Toggle Quick [O]utline" },
      { "<leader>vO", "<cmd>AerialToggle<cr>", desc = "[V]iew: Toggle [O]utline" },
    }
  }
}