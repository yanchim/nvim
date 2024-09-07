-- [nfnl] Compiled from fnl/plugins/cmp.fnl by https://github.com/Olical/nfnl, do not edit.
local cmp_src_menu_items = {buffer = "buff", conjure = "conj", orgmode = "org", nvim_lsp = "lsp", snippets = "snp"}
local cmp_srcs = {{name = "buffer"}, {name = "conjure"}, {name = "nvim_lsp"}, {name = "orgmode"}, {name = "path"}, {name = "snippets"}}
local function has_words_before()
  local _let_1_ = vim.api.nvim_win_get_cursor(0)
  local line = _let_1_[1]
  local col = _let_1_[2]
  local and_2_ = (col ~= 0)
  if and_2_ then
    local _let_4_ = vim.api.nvim_buf_get_lines(0, (line - 1), line, true)
    local current_line = _let_4_[1]
    local word_before = current_line:sub(col, col)
    and_2_ = (word_before:match("%s") == nil)
  end
  return and_2_
end
local function snippet_next(fallback)
  local cmp = require("cmp")
  if cmp.visible() then
    return cmp.select_next_item()
  elseif vim.snippet.active({direction = 1}) then
    local function _5_()
      return vim.snippet.jump(1)
    end
    return vim.schedule(_5_)
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
    local function _7_()
      return vim.snippet.jump(-1)
    end
    return vim.schedule(_7_)
  else
    return fallback()
  end
end
local function _9_()
  local cmp = require("cmp")
  local function _10_(entry, item)
    item.menu = (cmp_src_menu_items[entry.source.name] or "")
    return item
  end
  return cmp.setup({formatting = {format = _10_}, mapping = {["<C-P>"] = cmp.mapping.select_prev_item(), ["<C-N>"] = cmp.mapping.select_next_item(), ["<C-B>"] = cmp.mapping.scroll_docs(( - 4)), ["<C-F>"] = cmp.mapping.scroll_docs(4), ["<M-p>"] = cmp.mapping.scroll_docs(( - 4)), ["<M-n>"] = cmp.mapping.scroll_docs(4), ["<C-Space>"] = cmp.mapping.complete(), ["<C-E>"] = cmp.mapping.close(), ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = true}), ["<Tab>"] = cmp.mapping(snippet_next, {"i", "s"}), ["<S-Tab>"] = cmp.mapping(snippet_prev, {"i", "s"})}, sources = cmp_srcs})
end
return {{"hrsh7th/nvim-cmp", event = "InsertEnter", dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "PaterJason/cmp-conjure"}, config = _9_}}
