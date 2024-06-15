local map = vim.keymap.set
-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message", silent = true })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message", silent = true })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages", silent = true })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list", silent = true })
map("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature [H]elp", silent = true })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })
-- movement maps
map("n", "<leader>j", ":bp<cr>", { desc = "Previous buffer", silent = true })
map("n", "<leader>k", ":bn<cr>", { desc = "Next buffer", silent = true })
map("n", "<leader>q", ":bn|bd#<cr>", { desc = "Delete buffer", silent = true })
map("n", "<leader>l", ":vs term://powershell<cr>a", { desc = "Open vertical terminal", silent = true })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window", silent = true })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window", silent = true })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window", silent = true })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window", silent = true })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
