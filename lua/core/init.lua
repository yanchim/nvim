-- [nfnl] Compiled from fnl/core/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
do
  local options = {expandtab = true, tabstop = 2, softtabstop = 2, shiftwidth = 2, completeopt = "menuone,noselect", ignorecase = true, smartcase = true, clipboard = "unnamedplus", ruler = true, signcolumn = "number", number = false}
  for option, value in pairs(options) do
    core.assoc(vim.o, option, value)
  end
end
vim.cmd("let g:netrw_liststyle = 3")
require("core.keymaps")
require("core.gui")
return {}
