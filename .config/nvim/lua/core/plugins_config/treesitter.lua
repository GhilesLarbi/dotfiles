local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	vim.notify("nvim-treesitter doesn't exist", vim.log.levels.INFO)
	return
end

treesitter.setup({
	ensure_installed = { "lua", "javascript", "html", "css", "bash" },
	sync_install = false,
	auto_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})
