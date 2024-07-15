return {
	{
		"mhartington/formatter.nvim",
		init = function()
			local filetype = {
				lua = { require("formatter.filetypes.lua").stylua },
				python = { require("formatter.filetypes.python").black },
			}

			local prettier_files =
				{ "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" }
			for _, ft in ipairs(prettier_files) do
				filetype[ft] = { require("formatter.filetypes.html").prettier }
			end

			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				filetype = filetype,
			})

			vim.keymap.set("n", "<leader>f", ":Format<CR>", { desc = "[F]ormat buffer", silent = true })
			local augroup = vim.api.nvim_create_augroup
			local autocmd = vim.api.nvim_create_autocmd
			augroup("FormatAutoGroup", { clear = true })
			autocmd("BufWritePost", {
				group = "FormatAutoGroup",
				command = ":Format",
			})
		end,
	},
}
