local ms = require('dyninput.lang.misc')
require('dyninput').setup({
  c = {
    ['-'] = { '->', ms.is_pointer },
  },
  cpp = {
    [','] = { ' <!>', ms.generic_in_cpp },
    ['-'] = { '->', ms.is_pointer },
  },
  lua = {
    [';'] = { ':', ms.semicolon_in_lua },
  },
  go = {
    [';'] = {
      { ' := ', ms.go_variable_define },
      { ':', ms.go_struct_field },
    },
  },
})
