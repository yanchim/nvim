-- [nfnl] Compiled from fnl/plugins/paredit.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local paredit = require("nvim-paredit")
  local function _2_()
    return paredit.cursor.place_cursor(paredit.wrap.wrap_element_under_cursor("( ", ")"), {placement = "inner_start", mode = "insert"})
  end
  local function _3_()
    return paredit.cursor.place_cursor(paredit.wrap.wrap_element_under_cursor("(", ")"), {placement = "inner_end", mode = "insert"})
  end
  return paredit.setup({keys = {["<M-H>"] = {paredit.api.slurp_backwards, "Slurp backwards"}, ["<M-J>"] = {paredit.api.barf_backwards, "Barf backwards"}, ["<M-K>"] = {paredit.api.barf_forwards, "Barf forwards"}, ["<M-L>"] = {paredit.api.slurp_forwards, "Slurp forwards"}, ["<localleader>9"] = {_2_, "Wrap element insert head"}, ["<localleader>0"] = {_3_, "Wrap element insert tail"}}})
end
local function _4_()
  local paredit_fnl = require("nvim-paredit-fennel")
  return paredit_fnl.setup()
end
return {{"julienvincent/nvim-paredit", lazy = true, ft = {"clojure", "fennel", "lisp", "scheme"}, config = _1_}, {"julienvincent/nvim-paredit-fennel", dependencies = {"julienvincent/nvim-paredit"}, lazy = true, ft = {"fennel"}, config = _4_}}
