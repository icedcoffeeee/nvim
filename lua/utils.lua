local lang_maps = {
	arduino = {
		build = "arduino-cli compile --fqbn arduino:avr:uno %:r",
		exec = "arduino-cli upload -p /dev/ttyACM0 --fqbn arduino:avr:uno %:r",
	},
	c = { build = "gcc % -o %:r", exec = "%:r" },
	cpp = { build = "g++ % -o %:r", exec = "%:r" },
	go = { build = "go build", exec = "go run %" },
	java = { build = "javac %", exec = "java %:r" },
	javascript = { exec = "bun %" },
	python = { exec = "python %" },
	rust = { exec = "cargo run" },
	sh = { exec = "%" },
	typescript = { exec = "bun %" },
}

for lang, data in pairs(lang_maps) do
	if data.build ~= nil then
		vim.api.nvim_create_autocmd(
			"FileType",
			{ command = "nnoremap <Leader>b :!" .. data.build .. "<CR>", pattern = lang }
		)
	end

	vim.api.nvim_create_autocmd(
		"FileType",
		{ command = "nnoremap <Leader>e :split<CR>:terminal " .. data.exec .. "<CR>", pattern = lang }
	)
end

vim.api.nvim_create_autocmd("InsertEnter", { command = "set norelativenumber", pattern = "*" })
vim.api.nvim_create_autocmd("InsertLeave", { command = "set relativenumber", pattern = "*" })

vim.api.nvim_create_autocmd("TermOpen", { command = "startinsert", pattern = "*" })

vim.api.nvim_create_autocmd("BufWinEnter", { command = "set filetype=astro", pattern = "*.astro" })
vim.api.nvim_create_autocmd("BufWinEnter", { command = "set expandtab", pattern = "*.hs" })
vim.api.nvim_create_autocmd("BufWinEnter", { command = "set noexpandtab tabstop=2 shiftwidth=2", pattern = "*.rs" })
vim.api.nvim_create_autocmd("BufWinEnter", { command = ":IndentLinesEnable", pattern = "*" })

vim.api.nvim_create_autocmd("VimLeave", { command = "set guicursor=a:ver25-blinkon2", pattern = "*" })

local tex_cmd_id = vim.api.nvim_create_augroup("tex_configs", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	command = "setlocal spell foldmethod=expr foldexpr=vimtex#fold$level(v:lnum) foldtext=vimtex#fold#text()",
	pattern = "*.tex",
	group = tex_cmd_id,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	command = ":IndentLinesDisable",
	pattern = { "*.tex", "dashboard" },
	group = tex_cmd_id,
})

local json_cmd_id = vim.api.nvim_create_augroup("json_configs", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	command = ":IndentLinesDisable",
	pattern = { "*.json", "*.jsonc" },
	group = json_cmd_id,
})
vim.api.nvim_create_autocmd({ "BufLeave", "BufUnload", "BufDelete", "BufHidden" }, {
	command = ":IndentLinesEnable",
	pattern = { "*.json", "*.jsonc" },
	group = json_cmd_id,
})

vim.api.nvim_command "sign define DiagnosticSignError text=● texthl=DiagnosticSignError"
vim.api.nvim_command "sign define DiagnosticSignWarn text=● texthl=DiagnosticSignWarn"
vim.api.nvim_command "sign define DiagnosticSignInfo text=● texthl=DiagnosticSignInfo"
vim.api.nvim_command "sign define DiagnosticSignHint text=● texthl=DiagnosticSignHint"
