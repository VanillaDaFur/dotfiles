return {
	{
		"stevearc/conform.nvim",
		-- One small keybind to format code
		keys = {
			{ "<C-n>", "<cmd>Format<CR>", desc = "Format code" },
		},
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms = 5000,
					async = false,
					quiet = true,
				},
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
				formatters = {
					black = {
						prepend_args = { "--fast" },
					},
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
				desc = "Format code using Conform",
			})
		end,
	},
	-- Installs all formatters used by conform
	{
		"zapling/mason-conform.nvim",
		dependencies = {
			"stevearc/conform.nvim",
			"williamboman/mason.nvim",
		},
		config = true,
	},
}
