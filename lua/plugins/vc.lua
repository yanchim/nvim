-- [nfnl] Compiled from fnl/plugins/vc.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(buf)
  local gs = require("gitsigns")
  local function _2_()
    return gs.blame_line({full = true})
  end
  vim.keymap.set("n", "<leader>gb", _2_, {desc = "Blame line"})
  vim.keymap.set("n", "<leader>gB", gs.toggle_current_line_blame, {desc = "Toggle line blame"})
  vim.keymap.set("n", "<leader>gs", gs.stage_buffer, {desc = "Stage buffer"})
  vim.keymap.set("n", "<leader>gr", gs.reset_buffer, {desc = "Reset buffer"})
  vim.keymap.set("n", "<leader>gd", gs.diffthis, {desc = "Diff this"})
  vim.keymap.set("n", "<leader>ghs", gs.stage_hunk, {desc = "Stage hunk"})
  vim.keymap.set("n", "<leader>ghr", gs.reset_hunk, {desc = "Reset hunk"})
  vim.keymap.set("n", "[h", gs.prev_hunk, {desc = "Prev hunk"})
  return vim.keymap.set("n", "]h", gs.next_hunk, {desc = "Next hunk"})
end
local function _3_()
  local neogit = require("neogit")
  vim.keymap.set("n", "<leader>gc", "<cmd>Neogit commit<CR>", {desc = "Open commit popup"})
  vim.keymap.set("n", "<leader>gt", "<cmd>Neogit<CR>", {desc = "Neogit status"})
  vim.keymap.set("n", "<leader>gg", "<cmd>Neogit cwd=%:p:h<CR>", {desc = "Current buffer Neogit status"})
  return neogit.setup()
end
return {{"lewis6991/gitsigns.nvim", event = {"BufReadPre", "BufNewFile"}, opts = {on_attach = _1_}}, {"NeogitOrg/neogit", dependencies = {"nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim"}, config = _3_}}
