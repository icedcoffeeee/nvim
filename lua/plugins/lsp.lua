return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v4.x",
	dependencies = {
		-- LSP Support
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		{ "folke/neodev.nvim", opts = {} },

		-- Autocompletion
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
		local lspconfig_defaults = require("lspconfig").util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			"force",
			lspconfig_defaults.capabilities,
			require("cmp_nvim_lsp").default_capabilities()
		)

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local opts = { buffer = event.buf }
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "<S-l>", ":LspRestart<CR>", opts)
			end,
		})

		local border = {
			{ "🭽", "FloatBorder" },
			{ "▔", "FloatBorder" },
			{ "🭾", "FloatBorder" },
			{ "▕", "FloatBorder" },
			{ "🭿", "FloatBorder" },
			{ "▁", "FloatBorder" },
			{ "🭼", "FloatBorder" },
			{ "▏", "FloatBorder" },
		}
		local lsp = require("lspconfig")
		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"clangd",
				"pyright",
				"rust_analyzer",
				"texlab",

				"ts_ls",
				"svelte",
				"tailwindcss",
				"astro",
				"emmet_language_server",
			},
			handlers = {
				function(server_name)
					lsp[server_name].setup({
						handlers = {
							["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
							["textDocument/signatureHelp"] = vim.lsp.with(
								vim.lsp.handlers.signature_help,
								{ border = border }
							),
						},
					})
				end,
			},

			lua_ls = function()
				lsp.lua_ls.setup({
					settings = { Lua = { diagnostic = { disable = { "missing-fields" } } } },
				})
			end,
			pyright = function()
				lsp.pyright.setup({
					settings = { python = { analysis = { typeCheckingMode = { "off" } } } },
				})
			end,
			tailwindcss = function()
				lsp.tailwindcss.setup({
					settings = {
						tailwindCSS = {
							classAttributes = { "class", "className", "class:list", ".*ClassName.*", "tw" },
						},
					},
				})
			end,
			texlab = function()
				lsp.texlab.setup({
					settings = { texlab = { build = { args = { "-lualatex", "-pvc", "-synctex=1", "%f" } } } },
				})
			end,
			ts_ls = function()
				lsp.ts_ls.setup({
					root_dir = lsp.util.root_pattern("package.json"),
					single_file_support = false,
				})
			end,
		})

		local cmp = require("cmp")
		local cmp_action = require("lsp-zero").cmp_action()
		local cmp_format = require("lsp-zero").cmp_format({ details = false })
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "luasnip" },
			},
			preselect = "item",
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			mapping = cmp.mapping.preset.insert({
				["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
				["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-k>"] = cmp.mapping.complete(),
				-- Scroll up and down the documentation window
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				-- Luasnip
				["<C-l>"] = cmp_action.luasnip_jump_forward(),
				["<C-j>"] = cmp_action.luasnip_jump_backward(),
			}),
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			--- Show source name in completion menu
			formatting = cmp_format,
			--- Borders
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		})

		vim.diagnostic.config({ virtual_text = true, float = { border = "single" } })
	end,
}
