return {
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 100,
		opts = {},
	},
	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
				separator_style = "slant",
				sort_by = "insert_after_current",
			},
		},
	},
}
