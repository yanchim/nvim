-- Appearance
vim.o.cursorline = false
vim.o.relativenumber = true
-- NOTE: Having `tab` present is needed because `^I` will be shown if
-- omitted (documented in `:h listchars`), here we hide the tab char.
vim.o.listchars = 'tab:  ,extends:>,precedes:<,nbsp:.'

-- Editing
vim.o.expandtab = true
vim.o.tabstop = 8
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.clipboard = 'unnamedplus'

os.setlocale('C')

if vim.uv.os_uname().sysname == 'Windows_NT' then
   vim.o.shell = vim.fn.executable('pwsh') == 1 and 'pwsh'
      or vim.fn.executable('powershell') == 1 and 'powershell'
      or vim.o.shell

   vim.o.shellcmdflag = table.concat({
      '-NoLogo',
      '-NonInteractive',
      '-ExecutionPolicy RemoteSigned',
      '-Command',
      [=[ [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();]=],
      [=[$PSDefaultParameterValues['Out-File:Encoding']='utf8';]=],
      [=[$PSStyle.OutputRendering='plaintext';]=],
      [=[Remove-Alias -Force -ErrorAction SilentlyContinue tee;]=],
   }, ' ')

   vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
   vim.o.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'

   vim.o.shellquote = ''
   vim.o.shellxquote = ''
end
