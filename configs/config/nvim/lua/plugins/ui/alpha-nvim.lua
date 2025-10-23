return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		enabled = true,
		init = false,
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
        ███╗   ██╗███████╗ ██████╗ ███╗   ███╗███████╗ ██████╗ ██╗    ██╗    
        ████╗  ██║██╔════╝██╔═══██╗████╗ ████║██╔════╝██╔═══██╗██║    ██║    
        ██╔██╗ ██║█████╗  ██║   ██║██╔████╔██║█████╗  ██║   ██║██║ █╗ ██║    
        ██║╚██╗██║██╔══╝  ██║   ██║██║╚██╔╝██║██╔══╝  ██║   ██║██║███╗██║      |\  /,|   (`\
        ██║ ╚████║███████╗╚██████╔╝██║ ╚═╝ ██║███████╗╚██████╔╝╚███╔███╔╝     .|o o  |    ) )
        ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝ ╚═════╝  ╚══╝╚══╝   -(((---(((--------  
      ]]

			dashboard.section.header.val = vim.split(logo, "\n")

			dashboard.section.buttons.val = {
				dashboard.button("e", "󰈔  > New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "  > Find file", ":cd $HOME | Telescope find_files<CR>"),
				dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
				dashboard.button(
					"s",
					"  > Settings",
					":lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })<CR>"
				),
				dashboard.button("q", "󰍃  > Quit", ":qa<CR>"),
			}
			alpha.setup(dashboard.opts)
		end,
	},
}
