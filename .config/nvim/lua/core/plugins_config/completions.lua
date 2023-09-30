local cmp_status_ok, cmp = pcall(require, "cmp")

if not cmp_status_ok then
	vim.notify("cmp doesn't exist")
	return
end

local luasnip_status_ok, luasnip = pcall(require, "luasnip")

if not luasnip_status_ok then
	vim.notify("luasnip doesn't exist")
	return
end

-- vscode like snipets
-- require("luasnip.loaders.from_vscode").lazy_load()

-- helper function
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local kind_icons = {
  Text = "",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰇽",
  Variable = "󰂡",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰅲",
}


cmp.setup({

	-- When to unable completion
	enabled = function()
		-- disable completion in comments
		local context = require('cmp.config.context')
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == 'c' then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,

	-- Completion sources
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
		{ name = 'buffer' },
	}),

	-- Keybinding when a completion menu opens
	mapping = cmp.mapping.preset.insert({
		['<C-j>'] = cmp.mapping.select_next_item({count = 1}),
		['<C-k>'] = cmp.mapping.select_prev_item({count = 1}),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-a>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),

		-- SUPER TAB
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
				-- they way you will only jump inside the snippet region
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		-- SUPER SHIFT TAB
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

	}),

	-- specify snippet engine (luasnip)
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	-- How the complition menu looks
	window = {
		completion = cmp.config.window.bordered(),
		-- completion = {
		-- 	-- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
		-- 	col_offset = -3,
		-- 	side_padding = 0,
		-- },
		documentation = cmp.config.window.bordered(),
    },

	-- how the complition text look inside the menu
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			-- Source
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
			})[entry.source.name]
			return vim_item
		end
	},

	-- Core complition menu options
	view = {
		-- entries = {name = 'wildmenu', separator = ' | ' }
		-- entries = "custom", -- can be "custom", "wildmenu" or "native"
		entries = {name = 'custom', selection_order = 'near_cursor' },
		docs = {auto_open = true},
	},


	-- select the first item automatically
	completion = { completeopt = 'menu,menuone,noinsert' },

	experimental = {
		ghost_text = true,
	},
})



-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
-- 	sources = cmp.config.sources({
-- 		{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
-- 	}, {
-- 		{ name = 'buffer' },
-- 	})
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {{ name = 'buffer' }},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
-- 	mapping = cmp.mapping.preset.cmdline(),
-- 	sources = cmp.config.sources(
-- 		{{ name = 'path' }},
-- 		{{ name = 'cmdline' }}
-- 	),
-- 
-- 	view = {
-- 		entries = "custom",
-- 	},
-- })
