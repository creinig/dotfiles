-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = "-"

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
local kms = vim.keymap.set

--NOTE: Keymaps for specific plugins are defined in the respective
--      plugin spec

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
kms("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Insert path of current buffer in command mode by typing "%%". Adapted from 'Practical Vim' p101
kms("c", "%%", function()
	return vim.fn.getcmdtype() == ":" and (vim.fn.expand("%:h") .. "/") or "%%"
end, { expr = true })

-- Diagnostic keymaps
kms("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
kms("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
kms("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
kms("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
kms("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
kms("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })


-- [[ Utilities (<leader>u) ]]
-- remove all trailing whitespace in the file
kms("n", "<leader>uw", "mw:%s/\\s\\+$//<cr>`w", { desc = "Remove all trailing whitespace"})

kms("n", "<leader>ui", ":DiffChangesDiffToggle<cr>", { desc = "changes since last write" })
kms("n", "<leader>ud", ":lcd %:p:h<Cr>:pwd<Cr>", { desc = 'cd (local) to current file' })

-- pipe the current selection into xclip/pbcopy
if vim.fn.executable("pbcopy") then
  kms("v", "<leader>uy", '"yy <Bar> :call system("pbcopy", @y)<Cr>', { desc = "Copy to clipboard" })
  kms("v", "<leader>uc", '"yy <Bar> :call system("pbcopy", @y)<Cr>', { desc = "Copy to clipboard" })
else
  kms("v", "<leader>uy", '"yy <Bar> :call system("xclip -selection primary", @y)<Cr>', { desc = "Copy to primary" })
  kms("v", "<leader>uc", '"yy <Bar> :call system("xclip -selection clipboard", @y)<Cr>', { desc = "Copy to clipboard" })
end
