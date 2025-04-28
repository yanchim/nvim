-- [nfnl] fnl/plugins/colorscheme.fnl
local function _1_()
  return vim.cmd.colorscheme("tokyonight")
end
return {{"EdenEast/nightfox.nvim"}, {"Mofiqul/vscode.nvim"}, {"catppuccin/nvim", name = "catppuccin"}, {"folke/tokyonight.nvim", priority = 1000, config = _1_, lazy = false}, {"letorbi/vim-colors-modern-borland", name = "borland"}, {"olimorris/onedarkpro.nvim"}, {"projekt0n/github-nvim-theme"}, {"rebelot/kanagawa.nvim"}}
