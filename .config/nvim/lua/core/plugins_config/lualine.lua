local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	vim.notify("lualine doesn't exist", vim.log.levels.INFO)
	return
end

local theme_status_ok, custom_theme = pcall(require, "lualine.themes.iceberg_dark")
if not theme_status_ok then
	vim.notify("lualine.theme doesn't exist", vim.log.levels.INFO)
	return
end

custom_theme.normal.c.bg = "#0a0e14"

lualine.setup({
	options = {
		icons_enabled = true,
		-- auto horizon iceberg_dark ayu_dark
		theme = custom_theme,

		section_separators = { left = '', right = ''},
		component_separators = { left = '⎮', right = '⎮'},

		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},

		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,

		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},

	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},

	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},

	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
})
