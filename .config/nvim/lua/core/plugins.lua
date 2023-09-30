local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


local opts = {
	ui = {
    	-- a number <1 is a percentage., >1 is a fixed size
    	size = { width = 0.8, height = 0.8 },
    	wrap = true, -- wrap the lines in the ui
    	-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    	border = "rounded",
    	title = nil, ---@type string only works when border is not "none"
    	title_pos = "center", ---@type "center" | "left" | "right"
    	-- Show pills on top of the Lazy window
    	pills = true, ---@type boolean
    	icons = {
    	  cmd = " ",
    	  config = "",
    	  event = "",
    	  ft = " ",
    	  init = " ",
    	  import = " ",
    	  keys = " ",
    	  lazy = "󰒲 ",
    	  loaded = "●",
    	  not_loaded = "○",
    	  plugin = " ",
    	  runtime = " ",
    	  source = " ",
    	  start = "",
    	  task = "✔ ",
    	  list = {
    	    "●",
    	    "➜",
    	    "★",
    	    "‒",
    	  },
    	},
	},
}

local plugins = {

	-- UI --
	-- AYU colorscheme
	"Shatur/neovim-ayu",

	-- nvim tree file explorer
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- bottom status line
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
	},
	-- Barbar tabline
	{
		'romgrk/barbar.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
	},

	-- Highlight code Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- lazy = true,
		-- cond = false,
		-- enabled = false,
	},

	-- Highlight colors
	'NvChad/nvim-colorizer.lua',

	-- Dim portion of the code
	{
		"folke/twilight.nvim",
		opts = {
			dimming = {
				alpha = 0.25, -- amount of dimming
				-- we try to get the foreground from the highlight groups or fallback color
				color = { "Normal", "#ffffff" },
				term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
				inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
			},
			context = 15, -- amount of lines we will try to show around the current line
			treesitter = true, -- use treesitter when available for the filetype
			-- treesitter is used to automatically expand the visible text,
			-- but you can further control the types of nodes that should always be fully expanded
			expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
				"function",
				"method",
				"table",
				"if_statement",
			},
			exclude = {}, -- exclude these filetypes,
		},
	},


	-- ###################################### --
	-- LSP --
	{
		-- LSP servers package manager
    	"williamboman/mason.nvim",
		dependencies = {
			-- bridge between lspconfg and lsp servers
			"williamboman/mason-lspconfig.nvim",
			-- LSP cleint to handle LSP servers
    		"neovim/nvim-lspconfig",
		},
	},


	-- ###################################### --
	-- COMPLETIONS --
	{
		-- Completion engine
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Snippets plugin 
			"L3MON4D3/LuaSnip",
			-- luasnip completion source for nvim-cmp
			"saadparwaiz1/cmp_luasnip",
			-- LSP Completion integration
			"hrsh7th/cmp-nvim-lsp",
			-- Buffer complition
			"hrsh7th/cmp-buffer",
			-- Path complition
			"hrsh7th/cmp-path",
			-- vscode like snippets
			-- "rafamadriz/friendly-snippets",
		},
	},

}

require("lazy").setup(plugins, opts)
