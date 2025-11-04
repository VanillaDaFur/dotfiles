return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",

		keys = {
			{ "<C-f>", "<cmd>Telescope find_files<CR>", desc = "Toggle filesearch" },
		},
		config = function()
			local builtin = require("telescope.builtin")

			require("telescope").setup({
				pickers = {
					find_files = { hidden = true },
					live_grep = {
						additional_args = function()
							return { "--hidden", "--glob", "!.git/*" }
						end,
					},
				},
				defaults = {
					border = true,
					borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				},
			})
		end,
	},
}
