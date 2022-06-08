local trouble = require("trouble")
trouble.setup({
  position = "bottom",
  height = 7,
  width = 50,
  icons = true,
  mode = "document_diagnostics",
  fold_open = "",
  fold_closed = "",
  group = true,
  padding = true,
  indent_lines = true,
  auto_open = false,
  auto_close = true,
  auto_preview = true,
  auto_fold = false,
  auto_jump = { "lsp_definitions" },
  action_keys = {
    cspell_good = "f",
    cspell_all_good = "sg",
  },
  signs = {
    error = "",
    warning = "",
    hint = "",
    information = "",
    other = "﫠",
  },
  use_diagnostic_signs = true,
})

trouble.cspell_good = function()
  local line = vim.fn.getline(".")
  local word = string.match(line, "Unknown word %((.+)%) cspell")
  if word ~= nil or word ~= "" then
    vim.cmd("spellgood " .. word:lower())
  end
end

trouble.cspell_all_good = function()
  local words = {}
  for _, item in pairs(trouble.get_items()) do
    if item.source == "cspell" then
      local word = string.match(item.text, "Unknown word %((.+)%)")
      if word ~= nil or word ~= "" then
        words[word:lower()] = true
      end
    end
  end

  if vim.tbl_isempty(words) then

    return
  end

  local count = 0
  for word, _ in pairs(words) do
    vim.cmd("silent! spellgood " .. word)
    count = count + 1

  end

  local spell_file = vim.opt.spellfile:get()[1]
  print(string.format("%s word(s) added to the %s.", count, spell_file))
end

