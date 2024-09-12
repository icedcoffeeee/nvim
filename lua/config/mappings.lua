local map = function(kmap, cmd, desc)
	vim.keymap.set("n", kmap, cmd, { desc = desc, silent = true })
end

-- Diagnostic keymaps
map("<leader>e", vim.diagnostic.open_float, "Show diagnostic [E]rror messages")
map("<leader>q", vim.diagnostic.setloclist, "Open diagnostic [Q]uickfix list")

-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })
-- movement maps
map("<leader>j", ":BufferLineCyclePrev<cr>", "Previous buffer")
map("<leader>k", ":BufferLineCycleNext<cr>", "Next buffer")
map("<leader>q", ":bn|bd#<cr>", "Delete buffer")

local term = "powershell"
if vim.loop.os_uname().sysname == "Linux" then
	term = "bash"
end
map("<leader>l", ":vs term://" .. term .. "<cr>a", "Open vertical terminal")

--  Use CTRL+<hjkl> to switch between windows
map("<C-h>", "<C-w><C-h>", "Move focus to the left window")
map("<C-l>", "<C-w><C-l>", "Move focus to the right window")
map("<C-j>", "<C-w><C-j>", "Move focus to the lower window")
map("<C-k>", "<C-w><C-k>", "Move focus to the upper window")

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
