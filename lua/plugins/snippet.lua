-- [nfnl] Compiled from fnl/plugins/snippet.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local ls = require("luasnip")
  local lsv = require("luasnip.loaders.from_vscode")
  local function _2_()
    if ls.expand_or_jumpable() then
      return ls.expand_or_jump()
    else
      return nil
    end
  end
  vim.keymap.set("i", "<C-K>", _2_, {silent = true})
  local function _4_()
    return ls.jump(1)
  end
  vim.keymap.set({"i", "s"}, "<C-L>", _4_, {silent = true})
  local function _5_()
    return ls.jump(-1)
  end
  vim.keymap.set({"i", "s"}, "<C-J>", _5_, {silent = true})
  local function _6_()
    if ls.choice_active() then
      return ls.change_choice(1)
    else
      return nil
    end
  end
  vim.keymap.set({"i", "s"}, "<C-E>", _6_, {silent = true})
  return lsv.lazy_load({paths = {"./etc/luasnip"}})
end
return {{"L3MON4D3/LuaSnip", build = "make install_jsregexp", config = _1_}}
