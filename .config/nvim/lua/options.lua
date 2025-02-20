-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = "-"

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.opt`
--  For more options, you can see `:help option-list`

vim.opt.mouse = "a" -- Enable mouse mode, can be useful for resizing splits for example!

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Indendation & Format
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.breakindent = true
vim.opt.formatoptions = "crqlj"

-- Cursor & Wrapping
vim.opt.wrap = false -- a more sensible default for me
vim.opt.linebreak = true -- where wrapping is used, do it right
vim.opt.startofline = false -- Keep cursor in the same column when scrolling vertically (PgUp/PgDown etc)
vim.opt.encoding = "utf-8"

-- Searching
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.smartcase = true
vim.opt.wrapscan = true -- Searches wrap around end-of-file.
vim.opt.incsearch = true -- Highlight while searching with / or ?.
vim.opt.hlsearch = true -- Keep matches highlighted.

-- UI tuning
vim.opt.showcmd = true -- Useful e.g. for seeing that the leader is active
vim.opt.ttyfast = true -- Faster redrawing.
vim.opt.lazyredraw = true -- Only redraw when necessary.
vim.opt.number = true -- Make line numbers default
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.

-- Undo and swap files
vim.opt.undofile = true -- Save undo history
vim.opt.updatetime = 250 -- Decrease update time

-- Responsiveness
vim.opt.timeout = true -- for mappings
vim.opt.timeoutlen = 1000 -- default value
vim.opt.ttimeout = true -- for key codes
vim.opt.ttimeoutlen = 10 -- unnoticeable small value for escape sequences
vim.opt.synmaxcol = 400 -- Only highlight the first 400 columns.

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split" -- Preview substitutions live, as you type!

-- Command mode
vim.opt.report = 0 -- Always report changed lines.
vim.opt.completeopt = "menuone,preview,noinsert"
