local map = vim.keymap.set
local opts = {
	silent = true,
}

map("n", "<leader>j", ":bp<cr>", opts) -- buffer movement
map("n", "<leader>k", ":bn<cr>", opts)
map("n", "<leader>q", ":bd<cr>", opts) -- close buffer

map("n", "<leader>l", ":vs term://powershell<cr>", opts) -- open vertical terminal
map("n", "<leader><cr>", ":vert sb #<cr>", opts) -- open vertical prev buffer
map("t", "<C-[>", "<C-\\><C-n>", opts) -- exit terminal with escape

-- autoclosing
map("i", "(", "()<left>", opts)
map("i", "[", "[]<left>", opts)
map("i", "{", "{}<left>", opts)
map("i", "'", "''<left>", opts)
map("i", '"', '""<left>', opts)