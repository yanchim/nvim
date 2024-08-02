-- [nfnl] Compiled from fnl/core/keymaps.fnl by https://github.com/Olical/nfnl, do not edit.
vim.keymap.set("n", "<LocalLeader>cd", "<Cmd>tcd %:h<CR>", {desc = "Change cwd to current file"})
vim.keymap.set("n", "<LocalLeader>dd", "<Cmd>verbose pwd<CR>", {desc = "pwd"})
vim.keymap.set({"n", "v"}, "<LocalLeader>w", vim.cmd.write, {desc = "Write current file"})
local function _1_()
  return vim.cmd.quitall({bang = true})
end
vim.keymap.set({"n", "v"}, "<LocalLeader>Q", _1_, {desc = "Quit"})
local function readonly_toggle()
  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].readonly then
    vim.bo[buf]["readonly"] = false
    return nil
  else
    vim.bo[buf]["readonly"] = true
    return nil
  end
end
vim.keymap.set({"i", "n", "v"}, "<C-X><C-Q>", vim.cmd.quitall, {desc = "Quit"})
vim.keymap.set({"i", "n", "v"}, "<C-X><C-R>", readonly_toggle, {desc = "Toggle readonly"})
vim.keymap.set({"i", "n", "v"}, "<C-X><C-S>", vim.cmd.update, {desc = "Save buffer"})
vim.keymap.set("t", "jk", "<C-\\><C-N>", {desc = "Exit terminal INSERT mode"})
vim.keymap.set("n", "<LocalLeader>xl", vim.cmd.lopen, {desc = "Location list"})
vim.keymap.set("n", "<LocalLeader>xq", vim.cmd.copen, {desc = "Quickfix list"})
vim.keymap.set("n", "<LocalLeader>xx", vim.cmd.cc, {desc = "Display error"})
vim.keymap.set("n", "<LocalLeader>xg", vim.cmd.edit, {desc = "Revert current buffer"})
vim.keymap.set("n", "<LocalLeader>xG", vim.cmd.checktime, {desc = "Revert all buffers"})
vim.keymap.set("n", "<Leader>bd", "<Cmd>bp<Bar>bd #<CR>", {desc = "Delete current buffer"})
vim.keymap.set("n", "<LocalLeader>bb", "<Cmd>e #<CR>", {desc = "Switch to prev buffer"})
vim.keymap.set("n", "<M-j>", "<C-W>j", {desc = "Move cursor to the downside window"})
vim.keymap.set("n", "<M-k>", "<C-W>k", {desc = "Move cursor to the upside window"})
vim.keymap.set("n", "<M-h>", "<C-W>h", {desc = "Move cursor to the leftside window"})
vim.keymap.set("n", "<M-l>", "<C-W>l", {desc = "Move cursor to the rightside window"})
vim.keymap.set("n", "<LocalLeader>sq", "<C-W>q", {desc = "Close current window"})
vim.keymap.set("n", "<LocalLeader>sa", "<C-W>s", {desc = "Split window horizontal"})
vim.keymap.set("n", "<LocalLeader>sd", "<C-W>v", {desc = "Split window vertically"})
vim.keymap.set("n", "<LocalLeader>oo", "<C-W>o", {desc = "Keep current window only"})
vim.keymap.set("n", "<C-x>0", "<C-W>q", {desc = "Delete window"})
vim.keymap.set("n", "<C-x>1", "<C-W>o", {desc = "Delete other windows"})
vim.keymap.set("n", "<C-x>2", "<C-W>s", {desc = "Split window below"})
vim.keymap.set("n", "<C-x>3", "<C-W>v", {desc = "Split window right"})
vim.keymap.set("n", "<C-x>o", "<C-W><C-W>", {desc = "Other window"})
vim.keymap.set("n", "<Leader>to", vim.cmd.tabnew, {desc = "Open new tab"})
vim.keymap.set("n", "<Leader>tx", vim.cmd.tabclose, {desc = "Close current tab"})
vim.keymap.set("n", "<Leader>tn", vim.cmd.tabn, {desc = "Go to next tab"})
vim.keymap.set("n", "<Leader>tp", vim.cmd.tabp, {desc = "Go to previous tab"})
vim.keymap.set("n", "<Leader>tf", "<Cmd>tabnew %<CR>", {desc = "Open current buffer in new tab"})
vim.keymap.set("n", "<Leader>tt", "<Cmd>tab terminal<CR>", {desc = "Toggle terminal in tab"})
local function _3_()
  return vim.cmd.tabmove("-")
