local capabilities = function()
	local cap = vim.lsp.protocol.make_client_capabilities()
	cap = vim.tbl_deep_extend("force", cap, require("cmp_nvim_lsp").default_capabilities())
	return cap
end

local setup = { capabilities = capabilities() }

local config = function(cfg)
	if cfg == nil then
		cfg = setup
	else
		cfg = vim.tbl_extend("keep", cfg, setup)
	end

	return cfg
end

vim.lsp.config("astro", config({}))
vim.lsp.enable("astro")
vim.lsp.config("biome", config({}))
vim.lsp.enable("biome")
vim.lsp.config("emmet_language_server", config({}))
vim.lsp.enable("emmet_language_server")
vim.lsp.config("rust_analyzer", config({}))
vim.lsp.enable("rust_analyzer")
vim.lsp.config("tinymist", config({}))
vim.lsp.enable("tinymist")

vim.lsp.config(
	"clangd",
	config({
		cmd = { "clangd", "--query-driver=c++" },
	})
)
vim.lsp.enable("clangd")

vim.lsp.config("lua_ls", config({ settings = { Lua = { Lua = { diagnostic = { disable = { "missing-fields" } } } } } }))
vim.lsp.enable("lua_ls")

vim.lsp.config("pyright", config({ settings = { python = { analysis = { typeCheckingMode = "off" } } } }))
vim.lsp.enable("pyright")

vim.lsp.config(
	"svelte",
	config({
		on_attach = function(client)
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = { "*.js", "*.ts" },
				callback = function(ctx) client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match }) end,
			})
		end,
	})
)
vim.lsp.enable("svelte")

vim.lsp.config(
	"tailwindcss",
	config({
		settings = {
			tailwindCSS = { classAttributes = { "class", "className", "class:list", ".*ClassName.*", "tw" } },
		},
	})
)
vim.lsp.enable("tailwindcss")

vim.lsp.config(
	"ts_ls",
	config({
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
	})
)
vim.lsp.enable("ts_ls")
