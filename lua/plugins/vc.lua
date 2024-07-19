-- [nfnl] Compiled from fnl/plugins/vc.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(buf)
  local gs = require("gitsigns")
  local function _2_()
    return gs.blame_line({full = true})
  end
  vim.keymap.set("n", "<Leader>glb", _2_, {desc = "Blame line"})
  vim.keymap.set("n", "<Leader>glB", gs.toggle_current_line_blame, {desc = "Toggle line blame"})
  vim.keymap.set("n", "<Leader>gbs", gs.stage_buffer, {desc = "Stage buffer"})
  vim.keymap.set("n", "<Leader>gbr", gs.reset_buffer, {desc = "Reset buffer"})
  vim.keymap.set("n", "<Leader>gd", gs.diffthis, {desc = "Diff this"})
  vim.keymap.set("n", "<Leader>ghs", gs.stage_hunk, {desc = "Stage hunk"})
  vim.keymap.set("n", "<Leader>ghr", gs.reset_hunk, {desc = "Reset hunk"})
  vim.keymap.set("n", "[h", gs.prev_hunk, {desc = "Prev hunk"})
  return vim.keymap.set("n", "]h", gs.next_hunk, {desc = "Next hunk"})
end
local function _3_()
  local neogit = require("neogit")
  local function _4_()
    return neogit.open({"commit"})
  end
  vim.keymap.set("n", "<Leader>gc", _4_, {desc = "Open commit popup"})
  vim.keymap.set("n", "<Leader>gn", neogit.open, {desc = "Neogit status"})
  local function _5_()
    return neogit.open({cwd = "%:p:h"})
  end
  vim.keymap.set("n", "<Leader>gg", _5_, {desc = "Current buffer Neogit status"})
  return neogit.setup()
end
return {{"lewis6991/gitsigns.nvim", event = {"BufReadPre", "BufNewFile"}, opts = {on_attach = _1_}}, {"NeogitOrg/neogit", dependencies = {"nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim"}, config = _3_}}
