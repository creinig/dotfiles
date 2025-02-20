return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },

  {
    "junegunn/vim-easy-align",
    config = function()
      vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", {desc = "EasyAlign"} )
      vim.keymap.set("v", "ga", "<Plug>(EasyAlign)", {desc = "EasyAlign"} )
      vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", {desc = "EasyAlign"} )
    end
  },
}
