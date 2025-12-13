local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

if not (vim.uv or vim.loop).fs_stat(pckr_path) then
	vim.fn.system({
		'git',
		'clone',
		"--filter=blob:none",
		'https://github.com/lewis6991/pckr.nvim',
		pckr_path
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
	"https://github.com/navarasu/onedark.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/windwp/nvim-ts-autotag",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/xiyaowong/transparent.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/folke/flash.nvim",
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/jake-stewart/multicursor.nvim",
	"https://github.com/mhartington/formatter.nvim",
	"https://github.com/hrsh7th/cmp-nvim-lsp",

  {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "https://github.com/nvim-telescope/telescope-ui-select.nvim",
      {
        "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
        run = "make clean && make",
      },
    }
  },

  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
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
