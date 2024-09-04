local port = os.getenv("GDScript_Port") or "6005"
local cmd = { "ncat", "127.0.0.1", port }

vim.lsp.start({
	name = "Godot",
	cmd = cmd,
	root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
})

vim.opt.expandtab = false
