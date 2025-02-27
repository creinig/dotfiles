return {
  {
    'renerocksai/telekasten.nvim',
    dependencies = {'nvim-telescope/telescope.nvim'},
    opts = {
      home = vim.fn.expand("~/wiki/zettelkasten"), -- Put the name of your notes directory here
      template_new_note = vim.fn.expand("~/wiki/zettelkasten/_new_note.template"),
      template_new_daily = vim.fn.expand("~/wiki/zettelkasten/_new_daily.template"),
    },
    init = function()
      -- Most used functions
      vim.keymap.set("n", "<leader>ww", "<cmd>Telekasten panel<CR>", { desc = "Toolbox" })
      vim.keymap.set("n", "<leader>wf", "<cmd>Telekasten find_notes<CR>", { desc = "[F]ind notes by name"})
      vim.keymap.set("n", "<leader>wg", "<cmd>Telekasten search_notes<CR>", { desc = "[G]rep in all notes"})
      vim.keymap.set("n", "<leader>wt", "<cmd>Telekasten show_tags<CR>", { desc = "Look up by [T]ag"})
      vim.keymap.set("n", "<leader>wT", "<cmd>Telekasten toggle_todo<CR>", { desc = "Toggle [T]odo checkbox"})
      vim.keymap.set("n", "<leader>wj", "<cmd>Telekasten goto_today<CR>", { desc = "Open [J]ournal for today"})
      vim.keymap.set("n", "<leader>wo", "<cmd>Telekasten follow_link<CR>", { desc = "[O]pen link"})
      vim.keymap.set("n", "<leader>wn", "<cmd>Telekasten new_note<CR>", { desc = "[N]ew note"})
      -- vim.keymap.set("n", "<leader>wc", "<cmd>Telekasten show_calendar<CR>")
      vim.keymap.set("n", "<leader>wb", "<cmd>Telekasten show_backlinks<CR>", { desc = "Show [B]acklinks"})
      -- vim.keymap.set("n", "<leader>wI", "<cmd>Telekasten insert_img_link<CR>")

      -- Call insert link automatically when we start typing a link
      vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")
    end
  },
}
