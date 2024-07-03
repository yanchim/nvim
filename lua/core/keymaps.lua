-- [nfnl] Compiled from fnl/core/keymaps.fnl by https://github.com/Olical/nfnl, do not edit.
vim.keymap.set("n", "<space>", "<nop>", {noremap = true})
vim.keymap.set("n", "<localleader>dd", "<cmd>cd %:h<CR>", {desc = "Change cwd to current file"})
vim.keymap.set("n", "<localleader>w", vim.cmd.write, {desc = "Write current file"})
vim.keymap.set("n", "<localleader>Q", vim.cmd.quitall, {desc = "Quit"})
vim.keymap.set("t", "jk", "<C-\\><C-N>", {desc = "Exit terminal INSERT mode"})
vim.keymap.set("n", "<leader>bd", "<cmd>bp<bar>bd #<CR>", {desc = "Delete current buffer"})
vim.keymap.set("n", "<localleader>xx", "<cmd>bp<bar>bd #<CR>", {desc = "Delete current buffer"})
vim.keymap.set("n", "<localleader>xl", vim.cmd.lopen, {desc = "Location list"})
vim.keymap.set("n", "<localleader>xq", vim.cmd.copen, {desc = "Quickfix list"})
vim.keymap.set("n", "<localleader>bb", "<cmd>e #<CR>", {desc = "Switch to current buffer"})
vim.keymap.set({"i", "n"}, "<C-x><C-s>", vim.cmd.update, {desc = "Save buffer"})
vim.keymap.set("n", "<M-j>", "<C-w>j", {desc = "Move cursor to the downside window"})
vim.keymap.set("n", "<M-k>", "<C-w>k", {desc = "Move cursor to the upside window"})
vim.keymap.set("n", "<M-h>", "<C-w>h", {desc = "Move cursor to the leftside window"})
vim.keymap.set("n", "<M-l>", "<C-w>l", {desc = "Move cursor to the rightside window"})
vim.keymap.set("n", "<localleader>sq", "<C-w>q", {desc = "Close current window"})
vim.keymap.set("n", "<localleader>sa", "<C-w>s", {desc = "Split window horizontal"})
vim.keymap.set("n", "<localleader>sd", "<C-w>v", {desc = "Split window vertically"})
vim.keymap.set("n", "<localleader>oo", "<C-w>o", {desc = "Keep current window only"})
vim.keymap.set("n", "<C-x>0", "<C-w>q", {desc = "Delete window"})
vim.keymap.set("n", "<C-x>1", "<C-w>o", {desc = "Delete other windows"})
vim.keymap.set("n", "<C-x>2", "<C-w>s", {desc = "Split window below"})
vim.keymap.set("n", "<C-x>3", "<C-w>v", {desc = "Split window right"})
vim.keymap.set("n", "<C-x>o", "<C-w><C-w>", {desc = "Other window"})
vim.keymap.set("n", "<leader>to", vim.cmd.tabnew, {desc = "Open new tab"})
vim.keymap.set("n", "<leader>tx", vim.cmd.tabclose, {desc = "Close current tab"})
vim.keymap.set("n", "<leader>tn", vim.cmd.tabn, {desc = "Go to next tab"})
vim.keymap.set("n", "<leader>tp", vim.cmd.tabp, {desc = "Go to previous tab"})
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", {desc = "Open current buffer in new tab"})
vim.keymap.set("n", "<leader>tt", "<cmd>tab terminal<CR>", {desc = "Toggle terminal in tab"})
vim.keymap.set({"c", "i"}, "<C-a>", "<Home>", {desc = "Bol"})
vim.keymap.set({"c", "i"}, "<C-e>", "<End>", {desc = "Eol"})
vim.keymap.set({"c", "i"}, "<C-d>", "<Delete>", {desc = "Delete char"})
vim.keymap.set({"c", "i"}, "<C-f>", "<Right>", {desc = "Forward char"})
vim.keymap.set({"c", "i"}, "<C-b>", "<Left>", {desc = "Backward char"})
vim.keymap.set("i", "<C-n>", "<Down>", {desc = "Next line"})
vim.keymap.set("i", "<C-p>", "<Up>", {desc = "Prev line"})
vim.keymap.set("c", "<C-o>", "<C-f>", {desc = "Command"})
vim.keymap.set("n", "[b", vim.cmd.bprevious, {desc = "Prev buffer"})
vim.keymap.set("n", "]b", vim.cmd.bnext, {desc = "Next buffer"})
vim.keymap.set("n", "[B", vim.cmd.bfirst, {desc = "First buffer"})
vim.keymap.set("n", "]B", vim.cmd.blast, {desc = "Last buffer"})
vim.keymap.set("n", "[q", vim.cmd.cprev, {desc = "Prev quickfix"})
vim.keymap.set("n", "]q", vim.cmd.cnext, {desc = "Next quickfix"})
vim.keymap.set("n", "[Q", vim.cmd.cfirst, {desc = "First quickfix"})
vim.keymap.set("n", "]Q", vim.cmd.clast, {desc = "Last quickfix"})
vim.keymap.set("n", "[t", vim.cmd.tabprevious, {desc = "Prev tab"})
vim.keymap.set("n", "]t", vim.cmd.tabnext, {desc = "Next tab"})
vim.keymap.set("n", "[T", vim.cmd.tabfirst, {desc = "First tab"})
vim.keymap.set("n", "]T", vim.cmd.tablast, {desc = "Last tab"})
vim.keymap.set("n", "[<space>", "<cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", {desc = "Blank above"})
vim.keymap.set("n", "]<space>", "<cmd>call append(line('.'),     repeat([''], v:count1))<CR>", {desc = "Blank below"})
local function diagnostic_goto(next, severity)
  local go = ((next and vim.diagnostic.goto_next) or vim.diagnostic.goto_prev)
  severity = ((severity and vim.diagnostic.severity[severity]) or nil)
  local function _1_()
    return go({severity = severity})
  end
  return _1_
end
vim.keymap.set("n", "<localleader>xd", vim.diagnostic.open_float, {desc = "Line Diagnostics"})
vim.keymap.set("n", "]d", diagnostic_goto(true), {desc = "Next Diagnostic"})
vim.keymap.set("n", "[d", diagnostic_goto(false), {desc = "Prev Diagnostic"})
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), {desc = "Next Error"})
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), {desc = "Prev Error"})
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), {desc = "Next Warning"})
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), {desc = "Prev Warning"})
return {}
