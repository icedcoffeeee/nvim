return {
	{
		"mhartington/formatter.nvim",
		dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
		init = function()
			local util = require("formatter.util")
			local filetype = {
				lua = { require("formatter.filetypes.lua").stylua },
				python = { require("formatter.filetypes.python").black },
				cpp = { require("formatter.filetypes.cpp").clangformat },
				rust = { require("formatter.filetypes.rust").rustfmt },
				dart = { require("formatter.filetypes.dart").dartformat },
				latex = { require("formatter.filetypes.latex").latexindent },
				gdscript = {
					function()
						return {
							exe = "gdformat",
							args = {
								util.escape_path(util.get_current_buffer_file_path()),
								"--use-spaces=2",
							},
						}
					end,
				},
			}

			local prettier_files = {
				"html",
				"css",
				"json",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"svelte",
				"astro",
			}
			for _, ft in ipairs(prettier_files) do
				filetype[ft] = { require("formatter.defaults.prettier") }
			end

			require("mason-tool-installer").setup({
				ensure_installed = { "stylua", "black", "clang-format", "prettier", "gdtoolkit" },
			})

			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				filetype = filetype,
			})

			local map = function(keymap, command, desc)
				vim.keymap.set("n", keymap, command, { desc = desc, silent = true })
			end

			map("<leader>f", ":Format<CR>", "[F]ormat buffer")
			map("<leader>F", ":FormatWrite<CR>", "[F]ormat and [W]rite buffer")
		end,
	},
}
