local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
	vim.notify("colorizer doesn't exist", vim.log.levels.INFO)
	return
end

colorizer.setup({
	filetypes = { "*" },
	user_default_options = {
		names = false,
		RGB = true, -- #RGB hex codes
		RRGGBB = true, -- #RRGGBB hex codes
		RRGGBBAA = false, -- #RRGGBBAA hex codes
		AARRGGBB = false, -- 0xAARRGGBB hex codes
		rgb_fn = false, -- CSS rgb() and rgba() functions
		hsl_fn = false, -- CSS hsl() and hsla() functions
		css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
		css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
		-- Available modes for `mode`: foreground, background,  virtualtext
		mode = "virtualtext", -- Set the display mode. "foreground" "background" "virtualtext"
		virtualtext = "■",
		-- Available methods are false / true / "normal" / "lsp" / "both"
		-- True is same as normal
		tailwind = false, -- Enable tailwind colors
		-- parsers can contain values used in |user_default_options|
		sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
		-- update color values even if buffer is not focused
		-- example use: cmp_menu, cmp_docs
		always_update = false
	},
	-- all the sub-options of filetypes apply to buftypes
	buftypes = {},
})
