-- [nfnl] fnl/core/init.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
do
  local options = {expandtab = true, tabstop = 8, softtabstop = 2, shiftwidth = 2, formatoptions = "jcroqlnt", completeopt = "menuone,noselect", ignorecase = true, smartcase = true, clipboard = "unnamedplus", fileformats = "unix,dos", number = true, relativenumber = true, signcolumn = "number"}
  for option, value in pairs(options) do
    core.assoc(vim.o, option, value)
  end
end
os.setlocale("C")
vim.g.netrw_liststyle = 3
require("core.keymaps")
if (vim.uv.os_uname().sysname == "Windows_NT") then
  vim.o.shell = (((vim.fn.executable("pwsh") == 1) and "pwsh") or ((vim.fn.executable("powershell") == 1) and "powershell") or vim.o.shell)
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
  vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "
  vim.o.shellpipe = "| Out-File -Encoding UTF8 %s"
  vim.o.shellredir = "| Out-File -Encoding UTF8 %s"
else
end
if vim.fn.has("gui_running") then
  require("core.gui")
else
end
return {}
