local opts = { noremap = true, silent = true}
local term_opts = { silent = true }

-- Shorten function name
-- local keymap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Insert --
-- Delete a word in insert mode
keymap("i", "<C-w>", "<Esc>caw", opts)



-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

--keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Resize with Alt hjkl

local function resize(side, amount)
	local success, position = pcall(vim.api.nvim_win_get_position, 0)
	if not success then
		return
	end

	if side == "down" or side == "up" then
		if position[1] == 1 then
			print("top")
			if side == "up" then
				vim.cmd("resize -2")
			elseif side == "down" then
				vim.cmd("resize +2")
			end
		else
			print(position[1])
			if side == "up" then
				vim.cmd("resize +2")
			elseif side == "down" then
				vim.cmd("resize -2")
			end
		end
	else
		if position[2] == 0 then
			print("left")
			if side == "left" then
				vim.cmd("vertical resize -2")
			elseif side == "right" then
				vim.cmd("vertical resize +2")
			end
		else
			print(position[2])
			if side == "left" then
				vim.cmd("vertical resize +2")
			elseif side == "right" then
				vim.cmd("vertical resize -2")
			end
		end
	end
end

keymap("n", "<A-j>", function () resize("down", 2) end, opts)
keymap("n", "<A-k>", function () resize("up", 2) end, opts)
keymap("n", "<A-h>", function () resize("left", 2) end, opts)
keymap("n", "<A-l>", function () resize("right", 2) end, opts)


-- keymap("n", "<A-k>", ":resize +2<CR>", opts)
-- keymap("n", "<A-j>", ":resize -2<CR>", opts)
-- keymap("n", "<A-h>", ":vertical resize +2<CR>", opts)
-- keymap("n", "<A-l>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear search highlighting
keymap("n", "<leader>h", ":nohlsearch<CR>")

-- Insert --
-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
