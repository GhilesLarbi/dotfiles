-- ############################################# --
-- ###                 mason                  ## --
-- ############################################# --
local MASON_SETTINGS = {
	max_concurrent_installers = 4,
	ui = {
    	check_outdated_packages_on_open = true,
    	border = "rounded",
		width = 0.8,
		height = 0.9,
		icons = {
			package_installed = "󰈸",
			package_pending = "󰔚",
			package_uninstalled = ""
		},

		keymaps = {
			-- Keymap to expand a package
			toggle_package_expand = "<CR>",
			-- Keymap to install the package under the current cursor position
			install_package = "i",
			-- Keymap to reinstall/update the package under the current cursor position
			update_package = "u",
			-- Keymap to check for new version for the package under the current cursor position
			check_package_version = "c",
			-- Keymap to update all installed packages
			update_all_packages = "U",
			-- Keymap to check which installed packages are outdated
			check_outdated_packages = "C",
			-- Keymap to uninstall a package
			uninstall_package = "X",
			-- Keymap to cancel a package installation
			cancel_installation = "<C-c>",
			-- Keymap to apply language filter
			apply_language_filter = "<C-f>",
			-- Keymap to toggle viewing package installation log
			toggle_package_install_log = "<CR>",
			-- Keymap to toggle the help view
			toggle_help = "g?",
		},
	},
}

require("mason").setup(MASON_SETTINGS)

-- ############################################# --
-- ###             mason-lspconfig            ## --
-- ############################################# --
require("mason-lspconfig").setup({
	ensure_installed = {"bashls", "lua_ls"},
})


-- ############################################# --
-- ###               lspconfig                ## --
-- ############################################# --
-- helper functions
local on_attach = function(_, _)
	-- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
	-- vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- configure lspconfig servers
local lspconfig = require("lspconfig")

lspconfig.bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})


lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,

	-- Server-specific settings. See `:help lspconfig-setup`
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand "$VIMRUNTIME/lua"] = true,
					[vim.fn.stdpath	 "config" .. "/lua"] = true,
				},
			},
		},
	},
})



-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set('n', '<leader>t', vim.diagnostic.open_float)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
