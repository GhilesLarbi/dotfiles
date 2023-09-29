require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "javascript", "html", "css", "bash" },
	sync_install = false,
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
})
