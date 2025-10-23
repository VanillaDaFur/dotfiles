return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "<C-f>", "<cmd>Telescope find_files<CR>", desc = "Toggle filesearch" },
    },
    config = function()
      local builtin = require('telescope.builtin')
    end,
  },
}
