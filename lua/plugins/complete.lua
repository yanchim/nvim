-- [nfnl] Compiled from fnl/plugins/complete.fnl by https://github.com/Olical/nfnl, do not edit.
local cmp_src_menu_items = {buffer = "buff", conjure = "conj", nvim_lsp = "lsp", snippets = "snp"}
local cmp_srcs = {{name = "nvim_lsp"}, {name = "conjure"}, {name = "buffer"}, {name = "path"}, {name = "snippets"}}
local function has_words_before()
  local _let_1_ = vim.api.nvim_win_get_cursor(0)
  local line = _let_1_[1]
  local col = _let_1_[2]
  local function _3_()
    local _let_2_ = vim.api.nvim_buf_get_lines(0, (line - 1), line, true)
    local current_line = _let_2_[1]
    local word_before = current_line:sub(col, col)
    return (word_before:match("%s") == nil)
  end
  return ((col ~= 0) and _3_())
end
local function snippet_next(fallback)
  local cmp = require("cmp")
  if cmp.visible() then
    return cmp.select_next_item()
  elseif vim.snippet.active({direction = 1}) then
    local function _4_()
      return vim.snippet.jump(1)
    end
    return vim.schedule(_4_)
  elseif has_words_before() then
    return cmp.complete()
  else
    return fallback()
  end
end
local function snippet_prev(fallback)
  local cmp = require("cmp")
  if cmp.visible() then
    return cmp.select_prev_item()
  elseif vim.snippet.active({direction = -1}) then
    local function _6_()
      return vim.snippet.jump(-1)
    end
    return vim.schedule(_6_)
  else
    return fallback()
  end
end
local function _8_()
  local cmp = require("cmp")
  local function _9_(entry, item)
    item.menu = (cmp_src_menu_items[entry.source.name] or "")
    return item
  end
  return cmp.setup({formatting = {format = _9_}, mapping = {["<C-p>"] = cmp.mapping.select_prev_item(), ["<C-n>"] = cmp.mapping.select_next_item(), ["<C-b>"] = cmp.mapping.scroll_docs(( - 4)), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<M-p>"] = cmp.mapping.scroll_docs(( - 4)), ["<M-n>"] = cmp.mapping.scroll_docs(4), ["<C-Space>"] = cmp.mapping.complete(), ["<C-e>"] = cmp.mapping.close(), ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = true}), ["<Tab>"] = cmp.mapping(snippet_next, {"i", "s"}), ["<S-Tab>"] = cmp.mapping(snippet_prev, {"i", "s"})}, sources = cmp_srcs})
end
return {{"hrsh7th/nvim-cmp", event = "InsertEnter", dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "PaterJason/cmp-conjure"}, config = _8_}}
