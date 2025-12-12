return {
	{
		"mason-org/mason.nvim",
		dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
		config = function()
			require("mason").setup()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- web
					"astro-language-server",
					"biome",
					"emmet-language-server",
					"typescript-language-server",

					"clangd",
					"lua-language-server",
					"pyright",
					"rust-analyzer",
					"svelte-language-server",
					"tailwindcss-language-server",
					"tinymist",
				},
			})
		end,
	},
}
