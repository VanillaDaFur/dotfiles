return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
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
        "nix",
        "rust",
        "toml",
        "css"
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
  },
}
