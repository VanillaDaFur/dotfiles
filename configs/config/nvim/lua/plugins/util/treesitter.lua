return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"lua",
			"bash",
			"fish",
			"markdown",
			"markdown_inline",
			"python",
			"json",
			"toml",
			"css",
			"cpp",
			"c",
			"c_sharp",
		},
		highlight = {
			additional_vim_regex_highlighting = true,
			enable = true,
		},
		parser_install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site"),
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
