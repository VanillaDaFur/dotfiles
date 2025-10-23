return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				-- Lua
				lua = { "stylua" },
				-- Python
				python = { "isort", "black" },
				-- C++, C
				cpp = { "clang-format" },
				c = { "clang-format" },
				javascript = { "clang-format" },
			},
		})
		-- Auto format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({
					bufnr = args.buf,
					lsp_fallback = true,
				})
			end,
		})
	end,
}
