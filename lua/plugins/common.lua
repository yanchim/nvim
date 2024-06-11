-- [nfnl] Compiled from fnl/plugins/common.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local surround = require("nvim-surround")
  return surround.setup()
end
return {{"bakpakin/fennel.vim", lazy = true, ft = {"fennel"}}, {"kylechui/nvim-surround", event = "VeryLazy", config = _1_}}
