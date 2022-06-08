local cmp = require("cmp")
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil

end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local kind_icons = {
  Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",

	Class = "€",
	Interface = "",
	Module = "✪",
	Property = "",
	Unit = " ",
	Value = "",
	Enum = "",
	Keyword = "ﱃ",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "Ꮢ",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
  VimCmdLine = "",
}

local source_menu = {
  buffer = "[﬘ Buf]",
  nvim_lsp = "[ LSP]",
  --luasnip = "[ LSnip]",
  vsnip = "[ Sni]",
  --snippet = "[ VSnip]",
  path = "[~ Pat]",
  nvim_lua = "[ NvimLua]",
  dictionary = "[韛Dict]",
}

cmp.setup({

  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  formatting = {
    fields = {'abbr', 'kind', 'menu'},
    format = function(entry, item)
      -- return special icon for cmdline completion
      if entry.source.name == "cmdline" then
        item.kind = string.format("%s %s", kind_icons["VimCmdLine"], "Vim")
        return item
      end
      --item.kind = string.format("%s %s", kind_icons[item.kind], item.kind)
      item.kind = kind_icons[item.kind]..''
      item.menu = (source_menu)[entry.source.name]
      return item
    end,

  },
  window = {
    documentation = {
      border = {'╭', '─', '╮', '│', '╯', '─', '╰', '│'},
    },
    completion = {
      border = {'┌', '─', '┐', '│', '┘', '─', '└', '│'},
      winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
    }
  },
  mapping = {
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {
      "i",
      "c",
    }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {
      "i",
      "c",
    }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"]() == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp", priority = 99 },
    { name = "vsnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "dictionary", keyword_length = 2 },
  },
  experimental = {
    ghost_text = true,
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {

  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    {

      name = "buffer",
    },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
