return {
	{
		"mhartington/formatter.nvim",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"latexindent",
					"biome",
					"prettier",
				},
			})

			local filetype = {
				lua = require("formatter.filetypes.lua").stylua,

				c = require("formatter.filetypes.cpp").clangformat,
				cpp = require("formatter.filetypes.cpp").clangformat,
				glsl = require("formatter.filetypes.cpp").clangformat,

				python = require("formatter.filetypes.python").ruff,
				rust = require("formatter.filetypes.rust").rustfmt,
				tex = require("formatter.filetypes.tex").latexindent,
				nix = require("formatter.filetypes.nix").nixfmt,

				typst = function() return { exe = "typstyle", args = { "-i" } } end,
			}

			local prettier = {
				"css",
				"javascript",
				"json",
				"typescript",
				"typescriptreact",
				"astro",
				"html",
				"svelte",
			}
			for _, lang in ipairs(prettier) do
				filetype[lang] = require("formatter.defaults.prettierd")
			end

			require("formatter").setup({ filetype = filetype })

			vim.keymap.set("n", "<leader>f", ":Format<CR>", { silent = true })
			vim.keymap.set("n", "<leader>F", ":FormatWrite<CR>", { silent = true })
		end,
	},
}
