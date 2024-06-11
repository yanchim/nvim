-- [nfnl] Compiled from fnl/plugins/paredit.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local paredit = require("nvim-paredit")
  return paredit.setup()
end
local function _2_()
  local paredit_fnl = require("nvim-paredit-fennel")
  return paredit_fnl.setup()
end
local function _3_()
  local autopairs = require("nvim-autopairs")
  local autopairs_cmp = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")
  do end (cmp.event):on("confirm_done", autopairs_cmp.on_confirm_done())
  return autopairs.setup({check_ts = true})
end
return {{"julienvincent/nvim-paredit", lazy = true, ft = {"clojure", "fennel"}, config = _1_}, {"julienvincent/nvim-paredit-fennel", dependencies = {"julienvincent/nvim-paredit"}, lazy = true, ft = {"fennel"}, config = _2_}, {"windwp/nvim-autopairs", event = "InsertEnter", dependencies = {"hrsh7th/nvim-cmp"}, config = _3_}}
