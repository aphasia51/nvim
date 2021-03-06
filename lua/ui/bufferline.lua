require("bufferline").setup({
  options = {
    offsets = { { filetype = "NvimTree", text = " Explorer", padding = 1 } },
    indicator_icon = "▎",
    buffer_close_icon = "",
    modified_icon = "",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 18,
    max_prefix_length = 18,
    tab_size = 18,
    show_tab_indicators = true,
    enforce_regular_tabs = true,
    show_buffer_close_icons = true,
    separator_style = "thick",
    always_show_bufferline = true,
  },
  highlights = {
    buffer_selected = {
        gui = "bold",
      },
		background = {
      gui = "italic",
		},
  }
})
