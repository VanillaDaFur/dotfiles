return {
	{
		"stevearc/conform.nvim",
		-- One small keybind to format code
		keys = {
			{ "<C-n>", "<cmd>Format<CR>", desc = "Format code" },
		},
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
			-- Adds :Format command, that... formats code, wow.
			vim.api.nvim_create_user_command("Format", function()
				require("conform").format({
					bufnr = vim.api.nvim_get_current_buf(),
					lsp_fallback = true,
					timeout_ms = 5000,
				})
			end, {
				desc = "Format current buffer using Conform",
			})
			-- Auto format on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					require("conform").format({
						bufnr = args.buf,
						lsp_fallback = true,
						timeout_ms = 5000,
					})
				end,
			})
		end,
	},
	{
		"zapling/mason-conform.nvim",
		config = true,
	},
}
