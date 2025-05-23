return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  cmd = { 'ObsidianToday', 'ObsidianQuickSwitch' },
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        -- Default vault, may depend on the machine I am on
        name = "default",
        path = "~/wiki/obsidian",
      },
    },

    daily_notes = {
      folder = "journal",
      default_tags = { "journal" },
    },

    completion = {
      blink = true,
    },

    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      }
    },

    -- customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs identical to the title (which should be unique anyway)
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        return title:gsub("[^A-Za-z0-9_-]", "_")
      else
        -- If title is nil, just use the current timestamp plus 4 random uppercase letters.
        local suffix = ""
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
        return tostring(os.time()) .. "-" .. suffix
      end
    end,
  },

  init = function()
    -- Most used functions
    vim.keymap.set("n", "<leader>wf", "<cmd>ObsidianQuickSwitch<CR>", { desc = "[F]ind notes by name"})
    vim.keymap.set("n", "<leader>fw", "<cmd>ObsidianQuickSwitch<CR>", { desc = "[F]ind wiki page by name"})
    vim.keymap.set("x", "<leader>wl", "<cmd>ObsidianLink<CR>", { desc = "Turn selection into [L]ink"})
    vim.keymap.set("n", "<leader>wg", "<cmd>ObsidianSearch<CR>", { desc = "[G]rep in all notes"})
    vim.keymap.set("n", "<leader>wj", "<cmd>ObsidianToday<CR>", { desc = "Open [J]ournal for today"})
    vim.keymap.set("n", "<leader>wn", "<cmd>ObsidianNew", { desc = "[N]ew note"})
    vim.keymap.set("n", "<leader>wb", "<cmd>ObsidianBacklinks<CR>", { desc = "Show [B]acklinks"})
    vim.keymap.set("n", "<leader>wt", "<cmd>ObsidianTOC<CR>", { desc = "Show [T]OC"})
    vim.keymap.set("n", "<leader>wT", "<cmd>ObsidianTags<CR>", { desc = "Show [T]ags"})
    vim.keymap.set("x", "<leader>wx", "<cmd>ObsidianExtractNote<CR>", { desc = "E[x]tract selection to new note"})
    vim.keymap.set({"n", "x"}, "<leader>wA", [[:s/\v^(- \[.\] )(\(.\) )?/\1(A) /<cr>]], { desc = "Set Priority A" })
    vim.keymap.set({"n", "x"}, "<leader>wB", [[:s/\v^(- \[.\] )(\(.\) )?/\1(B) /<cr>]], { desc = "Set Priority B" })
    vim.keymap.set({"n", "x"}, "<leader>wC", [[:s/\v^(- \[.\] )(\(.\) )?/\1(C) /<cr>]], { desc = "Set Priority C" })
    vim.keymap.set({"n", "x"}, "<leader>wD", [[:s/\v^(- \[.\] )(\(.\) )?/\1/<cr>]], { desc = "Clear Priority" })

    vim.api.nvim_create_autocmd(
      { "BufRead", "BufNewFile" },
      {
        group = vim.api.nvim_create_augroup("ObsidianTodo", {}),
        pattern = "Todo.md",
        callback = function(ev)
          local groupNameTodoA = "TodoItemA"
          vim.fn.matchadd(groupNameTodoA, [[- \[ \] (A).*]]) 
          vim.api.nvim_set_hl(0, groupNameTodoA, { bg = "#441010" })

          local groupNameTodoB = "TodoItemB"
          vim.fn.matchadd(groupNameTodoB, [[- \[ \] (B).*]]) 
          vim.api.nvim_set_hl(0, groupNameTodoB, { bg = "#333310" })

        end
      }
    )
  end
}