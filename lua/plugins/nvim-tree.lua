-- [nfnl] Compiled from fnl/plugins/nvim-tree.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  return nil
end
local function _2_()
  local nvimtree = require("nvim-tree")
  vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", {desc = "Toggle file explorer"})
  vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", {desc = "Toggle file explorer on current buffer"})
  vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", {desc = "Collapse file explorer"})
  vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", {desc = "Toggle file explorer on current buffer"})
  return nvimtree.setup()
end
return {{"nvim-tree/nvim-tree.lua", dependencies = {"nvim-tree/nvim-web-devicons"}, init = _1_, config = _2_, lazy = false}}
