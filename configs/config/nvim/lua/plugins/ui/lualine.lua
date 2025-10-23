local catppuccin = {
	green = "#a6e3a1",
	blue = "#89b4fa",
	red = "#f38ba8",
	sky = "#89dceb",
	pink = "#f5c2e7",
	peach = "#fab387",
	text = "#313244",
	bg0 = "#181825",
	bg1 = "none",
	inactive = "#45475a",
}

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },

				theme = {
					normal = {
						a = { bg = catppuccin.blue, fg = catppuccin.text, gui = "bold" },
						b = { bg = catppuccin.bg0, fg = catppuccin.blue },
						c = { bg = catppuccin.bg1, fg = catppuccin.blue },
					},
					insert = {
						a = { bg = catppuccin.sky, fg = catppuccin.text, gui = "bold" },
						b = { bg = catppuccin.bg0, fg = catppuccin.sky },
						c = { bg = catppuccin.bg1, fg = catppuccin.mauve },
					},
					visual = {
						a = { bg = catppuccin.pink, fg = catppuccin.text, gui = "bold" },
						b = { bg = catppuccin.bg0, fg = catppuccin.pink },
						c = { bg = catppuccin.bg1, fg = catppuccin.pink },
					},
					replace = {
						a = { bg = catppuccin.red, fg = catppuccin.text, gui = "bold" },
						b = { bg = catppuccin.bg0, fg = catppuccin.red },
						c = { bg = catppuccin.bg1, fg = catppuccin.red },
					},
					command = {
						a = { bg = catppuccin.peach, fg = catppuccin.text, gui = "bold" },
						b = { bg = catppuccin.bg0, fg = catppuccin.peach },
						c = { bg = catppuccin.bg1, fg = catppuccin.peach },
					},
					inactive = {
						a = { bg = catppuccin.inactive, fg = catppuccin.text, gui = "bold" },
						b = { bg = catppuccin.bg0, fg = catppuccin.inactive },
						c = { bg = catppuccin.bg1, fg = catppuccin.inactive },
					},
				},
			},
			sections = {
				lualine_a = {
					{
						"mode",
						icon = { "", align = "left" },
					},
				},
				lualine_b = {
					{
						"filename",
						icon = { "", align = "left" },
					},
				},
				lualine_c = {
					{
						"branch",
						icon = { "", align = "left" },
					},
					{
						"diff",
						colored = true,
						diff_color = {
							added = { fg = "#a6e3a1" }, -- Changes the diff's added color
							modified = { fg = "#f9e2af" }, -- Changes the diff's modified color
							removed = { fg = "#eba0ac" }, -- Changes the diff's removed color you
						},
						symbols = { added = " ", modified = " ", removed = " " },
					},
				},
				lualine_x = {
					{
						"diagnostics",
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
					},
				},
				lualine_y = { "filetype" },
				lualine_z = {
					{
						"progress",
						icon = { "", align = "left" },
					},
				},
			},
			-- duplicate of main sections
			inactive_sections = {
				lualine_a = {
					{
						"mode",
						icon = { "", align = "left" },
					},
				},
				lualine_b = {
					{
						"filename",
						icon = { "", align = "left" },
					},
				},
				lualine_c = {
					{
						"branch",
						icon = { "", align = "left" },
					},
					{
						"diff",
						colored = true,
						diff_color = {
							added = { fg = "#a6e3a1" },
							modified = { fg = "#f9e2af" },
							removed = { fg = "#eba0ac" },
						},
						symbols = { added = " ", modified = " ", removed = " " },
					},
				},
				lualine_x = {
					{
						"diagnostics",
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
					},
				},
				lualine_y = { "filetype" },
				lualine_z = {
					{
						"progress",
						icon = { "", align = "left" },
					},
				},
			},
		},
		config = function(_, opts)
			require("lualine").setup(opts)
		end,
	},
}
