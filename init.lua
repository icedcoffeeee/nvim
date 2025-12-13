local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

if not (vim.uv or vim.loop).fs_stat(pckr_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/lewis6991/pckr.nvim",
		pckr_path,
	})
end

vim.opt.rtp:prepend(pckr_path)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
do
	local nixvim_globals =
		{ have_nerd_font = true, loaded_netrw = 1, loaded_netrwPlugin = 1, mapleader = " ", maplocalleader = " " }

	for k, v in pairs(nixvim_globals) do
		vim.g[k] = v
	end
end

-- Setup lazy.nvim
require("pckr").add({
	"navarasu/onedark.nvim",
	"tpope/vim-surround",
	"nvim-tree/nvim-web-devicons",
	"nvim-mini/mini.nvim",
	"hrsh7th/nvim-cmp",
	"L3MON4D3/LuaSnip",
	"windwp/nvim-ts-autotag",
	"nvim-treesitter/nvim-treesitter",
	"xiyaowong/transparent.nvim",
	"windwp/nvim-autopairs",
	"lukas-reineke/indent-blankline.nvim",
	"lewis6991/gitsigns.nvim",
	"folke/flash.nvim",
	"j-hui/fidget.nvim",
	"akinsho/bufferline.nvim",
	"jake-stewart/multicursor.nvim",
	"mhartington/formatter.nvim",
	"hrsh7th/cmp-nvim-lsp",

	{
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make clean && make",
			},
		},
	},

	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- LSPs
					"astro-language-server",
					"biome",
					"clangd",
					"emmet-language-server",
					"lua-language-server",
					"pyright",
					"rust-analyzer",
					"svelte-language-server",
					"tailwindcss-language-server",
					"texlab",
					"tinymist",
					"typescript-language-server",

					-- formatter
					"clang-format",
					"latexindent",
					"prettier",
					"ruff",
					"rustfmt",
					"shfmt",
					"stylua",
					"stylua",
					"typstyle",
				},

				-- if set to true this will check each tool for updates. If updates
				-- are available the tool will be updated. This setting does not
				-- affect :MasonToolsUpdate or :MasonToolsInstall.
				-- Default: false
				auto_update = false,

				-- automatically install / update on startup. If set to false nothing
				-- will happen on startup. You can use :MasonToolsInstall or
				-- :MasonToolsUpdate to install tools and check for updates.
				-- Default: true
				run_on_start = true,

				-- set a delay (in ms) before the installation starts. This is only
				-- effective if run_on_start is set to true.
				-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
				-- Default: 0
				start_delay = 3000, -- 3 second delay

				-- Only attempt to install if "debounce_hours" number of hours has
				-- elapsed since the last time Neovim was started. This stores a
				-- timestamp in a file named stdpath("data")/mason-tool-installer-debounce.
				-- This is only relevant when you are using "run_on_start". It has no
				-- effect when running manually via ":MasonToolsInstall" etc....
				-- Default: nil
				debounce_hours = 5, -- at least 5 hours between attempts to install/update

				-- By default all integrations are enabled. If you turn on an integration
				-- and you have the required module(s) installed this means you can use
				-- alternative names, supplied by the modules, for the thing that you want
				-- to install. If you turn off the integration (by setting it to false) you
				-- cannot use these alternative names. It also suppresses loading of those
				-- module(s) (assuming any are installed) which is sometimes wanted when
				-- doing lazy loading.
				integrations = {
					["mason-lspconfig"] = true,
					["mason-null-ls"] = true,
					["mason-nvim-dap"] = true,
				},
			})
		end,
	},
})

require("config")
