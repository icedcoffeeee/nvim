return {
	{
		"mhartington/formatter.nvim",
		init = function()
			local filetype = {
				lua = { require("formatter.filetypes.lua").stylua },
				python = { require("formatter.filetypes.python").black },
				cpp = { require("formatter.filetypes.cpp").clangformat },
			}

			local prettier_files =
				{ "html", "css", "json", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" }
			for _, ft in ipairs(prettier_files) do
				filetype[ft] = { require("formatter.filetypes.html").prettier }
			end

			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				filetype = filetype,
			})

			local map = function(keymap, command, desc)
				vim.keymap.set("n", keymap, command, { desc, silent = true })
			end
			map("<leader>f", ":Format<CR>", "[F]ormat buffer")
			map("<leader>F", ":FormatWrite<CR>", "[F]ormat and [W]rite buffer")
			local augroup = vim.api.nvim_create_augroup
			local autocmd = vim.api.nvim_create_autocmd
			augroup("FormatAutoGroup", { clear = true })
			autocmd("BufWritePost", {
				group = "FormatAutoGroup",
				command = ":FormatWrite",
			})
		end,
	},
}
