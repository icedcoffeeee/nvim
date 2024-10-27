return {
	{
		"mhartington/formatter.nvim",
		config = function()
			local filetype = {
				lua = require("formatter.filetypes.lua").stylua,

				cpp = require("formatter.filetypes.cpp").clangformat,
				glsl = require("formatter.filetypes.cpp").clangformat,

				python = require("formatter.filetypes.python").ruff,
				rust = require("formatter.filetypes.rust").rustfmt,
				tex = require("formatter.filetypes.tex").latexindent,
				gdscript = { exe = "gdformat" },
			}

			local biome = {
				"css",
				"javascript",
				"typescript",
				"typescriptreact",
				"json",
			}
			for _, lang in ipairs(biome) do
				filetype[lang] = require("formatter.defaults.biome")
			end
			local prettier = { "html", "svelte", "astro", unpack(biome) }
			for _, lang in ipairs(prettier) do
				filetype[lang] = require("formatter.defaults.prettier")
			end

			require("formatter").setup({ filetype = filetype })

			vim.keymap.set("n", "<leader>f", ":Format<CR>", { silent = true })
			vim.keymap.set("n", "<leader>F", ":FormatWrite<CR>", { silent = true })
		end,
	},
}
