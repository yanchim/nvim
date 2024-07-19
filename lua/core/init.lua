-- [nfnl] Compiled from fnl/core/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
do
  local options = {expandtab = true, tabstop = 2, softtabstop = 2, shiftwidth = 2, formatoptions = "jcroqlnt", completeopt = "menuone,noselect", ignorecase = true, smartcase = true, clipboard = "unnamedplus", signcolumn = "number", number = false}
  for option, value in pairs(options) do
    core.assoc(vim.o, option, value)
  end
end
os.setlocale("C")
vim.g.netrw_liststyle = 3
require("core.keymaps")
if (vim.uv.os_uname().sysname == "Windows_NT") then
  vim.o.shell = "pwsh"
else
end
if vim.fn.has("gui_running") then
  require("core.gui")
else
end
return {}
