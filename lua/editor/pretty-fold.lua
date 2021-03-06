local ok, fold = pcall(require, "pretty-fold")
if not ok then
  vim.notify "Could not load pretty-fold"
  return
end

local ok, preview = pcall(require, "pretty-fold.preview")
if not ok then
  vim.notify "Could not load pretty-fold.preview"
  return
end

fold.setup {
  sections = {
    left = {
      -- "content",
      '━ ', function() return string.rep('*', vim.v.foldlevel) end, ' ━┫', 'content', '┣'
    },
    right = {
      -- " ",
      -- "number_of_folded_lines",
      -- ": ",
      -- "percentage",
      -- " ",
      -- function(config)
      --   return config.fill_char:rep(3)
      -- end,
      '┫ ', 'number_of_folded_lines', ': ', 'percentage', ' ┣━━',
    },
  },
  fill_char = "━",

  remove_fold_markers = true,

  -- Keep the indentation of the content of the fold string.
  keep_indentation = true,

  -- Possible values:
  -- "delete" : Delete all comment signs from the fold string.
  -- "spaces" : Replace all comment signs with equal number of spaces.
  -- false    : Do nothing with comment signs.
  process_comment_signs = "spaces",

  -- Comment signs additional to the value of `&commentstring` option.
  comment_signs = {},

  -- List of patterns that will be removed from content foldtext section.
  stop_words = {
    "@brief%s*", -- (for C++) Remove '@brief' and all spaces after.
  },

  add_close_pattern = true, -- true, 'last_line' or false

  matchup_patterns = {
    { "{", "}" },
    { "%(", ")" }, -- % to escape lua pattern char
    { "%[", "]" }, -- % to escape lua pattern char
  },

  ft_ignore = { "neorg" },
}

fold.ft_setup("lua", {
  fill_char = " ",
  matchup_patterns = {
    { "^%s*do$", "end" }, -- do ... end blocks
    { "^%s*if", "end" }, -- if ... end
    { "^%s*for", "end" }, -- for
    { "function%s*%(", "end" }, -- 'function( or 'function (''
    { "{", "}" },
    { "%(", ")" }, -- % to escape lua pattern char
    { "%[", "]" }, -- % to escape lua pattern char
  },
})

preview.setup {
  default_keybindings = true, -- Set to false to disable default keybindings

  -- 'none', "single", "double", "rounded", "solid", 'shadow' or table
  -- For explanation see: :help nvim_open_win()
  border = "single",
}
