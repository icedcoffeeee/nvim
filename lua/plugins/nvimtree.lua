return {
	-- nvimtree

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
		config = function(_, opts)
			local api = require("nvim-tree.api")
			vim.keymap.set("n", "<C-b>", function()
				api.tree.toggle({ find_file = true })
			end, {
				desc = "nvim-tree: toggle",
				noremap = true,
				silent = true,
				nowait = true,
			})

			require("nvim-tree").setup(opts)
		end,
	},
}
