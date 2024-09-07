-- [nfnl] Compiled from fnl/plugins/frontend.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.g.user_emmet_install_global = 0
  vim.api.nvim_create_autocmd("FileType", {pattern = {"css", "html", "javascriptreact", "typescriptreact", "vue"}, command = "EmmetInstall"})
  vim.g.user_emmet_mode = "in"
  vim.g.user_emmet_leader_key = "<C-G>"
  return nil
end
return {{"mattn/emmet-vim", ft = {"css", "html", "javascriptreact", "typescriptreact", "vue"}, init = _1_}}
