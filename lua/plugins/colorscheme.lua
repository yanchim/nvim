-- [nfnl] Compiled from fnl/plugins/colorscheme.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return vim.cmd.colorscheme("tokyonight")
end
return {{"EdenEast/nightfox.nvim"}, {"Mofiqul/vscode.nvim"}, {"catppuccin/nvim", name = "catppuccin"}, {"folke/tokyonight.nvim", priority = 1000, config = _1_, lazy = false}, {"olimorris/onedarkpro.nvim"}, {"projekt0n/github-nvim-theme"}, {"rebelot/kanagawa.nvim"}}
