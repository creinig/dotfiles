return {
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      restriction_mode = "hint",
      disable_mouse = false,
      disabled_keys = {
        ["<Up>"] = {},
        ["<Down>"] = {},
        ["<Left>"] = {},
        ["<Right>"] = {},
      },
    }
  },
}
