-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Found in https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/
-- Completion Plugin Setup
local cmp = require("cmp")
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },
  -- Installed sources:
  sources = {
    { name = "path" }, -- file paths
    { name = "nvim_lsp", keyword_length = 3 }, -- from language server
    { name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
    { name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
    { name = "buffer", keyword_length = 2 }, -- source current buffer
    { name = "vsnip", keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
    { name = "calc" }, -- source for math calculation
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { "menu", "abbr", "kind" },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = "λ",
        vsnip = "⋗",
        buffer = "Ω",
        path = "🖫",
      }
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      function(entry1, entry2)
        local kind1 = entry1:get_kind()
        local kind2 = entry2:get_kind()
        if kind1 ~= kind2 then
          if kind1 == cmp.lsp.CompletionItemKind.Field then
            return true
          elseif kind2 == cmp.lsp.CompletionItemKind.Field then
            return false
          elseif kind1 == cmp.lsp.CompletionItemKind.Method and kind2 ~= cmp.lsp.CompletionItemKind.Method then
            return true
          elseif kind2 == cmp.lsp.CompletionItemKind.Method and kind1 ~= cmp.lsp.CompletionItemKind.Method then
            return false
          elseif kind1 == cmp.lsp.CompletionItemKind.Function and kind2 ~= cmp.lsp.CompletionItemKind.Function then
            return true
          elseif kind2 == cmp.lsp.CompletionItemKind.Function and kind1 ~= cmp.lsp.CompletionItemKind.Function then
            return false
          end
        end
      end,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})
