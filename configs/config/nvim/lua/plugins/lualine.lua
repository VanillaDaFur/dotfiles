return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" }
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icon = { '', align = 'left', color = { fg = '#313244'} },
          },
        },
        lualine_b = {
          {
            "filename",
            icon = { '', align = 'left' },
          },
        },
        lualine_c = {
          {
            "branch",
            icon = { '', align = 'left' },
          },
          {
            "diff",
            colored = true,
            diff_color = {
              added    = { fg = '#a6e3a1' }, -- Changes the diff's added color
              modified = { fg = '#f9e2af' }, -- Changes the diff's modified color
              removed  = { fg = '#eba0ac' }, -- Changes the diff's removed color you
            },
            symbols = { added = ' ', modified = ' ', removed = ' ' },
          },
        },
        lualine_x = { "diagnostics" },
        lualine_y = { "filetype" },
        lualine_z = {
          {
            "progress",
            icon = { '', align='left', color={fg='#313244'} },
          },
          --{
          --  "location", icon = { '', align='left', color={fg='#313244'} },
          --},
        },
      },
    },
    config = function(_,opts)
      require("lualine").setup(opts)
    end,
  },
}
