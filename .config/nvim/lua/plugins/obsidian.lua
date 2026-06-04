return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  cmd = { 'Obsidian' },
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

    -- completion = {
    --   blink = true,
    -- },

    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    legacy_commands = false,

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
      enable = false,
    },
  },
  keys = {
    { "<leader>wf", "<cmd>Obsidian quick_switch<CR>", desc = "[F]ind notes by name"},
    { "<leader>fw", "<cmd>Obsidian quick_switch<CR>", desc = "[F]ind wiki page by name"},
    { "<leader>wl", "<cmd>Obsidian link<CR>", mode = 'x', desc = "Turn selection into [L]ink"},
    { "<leader>wg", "<cmd>Obsidian search<CR>", desc = "[G]rep in all notes"},
    { "<leader>wj", "<cmd>Obsidian today<CR>", desc = "Open [J]ournal for today"},
    { "<leader>wn", "<cmd>Obsidian new<CR>", desc = "[N]ew note"},
    { "<leader>wb", "<cmd>Obsidian backlinks<CR>", desc = "Show [B]acklinks"},
    { "<leader>wt", "<cmd>Obsidian toc<CR>", desc = "Show [T]OC"},
    { "<leader>wT", "<cmd>Obsidian tags<CR>", desc = "Show [T]ags"},
    { "<leader>wx", "<cmd>Obsidian extract_note<CR>", mode = 'x', desc = "E[x]tract selection to new note"},
  },
}
