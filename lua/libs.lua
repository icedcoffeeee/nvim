require("packer").startup(function(use)
	use "wbthomason/packer.nvim"

	-- use "andweeb/presence.nvim"
	use { "catppuccin/nvim", as = "catppuccin" }
	use "folke/tokyonight.nvim"
	use "navarasu/onedark.nvim"
	use "glepnir/dashboard-nvim"
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/nvim-cmp"
	use "kyazdani42/nvim-web-devicons"
	use "L3MON4D3/LuaSnip"
	use "lewis6991/gitsigns.nvim"
	use "neovim/nvim-lspconfig"
	use "nvim-lua/plenary.nvim"
	use "nvim-lualine/lualine.nvim"
	use "nvim-telescope/telescope.nvim"
	use "nvim-telescope/telescope-file-browser.nvim"
	use "nvim-treesitter/nvim-treesitter"
	use { "nvimdev/guard.nvim", requires = {
		"nvimdev/guard-collection",
	} }
	use "onsails/lspkind-nvim"
	use "romainl/vim-cool"
	use "ryanoasis/vim-devicons"
	use "saadparwaiz1/cmp_luasnip"
	use "simrat39/rust-tools.nvim"
	use "tpope/vim-commentary"
	use "williamboman/mason.nvim"
	use "williamboman/mason-lspconfig.nvim"
	use "windwp/nvim-autopairs"
	use "ErichDonGubler/lsp_lines.nvim"

	use "mg979/vim-visual-multi"
	use "Yggdroot/indentLine"
	use "mattn/emmet-vim"
	use "lervag/vimtex"
	use "Konfekt/FastFold"
	use "tikhomirov/vim-glsl"
	use "preservim/vim-markdown"
end)
