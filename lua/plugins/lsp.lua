local vim = vim
local map = vim.keymap.set
local buf = vim.lsp.buf

return {
	{ "williamboman/mason.nvim", config = true },
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"prettier",
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				typescript = { "prettier" },
				svelte = { "prettier" },
				python = { "isort", "black" },
			},
		},
		config = function(_, opts)
			local conform = require("conform")
			conform.setup(opts)
			map("n", "<leader>f", conform.format)
		end,
	},
	{ "neovim/nvim-lspconfig" },
	{
		"VonHeikemen/lsp-zero.nvim",
		config = function()
			local lsp_zero = require("lsp-zero")

			lsp_zero.extend_lspconfig()
			lsp_zero.on_attach(function(_, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
				map("n", "<leader>rn", buf.rename, { buffer = bufnr })
				map("n", "<leader>ca", buf.code_action, { buffer = bufnr })
			end)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function()
			local lsp_zero = require("lsp-zero")
			return {
				ensure_installed = {
					"lua_ls",
					"tsserver",
					"tailwindcss",
					"svelte",
					"eslint",
				},
				handlers = {
					lsp_zero.default_setup,
				},
			}
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{
		"hrsh7th/nvim-cmp",
		opts = function()
			local cmp = require("cmp")
			return {
				mapping = cmp.mapping.preset.insert({
					-- `Enter` key to confirm completion
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					-- Ctrl+Space to trigger completion menu
					["<C-Space>"] = cmp.mapping.complete(),
					-- Custom
					["<Tab>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_next_item({ behavior = "insert" })
						else
							cmp.complete()
						end
					end),
					["<S-Tab>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item({ behavior = "insert" })
						else
							cmp.complete()
						end
					end),
				}),
			}
		end,
	},
	{ "L3MON4D3/LuaSnip" },
}
