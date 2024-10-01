return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v1.x",
	dependencies = {
		-- LSP Support
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		{ "folke/neodev.nvim", opts = {} },

		-- Autocompletin
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",

		-- Snippets
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local lsp = require("lsp-zero")
		lsp.preset("recommended")
		lsp.ensure_installed({
			"clangd",
			"lua_ls",
			"tsserver",
			"svelte",
			"tailwindcss",
			"emmet_language_server",
			"astro",
			"pyright",
			"rust_analyzer",
			"texlab",
		})
		lsp.configure("lua_ls", { settings = { Lua = { diagnostic = { disable = { "missing-fields" } } } } })
		lsp.configure("tailwindcss", {
			settings = {
				tailwindCSS = { classAttributes = { "class", "className", "class:list", ".*ClassName.*", "tw" } },
			},
		})
		lsp.configure("pyright", { settings = { python = { analysis = { typeCheckingMode = { "off" } } } } })
		lsp.configure(
			"texlab",
			{ settings = { texlab = { build = { args = { "-lualatex", "-pvc", "-synctex=1", "%f" } } } } }
		)

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local cmp_mappings = lsp.defaults.cmp_mappings({
			["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
			["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<C-K>"] = cmp.mapping.complete(),
		})

		lsp.setup_nvim_cmp({ mapping = cmp_mappings })
		lsp.set_preferences({
			suggest_lsp_servers = false,
			sign_icons = {
				error = "E",
				warn = "W",
				hint = "H",
				info = "I",
			},
		})

		lsp.on_attach(function(_, bufnr)
			local opts = { buffer = bufnr, remap = false }

			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<S-L>", ":LspRestart<CR>", opts)
		end)

		lsp.setup()

		vim.diagnostic.config({
			virtual_text = true,
		})

		-- LuaSnip
		local ls = require("luasnip")
		vim.keymap.set({ "i", "s" }, "<C-L>", function()
			ls.jump(1)
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<C-J>", function()
			ls.jump(-1)
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<C-E>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true })
	end,
}
