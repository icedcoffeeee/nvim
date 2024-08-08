return {
	"smoka7/hop.nvim",
	version = "*",
	opts = {
		keys = "etovxqpdygfblzhckisuran",
	},
	config = function(opts)
		-- place this in one of your configuration file(s)
		local hop = require("hop")
		hop.setup(opts)

		local dirs = require("hop.hint").HintDirection
		local map = function(kmap, dir, offset)
			vim.keymap.set("n", kmap, function()
				hop.hint_char1({ direction = dir, hint_offset = offset or 0 })
			end, { remap = true })
		end
		map("<M-f>", dirs.AFTER_CURSOR)
		map("<M-F>", dirs.BEFORE_CURSOR)
		map("<M-t>", dirs.AFTER_CURSOR, -1)
		map("<M-T>", dirs.BEFORE_CURSOR, -1)
	end,
}
