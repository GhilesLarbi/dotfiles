pcall( require, "core.plugins")
pcall( require, "core.colorscheme")
pcall( require, "core.options")
pcall( require, "core.keymaps")
pcall( require, "core.plugins_config")

local function detect_touching_sides(buf)
	buf = buf or 0
	local HIGHT_OFFSET = 3

	local global_height = vim.api.nvim_list_uis()[1]['height']
	local global_width = vim.api.nvim_list_uis()[1]['width']

	local window_height = vim.api.nvim_win_get_height(buf)
	local window_width = vim.api.nvim_win_get_width(buf)

	local window_start_pos = vim.api.nvim_win_get_position(buf)

	local touching_side = {
		top = false,
		bottom = false,
		left = false,
		right = false
	}

	if window_start_pos[1] == 1 then touching_side.top = true end
	if window_start_pos[2] == 0 then touching_side.left = true end

	if window_start_pos[1] + window_height > global_height - HIGHT_OFFSET then
		touching_side.bottom = true
	end

	if window_start_pos[2] + window_width >= global_width then
		touching_side.right = true
	end


	print(
		"golobal : ", global_height, " ", global_width,
		" | win size : ", window_height, " ", window_width,
		" | win pos : ", window_start_pos[1], " ", window_start_pos[2]
	)

	print(
		"top : ", touching_side.top,
		" | bottom : ", touching_side.bottom,
		" | left : ", touching_side.left,
		" | right : ", touching_side.right
	)

	return touching_side
end


vim.keymap.set("n", "<leader>f", function ()
	detect_touching_sides()
end)
