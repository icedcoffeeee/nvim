local hologram = {}
if vim.loop.os_uname().sysname == "Linux" then
	hologram = { "edluffy/hologram.nvim", opts = {} }
end

return {
	{ "windwp/nvim-ts-autotag", opts = {} },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	"tpope/vim-surround",
	hologram,
}
