-- [nfnl] Compiled from fnl/plugins/theme.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return vim.cmd.colorscheme("tokyonight")
end
return {{"catppuccin/nvim", name = "catppuccin", lazy = false}, {"rebelot/kanagawa.nvim", lazy = false}, {"folke/tokyonight.nvim", priority = 1000, config = _1_, lazy = false}}
