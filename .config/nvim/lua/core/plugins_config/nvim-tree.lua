local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
	vim.notify("nvim-tree doesn't exist", vim.log.levels.INFO)
	return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup {}

vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>", {silent = true})
