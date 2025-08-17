local function toggle_diffview(cmd)
  if next(require("diffview.lib").views) == nil then
    vim.cmd(cmd)
  else
    vim.cmd("DiffviewClose")
  end
end

return {
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    -- cond = is_git_root,
    -- lazy = false,
    opts = {
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        }
      },
      keymaps = {
        file_history_panel = {
          { "n", "gd", "y:DiffviewOpen <C-R>*<cr>", { desc = "Open a Workspace DiffView from HEAD to the commit under the cursor", remap = true }},
        },
      },
    },
    keys = {
      {
        "<leader>gd",
        function()
          toggle_diffview("DiffviewOpen")
        end,
        desc = "[G]it [D]iff against index",
      },
      {
        "<leader>gD",
        function()
          toggle_diffview("DiffviewOpen -- %")
        end,
        desc = "[G]it [D]iff this file against index",
      },
      {
        "<leader>gh",
        function()
          toggle_diffview("DiffviewFileHistory")
        end,
        desc = "[G]it [H]istory for workdir",
      },
      {
        "<leader>gH",
        function()
          toggle_diffview("DiffviewFileHistory --no-merges %")
        end,
        desc = "[G]it [H]istory for current file (without merge commits)",
      },
    },
  }
}