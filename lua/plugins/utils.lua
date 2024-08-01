return {
	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },
	-- multi line
	"mg979/vim-visual-multi",
	-- Useful plugin to show you pending keybinds.
	{
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			local wk = require("which-key")
			wk.setup()
			-- Document existing key chains
			wk.add({
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>c_", hidden = true },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>d_", hidden = true },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>r_", hidden = true },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>s_", hidden = true },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>w_", hidden = true },
			})
		end,
	},
	"gosukiwi/vim-smartpairs",
	{ "windwp/nvim-ts-autotag", opts = {} },
	"tpope/vim-surround",
	{
		"smoka7/hop.nvim",
		version = "*",
		opts = {
			keys = "etovxqpdygfblzhckisuran",
		},
		config = function()
			-- place this in one of your configuration file(s)
			local hop = require("hop")
			hop.setup()
			local directions = require("hop.hint").HintDirection
			vim.keymap.set("", "<M-f>", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR })
			end, { remap = true })
			vim.keymap.set("", "<M-F>", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR })
			end, { remap = true })
			vim.keymap.set("", "<M-t>", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, hint_offset = -1 })
			end, { remap = true })
			vim.keymap.set("", "<M-T>", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, hint_offset = 1 })
			end, { remap = true })
		end,
	},
}
