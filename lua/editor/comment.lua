local ok, m = pcall(require, "Comment")
if not ok then
  return
end

m.setup({
  toggler = {
      line = "gcc",
      block = "gcb",
  },
  opleader = {
      line = "gc",

      block = "gb",
  },
  extra = {
      above = "gck",
      below = "gcj",
      eol = "gca",
  },
})
