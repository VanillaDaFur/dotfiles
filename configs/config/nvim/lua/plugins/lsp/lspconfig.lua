return {
	{
		"williamboman/mason.nvim",
		version = "^1.0.0",
		build = ":MasonUpdate",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		version = "^1.0.0",
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
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
		end,
	},
}
