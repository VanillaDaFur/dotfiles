return {
  { 
    'echasnovski/mini.pairs', 
    opts = {
      modes = {
        insert = true,
        command = true,
        terminal = false,
      },
      skip_next = "[%w%%%'%[\"%.%%$]",
      skip_ts = { "string" },
      skip_unbalanced = true,
      markdown = true,
    },
  },
}
