local port = os.getenv("GDScript_Port") or "6005"
local net = "netcat"
if vim.loop.os_uname().sysname == "Linux" then
	net = "nc"
end
local cmd = { net, "127.0.0.1", port }

vim.lsp.start({
	name = "Godot",
	cmd = cmd,
	root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
})

vim.opt.expandtab = false
