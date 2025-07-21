return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- Optional image support for file preview: See `# Preview Mode` for more information.
    -- {"3rd/image.nvim", opts = {}},
    -- OR use snacks.nvim's image module:
    -- "folke/snacks.nvim",
  },
  lazy = false, -- neo-tree will lazily load itself
  ---@module "neo-tree"
  ---@type neotree.Config?
  keys = {
    { "<leader>vF", "<cmd>Neotree<cr>", desc = "[V]iew [F]ile navigator sidebar" },
  },
  opts = {
    filesystem = {
      use_libuv_file_watcher=true,
      follow_current_file = {
        enabled=true,
      },
      hijack_netrw_behavior = "disabled",
    },
  },
}