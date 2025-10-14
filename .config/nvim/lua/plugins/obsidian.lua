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
      template = "templates/daily",
    },

    completion = {
      blink = true,
    },

    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
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

    checkbox = {
      order = { " ", "x", ">", "~", "!" },
    },

    ui = {
      checkboxes = {
        -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "✔", hl_group = "ObsidianDone" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "✗", hl_group = "ObsidianTilde" },
        ["!"] = { char = "", hl_group = "ObsidianImportant" },
        -- Replace the above with this if you don't have a patched font:
        -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
        -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },
        -- You can also add more custom ones...
      },
      hl_groups = {
        -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
        ObsidianTodo = { bold = true, fg = "#f78c6c" },
        ObsidianDone = { bold = true, fg = "#55ff55" },
        ObsidianRightArrow = { bold = true, fg = "#89ddff" },
        ObsidianTilde = { bold = true, fg = "#ff5370" },
        ObsidianImportant = { bold = true, fg = "#ffcc00" },
        ObsidianBullet = { bold = true, fg = "#89ddff" },
        ObsidianRefText = { underline = true, fg = "#c792ea" },
        ObsidianExtLinkIcon = { fg = "#c792ea" },
        ObsidianTag = { italic = true, fg = "#89ddff" },
        ObsidianBlockID = { italic = true, fg = "#89ddff" },
        ObsidianHighlightText = { bg = "#75662e" },
      },
    },
  },

  init = function()
    -- Most used functions
    vim.keymap.set("n", "<leader>wf", "<cmd>Obsidian quick_switch<CR>", { desc = "[F]ind notes by name"})
    vim.keymap.set("n", "<leader>fw", "<cmd>Obsidian quick_switch<CR>", { desc = "[F]ind wiki page by name"})
    vim.keymap.set("x", "<leader>wl", "<cmd>Obsidian link<CR>", { desc = "Turn selection into [L]ink"})
    vim.keymap.set("n", "<leader>wg", "<cmd>Obsidian search<CR>", { desc = "[G]rep in all notes"})
    vim.keymap.set("n", "<leader>wj", "<cmd>Obsidian today<CR>", { desc = "Open [J]ournal for today"})
    vim.keymap.set("n", "<leader>wn", "<cmd>Obsidian tew", { desc = "[N]ew note"})
    vim.keymap.set("n", "<leader>wb", "<cmd>Obsidian backlinks<CR>", { desc = "Show [B]acklinks"})
    vim.keymap.set("n", "<leader>wt", "<cmd>Obsidian toc<CR>", { desc = "Show [T]OC"})
    vim.keymap.set("n", "<leader>wT", "<cmd>Obsidian tags<CR>", { desc = "Show [T]ags"})
    vim.keymap.set("x", "<leader>wx", "<cmd>Obsidian extract_note<CR>", { desc = "E[x]tract selection to new note"})
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