end
vim.keymap.set("n", "<Leader>th", _3_, {desc = "move tab left"})
local function _4_()
  return vim.cmd.tabmove("+")
end
vim.keymap.set("n", "<Leader>tl", _4_, {desc = "move tab right"})
local function _5_()
  return vim.cmd.tabmove("0")
end
vim.keymap.set("n", "<Leader>ta", _5_, {desc = "move tab first"})
local function _6_()
  return vim.cmd.tabmove("$")
end
vim.keymap.set("n", "<Leader>te", _6_, {desc = "move tab last"})
vim.keymap.set({"c", "i"}, "<C-A>", "<Home>", {desc = "Bol"})
vim.keymap.set({"c", "i"}, "<C-E>", "<End>", {desc = "Eol"})
vim.keymap.set({"c", "i"}, "<C-D>", "<Delete>", {desc = "Delete char"})
vim.keymap.set({"c", "i"}, "<C-F>", "<Right>", {desc = "Forward char"})
vim.keymap.set({"c", "i"}, "<C-B>", "<Left>", {desc = "Backward char"})
vim.keymap.set("i", "<C-N>", "<Down>", {desc = "Next line"})
vim.keymap.set("i", "<C-P>", "<Up>", {desc = "Prev line"})
vim.keymap.set("c", "<C-O>", "<C-F>", {desc = "Command"})
vim.keymap.set("n", "[b", vim.cmd.bprevious, {desc = "Prev buffer"})
vim.keymap.set("n", "]b", vim.cmd.bnext, {desc = "Next buffer"})
vim.keymap.set("n", "[B", vim.cmd.bfirst, {desc = "First buffer"})
vim.keymap.set("n", "]B", vim.cmd.blast, {desc = "Last buffer"})
vim.keymap.set("n", "[q", vim.cmd.cprev, {desc = "Prev quickfix"})
vim.keymap.set("n", "]q", vim.cmd.cnext, {desc = "Next quickfix"})
vim.keymap.set("n", "[Q", vim.cmd.cfirst, {desc = "First quickfix"})
vim.keymap.set("n", "]Q", vim.cmd.clast, {desc = "Last quickfix"})
vim.keymap.set("n", "[l", vim.cmd.lprev, {desc = "Prev location"})
vim.keymap.set("n", "]l", vim.cmd.lnext, {desc = "Next location"})
vim.keymap.set("n", "[L", vim.cmd.lfirst, {desc = "First location"})
vim.keymap.set("n", "]L", vim.cmd.llast, {desc = "Last location"})
vim.keymap.set("n", "[t", vim.cmd.tabprevious, {desc = "Prev tab"})
vim.keymap.set("n", "]t", vim.cmd.tabnext, {desc = "Next tab"})
vim.keymap.set("n", "[T", vim.cmd.tabfirst, {desc = "First tab"})
vim.keymap.set("n", "]T", vim.cmd.tablast, {desc = "Last tab"})
vim.keymap.set("n", "[<Space>", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", {desc = "Blank above"})
vim.keymap.set("n", "]<Space>", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>", {desc = "Blank below"})
local function diagnostic_goto(next, severity)
  local go = ((next and vim.diagnostic.goto_next) or vim.diagnostic.goto_prev)
  severity = ((severity and vim.diagnostic.severity[severity]) or nil)
  local function _7_()
    return go({severity = severity})
  end
  return _7_
end
local function diagnostic_toggle()
  if vim.diagnostic.is_enabled() then
    return vim.diagnostic.disable()
  else
    return vim.diagnostic.enable()
  end
end
vim.keymap.set("n", "<LocalLeader>xD", diagnostic_toggle, {desc = "Toggle Diagnostics"})
vim.keymap.set("n", "<LocalLeader>xd", vim.diagnostic.open_float, {desc = "Display Diagnostics"})
vim.keymap.set("n", "]d", diagnostic_goto(true), {desc = "Next Diagnostic"})
vim.keymap.set("n", "[d", diagnostic_goto(false), {desc = "Prev Diagnostic"})
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), {desc = "Next Error"})
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), {desc = "Prev Error"})
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), {desc = "Next Warning"})
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), {desc = "Prev Warning"})
return {}
