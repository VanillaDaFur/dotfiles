return {
	{
		"williamboman/mason.nvim",
		version = "^1.0.0",
		build = ":MasonUpdate",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		version = "^1.0.0",
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- It basically installs lsp servers + enables them
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- LSP servers
					"taplo",
					"jsonls",
					"tailwindcss",
					"bashls",
					"pylsp",
					"lua_ls",
					"clangd",
				},
				handlers = {
					function(server)
						vim.lsp.config[server] = {}
						vim.lsp.enable(server)
					end,
				},
			})

			-- It's almost all default, but i decided to enable virtual text here
			vim.diagnostic.config({
				virtual_text = {
					source = "if_many",
					prefix = "",
					spacing = 2,
				},
				signs = true,
				underline = true,
				update_in_insert = false,
			})
		end,
	},
}
