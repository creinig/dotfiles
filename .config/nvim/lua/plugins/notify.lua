return {
  {
    "rcarriga/nvim-notify",
    -- in termux the popups hide too much content
    cond = not string.find(vim.fn.stdpath("config"), "termux"),
    opts = {
      timeout = 10000,
      stages = "static",
    }
  }
}