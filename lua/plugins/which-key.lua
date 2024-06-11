-- [nfnl] Compiled from fnl/plugins/which-key.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.o.timeout = true
  vim.o.timeoutlen = 500
  return nil
end
local function _2_()
  local wk = require("which-key")
  return wk.register({["<leader>e"] = {name = "Explore"}, ["<leader>f"] = {name = "Find"}, ["<leader>g"] = {name = "Git", h = {name = "Hunk"}}, ["<leader>s"] = {name = "Split"}, ["<leader>t"] = {name = "Tab"}})
end
return {{"folke/which-key.nvim", event = "VeryLazy", init = _1_, opts = {}, config = _2_}}
