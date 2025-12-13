# icedcoffeeee/nvim

This config was ported from nixvim (nix fixes that one issue you have btw :P)
to be used on every other distro.

## usage

1. Run: `git clone https://github.com/icedcoffeeee/nvim ~/.config/nvim`
1. Run: `nvim`
    - The first time, it *will* error  --- ignore it. Press escape. The plugins
      will install. Wait for all to finish.
1. Close neovim `:q`.
1. Run: `nvim`
    - The second time, the colorschemes should've kicked in. Now, the syntax
      highlighting, LSPs and formatters will start installing. Wait for all to
      finish.
    - You can open `:Mason` to look at the progress.

## my plugin set
- navarasu/onedark.nvim
- tpope/vim-surround
- nvim-tree/nvim-web-devicons
- nvim-mini/mini.nvim
- hrsh7th/nvim-cmp
- L3MON4D3/LuaSnip
- windwp/nvim-ts-autotag
- nvim-treesitter/nvim-treesitter
- xiyaowong/transparent.nvim
- windwp/nvim-autopairs
- lukas-reineke/indent-blankline.nvim
- lewis6991/gitsigns.nvim
- folke/flash.nvim
- j-hui/fidget.nvim
- akinsho/bufferline.nvim
- jake-stewart/multicursor.nvim
- mhartington/formatter.nvim
- hrsh7th/cmp-nvim-lsp
- nvim-telescope/telescope.nvim
- nvim-lua/plenary.nvim
- nvim-telescope/telescope-ui-select.nvim
- nvim-telescope/telescope-fzf-native.nvim
- mason-org/mason.nvim
- WhoIsSethDaniel/mason-tool-installer.nvim

## FAQ
1. Why not Lazy.nvim?
    - Didn't need it.
