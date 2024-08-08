return {
	{
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			require("mini.ai").setup({ n_lines = 500 })
			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			require("mini.surround").setup()
			-- Remember the last opened files
			local sessions = require("mini.sessions")
			sessions.setup()

			local get_folder = function()
				local path = vim.fn.split(vim.fn.getcwd(), "\\")
				return path[#path]
			end
			vim.keymap.set("n", "|", function()
				sessions.read(get_folder())
			end)
			vim.keymap.set("n", "<M-\\>", function()
				sessions.write(get_folder())
			end)

			local statusline = require("mini.statusline")
			statusline.setup({ use_icons = true })
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},
}
